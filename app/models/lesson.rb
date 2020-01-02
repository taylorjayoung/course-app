class Lesson < ApplicationRecord
  belongs_to :section

  include RankedModel
  ranks :row_order, with_same: :section_id


  def next_section
    section = course.sections.where("row_order > ?", self.row_order).rank(:row_order).first
    if lesson.blank? && section.next_section
      return section.next_section.lessons.rank(:row_order).first
    end
    return section
  end


end
