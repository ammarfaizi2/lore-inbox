Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbRF1XmE>; Thu, 28 Jun 2001 19:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265244AbRF1Xly>; Thu, 28 Jun 2001 19:41:54 -0400
Received: from four.malevolentminds.com ([216.177.76.238]:46345 "EHLO
	four.malevolentminds.com") by vger.kernel.org with ESMTP
	id <S265097AbRF1Xll>; Thu, 28 Jun 2001 19:41:41 -0400
Date: Thu, 28 Jun 2001 16:41:34 -0700 (PDT)
From: Khyron <khyron@khyron.com>
X-X-Sender: <khyron@four.malevolentminds.com>
To: <linux-kernel@vger.kernel.org>
Subject: _syscall4, wake_up_interruptible(), and PID table questions
Message-ID: <Pine.BSF.4.33.0106281440390.39434-100000@four.malevolentminds.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, since my last e-mail generated no interest, I thought
I'd refine my queries:

1. wake_up_interruptible()

I am reading
http://www.citi.umich.edu/projects/linux-scalability/reports/accept.html
and the my question is what solution to the "thundering herd" problem
was eventually chosen and is implemented in the 2.4.x kernels? Where
can I find more specific information on this implementation? Source
code references are welcome.

2. _syscall4

After reading http://www.kegel.com/c10k.html, I have to wonder
how exactly sendfile() was implemented in the 2.4.x kernels?
Where in the source can I find information? Is there any published
documentation on this subject as well?

3. PID table resizing

I understand that it is possible to resize the PID table in the
2.4.x kernels? Is this true or misinformation? If true, what do
I need to do? Is this a source edit, a compile-time configuration
option or a runtime option? If a source edit, which file(s)?

Thanks in advance!

////////////////////////////////////////////////////////////////////
Khyron					    mailto:khyron@khyron.com
Key fingerprint = 53BB 08CA 6A4B 8AF8 DF9B  7E71 2D20 AD30 6684 E82D
			"Drama free in 2001!"
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\



