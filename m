Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289917AbSAPKDm>; Wed, 16 Jan 2002 05:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289804AbSAPKDd>; Wed, 16 Jan 2002 05:03:33 -0500
Received: from yeager.cse.Buffalo.EDU ([128.205.36.9]:43185 "EHLO
	yeager.cse.Buffalo.EDU") by vger.kernel.org with ESMTP
	id <S290321AbSAPKDV>; Wed, 16 Jan 2002 05:03:21 -0500
Date: Wed, 16 Jan 2002 05:03:20 -0500 (EST)
From: Nelson Mok <nmok@cse.Buffalo.EDU>
To: <linux-kernel@vger.kernel.org>
Subject: Re: USB Sandisk SDDR-31 problems in 2.4.9 - 2.4.17
In-Reply-To: <Pine.SOL.4.30.0201100411100.25549-100000@yeager.cse.Buffalo.EDU>
Message-ID: <Pine.SOL.4.30.0201160501390.7904-100000@yeager.cse.Buffalo.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Nelson Mok wrote:

> My system is currently an AMD Athlon with kernel 2.4.17, Adaptec 2940 PCI
> SCSI card, Plextor 40X SCSI CD-ROM, Plextor 8x CD-R and the USB Sandisk
> SDDR-31 compact flash reader.  With the 2.4.x series of the kernel, in
> particular with RedHat's 2.4.9 kernel, 2.4.15, 2.4.16, and 2.4.17 I have
> been experiencing the same two problems.
>
> 1. the SCSI CD-ROM on my system works fine, that is until I mount the USB
> cf reader.  After doing so, any attempts to mount a CD in the CD-ROM gives
> me the message "mount: wrong fs type, bad option, bad superblock on
> /dev/cdrom, or too many mounted file systems".  If the CD-ROM is already
> mounted and I then mount the USB cf reader, the CD-ROM will no longer
> respond...  unmounting and mounting the CD-ROM at this point seems to work
> but any attempt to access the information is futile.  The physical eject
> on the CD-ROM also ceases to function after this.  Tried removing all the
> USB modules followed by the SCSI modules and then modprobe them all again
> but doing that does not affect anything.  Only way to access my CD-ROM
> again is a reboot of the machine.  The wierd thing to this is, it does not
> affect my CD-R drive as it continues to work fine.  This happens again if
> I were to repeat the above mentioned steps.
>
> 2. after mounting the USB cf reader, the shutting down of the system
> stalls for quite a bit at the point where it tries to unmount all the file
> systems.  This occurs regardless of whether I unmounted the drive or not.
>
>
> Lastly, I know both the CD-ROM and USB cf reader are fine as they have
> worked fine under the later 2.2.x kernels, as well as in Windows.

To add to this, even after the system refuses to mount the CD-ROM, I can
still control a musical CD through xmms...  skip tracks, play, stop, and
pause the musical CD.

