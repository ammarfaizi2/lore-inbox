Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRABM7X>; Tue, 2 Jan 2001 07:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbRABM7N>; Tue, 2 Jan 2001 07:59:13 -0500
Received: from [203.200.144.37] ([203.200.144.37]:30988 "HELO
	nest.stpt.soft.net") by vger.kernel.org with SMTP
	id <S129737AbRABM6z>; Tue, 2 Jan 2001 07:58:55 -0500
Organization: NeST India
Message-ID: <F6E1228667B6D411BAAA00306E00F2A5546DB5@pdc2.nestec.net>
From: MOHAMMED AZAD <mohammedazad@nestec.net>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: reg: Using mmap in 2.0.32 kernel..
Date: Tue, 2 Jan 2001 17:56:36 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am trying to mmap some kernel ram into user space... These r the steps i
followed..

1) Allocate memory in kernel using get_free_pages..
2) reserve these pages using mem_map_reserve macro
3) In the mmap () implementation i use remap_page_range to export the buffer
to user space..


All this works well in kernel ver 2.2.14 but i am not getting it right in
2.0.32... any idea why???

thanks in advance

azad
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
