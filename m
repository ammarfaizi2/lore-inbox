Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUDJQi0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 12:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbUDJQi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 12:38:26 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:25848 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S262056AbUDJQiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 12:38:24 -0400
Date: Sat, 10 Apr 2004 18:37:58 +0200
From: legion <legion@birra.it>
To: linux-kernel@vger.kernel.org
Subject: Total freeze switching X->fb (matrox)
Message-ID: <20040410163758.GA7704@lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this problem with linux 2.6 (2.4 was ok).
I hope this is the right place to report this, it may be related with
"drm" mga module..

The problem is: framebuffer (matroxfb) works fine, X (xfree 4.3 or Xorg
6.7) works fine, but sometimes when i hit "ctrl alt F1" for switching
on the console, the system freeze.
It's not only a xfree freeze: no SysRq reboot and no working network
(sshd is not responding). hard freeze.
This happen *sometimes* : i switch between X and console many times
during the day, the box freeze only 2-3 times a day.

I don't known where to go to find the problem, the only interesting
element i have is:

2.4:
kernel: [drm] AGP 0.99 Aperture @ 0xe0000000 64MB
kernel: [drm] Initialized mga 3.0.2 20010321 on minor 0
2.6:
kernel: [drm] Initialized mga 3.1.0 20021029 on minor 0
kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
kernel: agpgart: Putting AGP V2 device at 0000:02:00.0 into 1x mode

may the problem be related with the newer version of the module?

any idea?

my stuffs:

video card: Matrox G400 DH on nvidia nforce2 motherboard
kernel: vanilla 2.6.3+ (nforce2 agp/matrox drm/matroxfb support)
X server: Xfree 4.3.0 or Xorg r6.7 using "mga" driver

thanks.
