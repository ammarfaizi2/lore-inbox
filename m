Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284088AbRLAMSB>; Sat, 1 Dec 2001 07:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284087AbRLAMRv>; Sat, 1 Dec 2001 07:17:51 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:8457 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S284083AbRLAMRs>; Sat, 1 Dec 2001 07:17:48 -0500
Date: Sat, 1 Dec 2001 07:11:02 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Nathan G. Grennan" <ngrennan@okcforum.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16 revisited
In-Reply-To: <1007057769.1528.7.camel@cygnusx-1.okcforum.org>
Message-ID: <Pine.LNX.3.96.1011201070846.13057B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001, Nathan G. Grennan wrote:

> On Thu, 2001-11-29 at 12:09, Oktay Akbal wrote:
> > Why do you think that fstab matters for root-fs ? root-fs needs to be 
> > mounted to read fstab. So autodetection must be done for root-fs.
> > And if the fs has a journal it is ext3. If you do not want that  behaviour
> > you might use a option to lilo, but I don't know of any option to specify
> > the root-fs-tyoe. Or you need to use an initrd to mount explicit as ext2
> > and pivot-root it to / ?
 
> Actually, I think it should respect fstab. It does mount it, then fsck
> it while mounted read-only, then remounts(key point) read-write. IMHO it
> should remount it with whatever fstab says. I realize this could be a
> little tricky, but I bet doable.

Using the precognition() system call no doubt. It can't read fstab without
mounting, how can kernel use fstab to mount to read fstab? Original
response was correct, you need to learn to use initrd.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

