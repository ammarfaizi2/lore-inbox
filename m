Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRBVMid>; Thu, 22 Feb 2001 07:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129374AbRBVMiN>; Thu, 22 Feb 2001 07:38:13 -0500
Received: from braga01-cm047.bragatel.pt ([195.61.74.47]:56711 "EHLO
	nsk.yi.org") by vger.kernel.org with ESMTP id <S129284AbRBVMiG>;
	Thu, 22 Feb 2001 07:38:06 -0500
Date: Thu, 22 Feb 2001 12:34:10 -0500
From: Luciano Miguel Ferreira Rocha <strange@nsk.yi.org>
To: linux-kernel@vger.kernel.org
Subject: Loop dev & 2.4.2
Message-ID: <20010222123410.A3527@nsk.yi.org>
Reply-To: strange@nsk.yi.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Disclaimer: 'Author of this message is not responsible for any harm done to reader's computer.'
Organization: 'NSK'
Section: 'Admin'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I want to report a constant problem I'm having with the loopback block driver
in the new releases of the 2.4.x series of the Linux kernel.

The problem is that when that when trying to use a loop device the process
hangs (whether it is mount/mke2fs, etc, but not losetup). And it can't be
killed...

It only started doing that in the 2.4.1-ac18, it worked fine in the 2.4.0 and
2.4.1 versions. I didn't said anything before because I expected the problem
to go way (or to never show up) in the 2.4.2 version.

Btw, the kernel shows no error messages whatsoever.

Here's some info:
2 systems tested, all running redhat 7.0, kernel compiled wi
gcc-2.91.66/egcs-1.1.2 (kgcc)

Celeron/Mendocino			Celeron/Coppermine
450MHz (orig 300 :)			666
256, sometimes 512 Mb RAM		128
mb 440 BX				VIA VT82C691/VT82C59[68]?

Relevant upgrades for 2.4.x series:
util-linux-2.10p-4			util-linux-2.10p-4
mount-2.10r-2				modutils-2.4.2-1
modutils-2.4.2-1			binutils-2.10.1.0.4-1
binutils-2.10.1.0.4-1

(tried 2.4.0,2.4.1 + int/crypto: OK	(2.4.1: OK, 2.4.2: not ok)
2.4.1-ac18/ac-19, 2.4.2, not ok (w/o int)

I hope this helps...

Also, I'm not subscribed in the lkml, so please CC: me.

hugs
	Luciano Rocha (strange@nsk.yi.org)
