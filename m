Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKOJi1>; Wed, 15 Nov 2000 04:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129516AbQKOJiR>; Wed, 15 Nov 2000 04:38:17 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:55057 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129097AbQKOJiI>; Wed, 15 Nov 2000 04:38:08 -0500
Date: Wed, 15 Nov 2000 03:07:52 -0600
To: Ian Grant <Ian.Grant@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: RAID modules and CONFIG_AUTODETECT_RAID
Message-ID: <20001115030752.K18203@wire.cadcamlab.org>
In-Reply-To: <E13veNB-0000Se-00@wisbech.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13veNB-0000Se-00@wisbech.cl.cam.ac.uk>; from Ian.Grant@cl.cam.ac.uk on Tue, Nov 14, 2000 at 11:35:33AM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Ian Grant]
> In 2.2.x we were able to build a kernel with RAID modules and have it
> autodetect RAID partitions at boot time - so we could use raid root
> partitions.

Really?  Funny, because IIRC RAID autodetection does not even exist in
2.2.x kernels.  Perhaps you are referring to vendor-patched kernels --
some distributions ship 2.2 kernels with RAID patches applied.

> In 2.40 the configuration option CONFIG_AUTODETECT_RAID is explicitly
> disabled unless at least one RAID module is built into the kernel.  I
> presume there is a good reason for this and that it's not just a
> mistake.

What would be the point?  Autodetection is only needed for mounting the
root filesystem.  After root is mounted, you can use raidtools.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
