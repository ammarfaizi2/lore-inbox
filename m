Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWH1GQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWH1GQR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 02:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWH1GQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 02:16:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14571 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751399AbWH1GQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 02:16:16 -0400
Date: Sun, 27 Aug 2006 23:14:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc5
Message-Id: <20060827231421.f0fc9db1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 21:30:50 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Linux 2.6.18-rc5 is out there now

(Reporters Bcc'ed: please provide updates)

Serious-looking regressions include:


http://bugzilla.kernel.org/show_bug.cgi?id=7062 (HPET)

From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0

From: "Uwe Bugla" <uwe.bugla@gmx.de>
Subject: keyboard errors with module atkbd.c in Kernel 2.6.18-rc4

From: Olaf Hering <olaf@aepfle.de>
Subject: oops in __delayacct_blkio_ticks with 2.6.18-rc4

From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Possible memory leak in kernel/delayacct.c

From: walt <kernel@nea-fast.com>
Subject: Sound not working correctly as of 2.6.15-rc1

From: Johan Rutgeerts <johan.rutgeerts@mech.kuleuven.be>
Subject: Acpi oops 2.6.17.7 vanilla

From: Andrew Benton <b3nt@ukonline.co.uk>
Subject: ALSA problems with 2.6.18-rc3

From: Sean Bruno <sean.bruno@dsl-only.net>
Subject: [BUG] Kernel Panic from AHD when power cycling external Disk/Array

From: "Beschorner Daniel" <Daniel.Beschorner@facton.com>
Subject: fctnl(F_SETSIG) no longer works in 2.6.17, does in 2.6.16.

  (I think we fixed this?)

From: Keith Owens <kaos@ocs.com.au>
Subject: 2.6.18-rc4 Intermittent failures to detect sata disks

From: "Zephaniah E. Hull" <warp@aehallh.com>
Subject: [patch] Crash on evdev disconnect.

From: Andreas Barth <aba@not.so.argh.org>
Subject: Re: Fw: gdth SCSI driver(?) fails with more than 4GB of memory

  (Long saga - attempts were made to fix it but I think we're stumped?)

From: Andi Kleen <ak@suse.de>
Subject: Futex BUG in 2.6.18rc2-git7

From: Elias Holman <eholman@holtones.com>
Subject: PROBLEM: PCI/Intel 82945 trouble on Toshiba M400 notebook

From: "Alex Polvi" <polvi@google.com>
Subject: [PATCH] sunrpc/auth_gss: NULL pointer deref in gss_pipe_release()

From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Subject: Re: Linux v2.6.18-rc3

  (USB Audio regression)


That list is maybe a quarter of my list of "recently reported regressions
which haven't been pushed into bugzilla yet".  There are many more in
bugzilla.  We have a lot of regressions.

