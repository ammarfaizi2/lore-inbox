Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281103AbRKYVpa>; Sun, 25 Nov 2001 16:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281116AbRKYVpU>; Sun, 25 Nov 2001 16:45:20 -0500
Received: from linux.kappa.ro ([194.102.255.131]:47269 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S281105AbRKYVpJ>;
	Sun, 25 Nov 2001 16:45:09 -0500
Date: Sun, 25 Nov 2001 23:44:11 +0200 (EET)
From: Teodor Iacob <theo@astral.kappa.ro>
X-X-Sender: <theo@linux.kappa.ro>
Reply-To: <Teodor.Iacob@astral.kappa.ro>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <20011125145134.B23807@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.31.0111252343030.14413-100000@linux.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.2(snapshot 20010725) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Could someone tell if reiserfs or ext3 filesystems are affected by this?

      Teodor Iacob,
Astral TELECOM Internet

On Sun, 25 Nov 2001, Russell King wrote:

> On Sun, Nov 25, 2001 at 03:39:08PM +0100, Florian Weimer wrote:
> > BTW, what is the correct recovery strategy, assuming 2.4.15 has not
> > been rebooted yet?  Installing a fixed kernel is obviously the first
> > step.  How should one reboot the system to minimize damage?  Use a
> > normal system shutdown (with the -F parameter to forc fsck on next
> > boot), or go to single user, "touch /forcefsck", sync, wait a minute,
> > and switching of power?
>
> >From Viro's mail (on http://lwn.net/daily/2.4.15-recovery.php3):
>
> | IOW, if you are running 2.4.15 - build a patched kernel, install it and
> | do the following:
> |	* switch to single-user
> |	* sync
> |	* umount everything non-buys
> |	* remount the rest read-only
> |	* turn the thing off
> |	* boot with patched kernel or with anything before 2.4.15-pre9
>
> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

