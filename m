Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbSL0Bbz>; Thu, 26 Dec 2002 20:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSL0Bby>; Thu, 26 Dec 2002 20:31:54 -0500
Received: from boo-mda02.boo.net ([216.200.67.22]:58379 "EHLO
	boo-mda02.boo.net") by vger.kernel.org with ESMTP
	id <S264716AbSL0Bbx>; Thu, 26 Dec 2002 20:31:53 -0500
Message-Id: <3.0.6.32.20021226204855.007e4e30@boo.net>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Thu, 26 Dec 2002 20:48:55 -0500
To: linux-kernel@vger.kernel.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: panic during boot: 2.5.53 on alpha
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello. I'm a 2.5 newbie, and hopefully someone can tell me what I'm doing wrong here.

Turning off module support lets the 2.5.53 kernel compile on an Alpha, but
when booting on a DS10 the kernel claims that the argument to "root=" is
invalid, fails to mount the root filesystem, and panics. 

The 2.2 and 2.4 kernels all worked fine with "root=/dev/hda3". The machine
has a single IDE drive; /boot is mounted on hda1, /tmp on hda2, and / on hda3.
The gzipped vmlinux and System.map are both in /boot.

There were some patches for 2.5.52 posted last week for Alpha, but most of the
patch contents were to enable module support which I don't care about at the
moment. 

Apologies if this is a known issue, or if it's just something dumb that I'm doing. I can provide my config file if anyone's interested.

Thanks in advance,
jasonp



