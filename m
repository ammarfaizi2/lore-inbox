Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312949AbSDGExO>; Sat, 6 Apr 2002 23:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSDGExN>; Sat, 6 Apr 2002 23:53:13 -0500
Received: from smtp.comcast.net ([24.153.64.2]:20073 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S312949AbSDGExN>;
	Sat, 6 Apr 2002 23:53:13 -0500
Date: Sat, 06 Apr 2002 23:53:07 -0500
From: Steve Snyder <swsnyder@insightbb.com>
Subject: Errors in 2.4.18 cs46xx driver
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: swsnyder@insightbb.com
Message-id: <0GU600AY9LKK55@mtaout02.icomcast.net>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=iso-8859-15
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While playing the game Doom Legacy (v1.32beta4), the sound suddenly quit 
on me.  After exiting the game I found these entries in my system log:

Apr  6 22:54:58 mercury kernel: cs46xx: powerdown DAC failed
Apr  6 22:54:58 mercury kernel: cs46xx: cs_release_mixdev() powerdown DAC 
failure (0x1)

My kernel:
Linux version 2.4.18 (root@mercury.snydernet.lan) (gcc version 2.96 
20000731 (Red Hat Linux 7.1 2.96-98)) #1 SMP Mon Feb 25 19:45:39 EST 2002

This is with a Turtle Beach Santa Cruz sound card.  The card is 
apparently not sharing an IRQ with any other devices.

Is this a problem that can somehow be worked around by a lowly end user?

Thanks.
