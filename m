Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130264AbRB1Q1C>; Wed, 28 Feb 2001 11:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130267AbRB1Q0x>; Wed, 28 Feb 2001 11:26:53 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:28942 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S130264AbRB1Q0j>; Wed, 28 Feb 2001 11:26:39 -0500
Date: Wed, 28 Feb 2001 08:26:25 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Per Erik Stendahl <PerErik@onedial.se>
cc: "'James A. Sutherland'" <jas88@cam.ac.uk>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Unmounting and ejecting the root fs on shutdown.
In-Reply-To: <E44E649C7AA1D311B16D0008C73304460933B1@caspian.prebus.uppsala.se>
Message-ID: <Pine.LNX.4.32.0102280824091.24482-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Per ,  Yah I can understand high volume lists ;-)
	But combined with the dropping of a copy of the iso-image
	you create ,  A Howto ???  Please .  Tia , JimL

On Wed, 28 Feb 2001, Per Erik Stendahl wrote:
> Oops, I almost missed this one. High-volume mailinglists... :-)
> > > 	Hello Per ,  Has anyone gotten back to you on this subject ?
> > > 	I as well am very interested in any information about releiving
> > > 	this difficulty .  Tia ,  JimL
> > Such a CD would be very nice; one or two people do have this already,
> > though. Have you tried using a ramdisk for root, and mounting
> > the CD as
> > /usr?
> Well, doing this on your own certainly will teach you a lot about
> Linux I tell you. :-)
> I still dont know how to make the kernel unlock and eject the CD on
> shutdown. I haven't been able to pinpoint the shutdown sequence in
> the kernel sources yet. :-)
> What I do know now is how to make the kernel not lock the CD in the
> first place. Simply ioctl(/dev/cdrom, CDROM_CLEAR_OPTIONS, CDO_LOCK)
> from /linuxrc in the initrd. This way I can remove the CD anytime
> I please which is enough for me. And I dont have to patch the kernel.
> Mounting a ramdisk for / is doable (I think) but kludgy since you have
> to symlink or mount so many subdirectories. Right now I only have /var
> in a ramdisk (and why _WHY_ is /etc/mtab located in /etc and not
> in /var??).
> Anyways the CD works - and yes, being able to boot Linux w/o touching
> the harddrives or the network is nice! :-) I might even put it on the
> web once I get it cleaned up. Though the ISO is ~200 Mb.
> Cheers
> /Per Erik Stendahl
       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

