Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276585AbRI2Sgj>; Sat, 29 Sep 2001 14:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276584AbRI2Sg3>; Sat, 29 Sep 2001 14:36:29 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:41739 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S276583AbRI2SgP>; Sat, 29 Sep 2001 14:36:15 -0400
From: "J.H.M. Dassen (Ray)" <jdassen@cistron.nl>
Subject: Re: Makefile gcc -o /dev/null: the dissapearing of /dev/null
Date: Sat, 29 Sep 2001 18:36:42 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <slrn9rc55q.rhu.jdassen@odin.cistron-office.nl>
In-Reply-To: <20010929114304.A21440@lug-owl.de> <Pine.LNX.4.33.0109290535390.25966-100000@cerberus.stardot-tech.com>
X-Trace: ncc1701.cistron.net 1001788602 9251 195.64.65.236 (29 Sep 2001 18:36:42 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Treadway <jim@stardot-tech.com> wrote:
> On Sat, 29 Sep 2001, Jan-Benedict Glaw wrote:
>> No. Why? Well, the Linux kernel compiles just fine while being an
>> ordianary user.

> So then you can no longer 'make modules && make modules_install', or you
> have to cp or chown /usr/src/linux on a fresh install to compile your
> kernel?   Doesn't sound pleasant to me.

I use that all the time, through the scripts in Debian's "kernel-package":
	cd /usr/local/src/linux
	cp /boot/config-some-recent-version .config
	make oldconfig
	fakeroot make-kpkg kernel_image modules_image
	dpkg -i ../kernel-image...deb ../alsa-modules-...deb

I find this quite comfortable: I always know where to find old configs, have
a matching System.map installed, can clean up old kernels and modules easily
etc.

Ray
-- 
What is this talk of software 'releases'? Klingons do not 'release'
software; our software ESCAPES, leaving a bloody trail of designers and
quality assurance people in its wake!

