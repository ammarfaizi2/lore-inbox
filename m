Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbSLJT1k>; Tue, 10 Dec 2002 14:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265677AbSLJT1k>; Tue, 10 Dec 2002 14:27:40 -0500
Received: from ma-northadams1b-112.bur.adelphia.net ([24.52.166.112]:4993 "EHLO
	ma-northadams1b-112.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S265675AbSLJT1j>; Tue, 10 Dec 2002 14:27:39 -0500
Date: Tue, 10 Dec 2002 14:36:12 -0500
From: Eric Buddington <eric@ma-northadams1b-112.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 won't boot with devfs enabled
Message-ID: <20021210143612.A233@ma-northadams1b-112.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
References: <200212101645.gBAGii6R019092@mail.wesleyan.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200212101645.gBAGii6R019092@mail.wesleyan.edu>; from jordan.breeding@attbi.com on Tue, Dec 10, 2002 at 04:44:43PM +0000
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixed my problem (though now it doesn't find init, *sigh*)

-Eric

On Tue, Dec 10, 2002 at 04:44:43PM +0000, jordan.breeding@attbi.com wrote:
> Are you using grub to boot?  If so try using something 
> like /dev/discs/disc0/part1 or the full ide /dev pathname for devfs to boot 
> with instead of /dev/hda1.  I have a scsi disk subsystem and have to 
> use /dev/discs/disc0/part9 instead of /dev/sda9 to get devfs to work.
> 
> Jordan
> > With 2.5.51 (gcc-3.2, Athlon, mostly modules, DEVFS=y, DEVFS_DEBUG=y),
> > boot panics with "VFS: Cannot open root device "hda1" or
> > 03:01".
> > 
> > I had the same problem with 2.5.50, avoidable by disabling devfs entirely.
> > 
> > -Eric
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
