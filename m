Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267143AbTAKUnJ>; Sat, 11 Jan 2003 15:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTAKUnJ>; Sat, 11 Jan 2003 15:43:09 -0500
Received: from public1-brig1-3-cust85.brig.broadband.ntl.com ([80.0.159.85]:7176
	"EHLO ppg_penguin.kenmoffat.uklinux.net") by vger.kernel.org
	with ESMTP id <S267143AbTAKUnI>; Sat, 11 Jan 2003 15:43:08 -0500
Date: Sat, 11 Jan 2003 20:51:50 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre3 : i8253 count too high! resetting..
Message-ID: <Pine.LNX.4.21.0301112040390.5280-100000@ppg_penguin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I've just started running pre3, and after a few minutes the above
message started to appear. I can see it is coming from
i386/kernel/timer.c, but beyond that I'm out of my depth, so I'll just
report it for my betters.

 I remember that in earlier versions of 2.4 there was a sporadic timer
message, along the lines of "probably via" (?) which also affected this
box. 

 The CPU is a K6-2, on a Jetway 542C mobo. lspci shows an Ali M1541 (rev
04) host bridge and PCI bridge, with an Ali M1533 (rev c3) PCI to ISA
bridge and a M5229 IDE i/f (rev c2). Compiler was gcc-2.95.3.

 Any more information anybody would like ?

Ken
-- 
 Out of the darkness a voice spake unto me, saying "smile, things could be
worse". So I smiled, and lo, things became worse.



