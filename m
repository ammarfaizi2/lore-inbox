Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSJNJDz>; Mon, 14 Oct 2002 05:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261897AbSJNJDz>; Mon, 14 Oct 2002 05:03:55 -0400
Received: from [203.200.31.3] ([203.200.31.3]:25489 "EHLO btlmail.bplmail.com")
	by vger.kernel.org with ESMTP id <S261894AbSJNJDy>;
	Mon, 14 Oct 2002 05:03:54 -0400
Message-ID: <00ec01c27300$0f31a060$990d0a0a@bpldj7ls7op535>
From: "Sunil Kumar T" <t.sunilkumar@bplmail.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
       "Petr Vandrovec" <vandrove@vc.cvut.cz>
Cc: "James Simmons" <jsimmons@infradead.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0210141020550.9580-100000@vervain.sonytel.be>
Subject: Display driver.
Date: Sun, 13 Oct 2002 14:32:41 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am planning to write a display  driver for the chip(MD2406)  which is
having ARM7TDMI core.
This chip is having a display interface and JPEG engine.

The purpose is to take JPEG file from user space decode the JPEG file using
hardware decoder in the chip. Display the the jpeg file.

I would like to know from you experts, Should I go for Frame Buffer driver
for this function.

Its able to do the display of jpeg file only from the processor without
using linux.
I am new to display driver. Can I by pass frame buffer method and do the
SDRAM (Display ram) memory acesses directly and acomplish the task. I mean
can I do this driver by using ioctl, and write statement alone. As a normal
charactor driver.
Is there any problem in doing so.
Regards


SunilKumar.T
Sr. Design Engineer
Software and Embedded Systems Group,
BPL TELECOM LTD.
11th K. M., Bannerghatta Road,
Bangalore 560076.
Ph. No.91-80- 6589080 etx.2058





