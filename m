Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278218AbRKHUsQ>; Thu, 8 Nov 2001 15:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278205AbRKHUsH>; Thu, 8 Nov 2001 15:48:07 -0500
Received: from 24.213.60.124.up.mi.chartermi.net ([24.213.60.124]:28313 "EHLO
	front2.chartermi.net") by vger.kernel.org with ESMTP
	id <S278218AbRKHUsD>; Thu, 8 Nov 2001 15:48:03 -0500
Date: Thu, 8 Nov 2001 14:49:53 -0600 (CST)
From: Cheryl Homiak <chomiak@chartermi.net>
To: linux-kernel@vger.kernel.org
Subject: loopback device problem and unrequested modules trying to load:
 linux-2.4.14
Message-ID: <Pine.LNX.4.40.0111081437370.368-100000@maranatha>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I experienced dependency problems with the 2.2.14 kernel when I tried to
compile in loopback block device, as others have reported. In addition to
this,modprobe was looking for modules which I had not had installed:
sound-service0-0 and sound-slot (may not have the module names verbatim).
I have sound support compiled in to the kernel; there should be no sound
modules loading, and I didn't have any loading before compiling this
kernel. when I rebooted with my oldkernel, those modules were no longer
trying to load. I should clarify that the modules weren't actually
loading; modprobe was trying to find them and couldn't. I double-checked
my config to make sure I hadn't requested any modules for sound by
accident.

