Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273141AbRJDI6V>; Thu, 4 Oct 2001 04:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRJDI6N>; Thu, 4 Oct 2001 04:58:13 -0400
Received: from web11805.mail.yahoo.com ([216.136.172.159]:57871 "HELO
	web11805.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S273141AbRJDI6E>; Thu, 4 Oct 2001 04:58:04 -0400
Message-ID: <20011004085833.29209.qmail@web11805.mail.yahoo.com>
Date: Thu, 4 Oct 2001 10:58:33 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: specific optimizations for unaccelerated framebuffers
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Just a question:

 Has anybody ever tried to have a copy of the video memory in the main
 memory. All the software would access the copy in main memory, and
 the standart DMA is used (permanently) to update the real video memory.
 Maybe a 32 bit int could be used to skip unmodified 64K pages (1 bit
 per page).
 The main processor would never have to wait for PCI read/writes.

  In fact the question is: what kind of bandwidth can we have from a
 standart PC DMA (memory to memory copy)?
  The other problem could be the addresses limits, but using the VESA1
 interface (window switching at 0xA0000), the video memory image
 below 16 Mb and known I/O ports (see Gujin) would solve that.

  Someone has bandwidth measures?
  Etienne.

___________________________________________________________
Do You Yahoo!? -- Un e-mail gratuit @yahoo.fr !
Yahoo! Courrier : http://fr.mail.yahoo.com
