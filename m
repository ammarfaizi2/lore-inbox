Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTFKRVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTFKRVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:21:49 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:42004 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S262593AbTFKRVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:21:49 -0400
Date: Wed, 11 Jun 2003 13:32:33 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Severe Issues with Compaq Presario
To: linux-kernel@vger.kernel.org
Message-id: <200306111332330240.0094D223@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone have experience with the Compaq Presario laptop series?  My
specific model is a customized 2100, with AMD K7 Athlon XP 2400+ 1.8 GHZ
CPU; 512MB * PC2100 DDR RAM; 60 GB toshiba HDD; ALi 5451 sound
chipset; and a DVD/CDRW.

The ALSA drivers load for the sound card and can control it; however, I can't
seem to unmute it.

There's also the issue that certain kernel configurations (i.e. Debian's stock
2.4 kernel when you boot bf24 on Woody's install CD) cause the keyboard
and mouse to stop doing anything.  Of course the kernel runs fine, it just
can't get any input from me!  This one time was triggered at the exact same
time that messages from usb.c appeared on my terminal.

Also, when KDE does peripheral detection, or when Xine starts, X suddenly
gets Sig4 (SIGILL).  I can load Gnome and IceWM fine, and then when I load
Xine (DVD player), X suddenly dies from SIGILL.

I've been using custom compiled 2.2.22 and 2.4.18 kernels, restricted to pure
i386 architecture in case the CPU is missing some extensions.  It doesn't
seem to help, though; but we can rule out missing extensions in CPU arch
as the problem.

Does anyone have any ideas?  Please mail me personally.  I've reinstalled about
10 times already and been debugging for hours, with no luck.

--Bluefox

