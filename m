Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279462AbRKOKpG>; Thu, 15 Nov 2001 05:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279884AbRKOKo4>; Thu, 15 Nov 2001 05:44:56 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:29082 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S279462AbRKOKom>; Thu, 15 Nov 2001 05:44:42 -0500
Date: Thu, 15 Nov 2001 10:44:26 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: <alastair@gurney>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: <linux-kernel@vger.kernel.org>
Subject: [OT] Athlon SMP blues - SOLVED by gpm
In-Reply-To: <E1646xi-00015T-00@gondolin.me.apana.org.au>
Message-ID: <Pine.GSO.4.33.0111151041080.14971-100000@gurney>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I installed Red Hat 7.2 and the machine boots fine, using SMP or UP
> > kernels (Red Hat 2.4.9-7), but totally HANGS at the login prompt. Can't
> > type, can't reboot, can't do anything. Single user mode _does_ let me
> > in, however, and this is the only progress so far.
>
> Try plugging in a mouse or stop running gpm.

YES YES YES!!! This was it! After 24 hours of building 17 different
kernels, checking out every inch of my hardware, and trying to build
ramdisk images, it was the humble 'gpm' that caused my headaches!
There's no mouse on the machine. Thanks very much indeed, and boy have I
learned something now....

PS - thanks to all who sent in lots of ideas on this problem! It
actually turns out the machine is *not* overheating at all. The 76C BIOS
CPU temperature was erroneous, and in fact it's more like 42C now, which
is perfectly healthy of course ;-)

Cheers
Alastair

o o o o o o o o o o o o o o o o o o o o o o o o o o o o
Alastair Stevens           \ \
MRC Biostatistics Unit      \ \___________ 01223 330383
Cambridge UK                 \___ www.mrc-bsu.cam.ac.uk

