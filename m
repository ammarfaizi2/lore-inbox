Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280676AbRKNQPv>; Wed, 14 Nov 2001 11:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280678AbRKNQPm>; Wed, 14 Nov 2001 11:15:42 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:4500 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280676AbRKNQP1>; Wed, 14 Nov 2001 11:15:27 -0500
Date: Wed, 14 Nov 2001 16:15:24 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: <alastair@gurney>
To: Matthew Sell <msell@ontimesupport.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <5.1.0.14.0.20011114090926.00a87d88@127.0.0.1>
Message-ID: <Pine.GSO.4.33.0111141607170.14971-100000@gurney>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We just finished putting together what was for us a pretty big box using
> the Tyan S2460 with 1.4GHz Athlons (not MP) and ran into some troublesome
> heating problems.

Well, I finally managed to check, and both CPUs are at 76C - sounds
quite hot to me. Is that problematic? I've never run these Athlons
before, so I'm not sure what's supposed to be normal ;-)

Going back to kernel issues - I tried the Red Hat enterprise kernel
(2.4.9-13), but that's no go either. Basically, the summary is:

  - Red Hat Kernel (any) boots fine, hangs at login prompt
  - Red Hat Kernel SINGLE USER runs fine and lets me hack around
  - Custom kernel (2.4.15-pre4 SMP) hangs due to failing to
    mount the root partition (initrd issue I think)

I have experienced the "hanging at login prompt" issue before - with
good old Red Hat 7.0. That was solved by upgrading the broken gcc and
broken glibc, and didn't even appear to be a kernel issue.

Cheers
Alastair

o o o o o o o o o o o o o o o o o o o o o o o o o o o o
Alastair Stevens           \ \
MRC Biostatistics Unit      \ \___________ 01223 330383
Cambridge UK                 \___ www.mrc-bsu.cam.ac.uk

