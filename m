Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129608AbRB0Qzs>; Tue, 27 Feb 2001 11:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbRB0Qzk>; Tue, 27 Feb 2001 11:55:40 -0500
Received: from [194.67.35.250] ([194.67.35.250]:13275 "HELO skif.spylog.net")
	by vger.kernel.org with SMTP id <S129608AbRB0Qz0>;
	Tue, 27 Feb 2001 11:55:26 -0500
Message-ID: <004901c0a0de$2647d6c0$0e04a8c0@iv>
From: "Ivan Stepnikov" <iv@spylog.com>
To: <linux-kernel@vger.kernel.org>
Subject: Memory allocation
Date: Tue, 27 Feb 2001 19:55:54 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello!
I encountered with problem: one process can not allocate more then 2Gb of
memory. Kernel compiled with CONFIG_HIGHMEM4G=y, CONFIG_HIGHMEM=y. Kernel is
2.4.0

As far as I know on i386 linux process has got 32 bit address space. It
means that actually about 3Gb of memory should be available.

I tried to call getrlimit(). It shows only 2G available memory and there is
no way to increase it.

Could you say me are there any solutions? Might be on i386 linux process can
not use more than 2Gb of memory de facto? But I don't see the reason for it:
there is unsigned long type uses everywhere in kernel sources for memory
allocation.


--
Regards,
Ivan Stepnikov.

