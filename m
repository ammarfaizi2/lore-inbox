Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbTBHUeQ>; Sat, 8 Feb 2003 15:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbTBHUeP>; Sat, 8 Feb 2003 15:34:15 -0500
Received: from [81.2.122.30] ([81.2.122.30]:25604 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267117AbTBHUeP>;
	Sat, 8 Feb 2003 15:34:15 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302082045.h18Kj1xc000316@darkstar.example.net>
Subject: [Kernel Bug Database] Bug report 34 - Matrox framebuffer drivers don't compile
To: linux-kernel@vger.kernel.org
Date: Sat, 8 Feb 2003 20:45:00 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Automatically added comment on 8th Feb 2003 at 11:19:50
New bug added. 
The following kernel versions were initially submitted as broken: 2.5.59


Comment by guest on 8th Feb 2003 at 11:19:50
Debian system, gcc version 3.2.2 20030131 (Debian prerelease). 

make menuconfig 
mane bzImage 
-> in drivers/video/matrox 

when compiling matroxfb_base.c 

gcc cannot find 
video/fbcon.h (included in through matroxfb_base.h) 
video/fbcon-cfb4.h (included in through matroxfb_base.h) 
video/fbcon-cfb8.h (included in through matroxfb_base.h) 
video/fbcon-cfb16.h (included in through matroxfb_base.h) 
video/fbcon-cfb32.h (included in through matroxfb_base.h) 

Comment by john on 8th Feb 2003 at 11:51:25
See confirmed bug 8
