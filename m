Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129205AbQKONOc>; Wed, 15 Nov 2000 08:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129514AbQKONOW>; Wed, 15 Nov 2000 08:14:22 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:37725 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129205AbQKONOI>; Wed, 15 Nov 2000 08:14:08 -0500
Date: Wed, 15 Nov 2000 14:51:45 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Ian Grant <Ian.Grant@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
        mingo@elte.hu
Subject: Re: RAID modules and CONFIG_AUTODETECT_RAID
In-Reply-To: <20001115030752.K18203@wire.cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0011151450120.31966-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2000, Peter Samuelson wrote:

> 
> [Ian Grant]
> > In 2.2.x we were able to build a kernel with RAID modules and have it
> > autodetect RAID partitions at boot time - so we could use raid root
> > partitions.
> 
> Really?  Funny, because IIRC RAID autodetection does not even exist in
> 2.2.x kernels.  Perhaps you are referring to vendor-patched kernels --
> some distributions ship 2.2 kernels with RAID patches applied.

I call the CONFIG_MD_BOOT option a RAID autodetection :)

> > In 2.40 the configuration option CONFIG_AUTODETECT_RAID is explicitly
> > disabled unless at least one RAID module is built into the kernel.  I
> > presume there is a good reason for this and that it's not just a
> > mistake.
> 
> What would be the point?  Autodetection is only needed for mounting the
> root filesystem.  After root is mounted, you can use raidtools.

Please notice the 'filesystem'. I needed to put /boot on a non-RAID
partition, else it was a nogo.

> Peter


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
