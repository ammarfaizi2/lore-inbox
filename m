Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284966AbRLQCVn>; Sun, 16 Dec 2001 21:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284965AbRLQCVe>; Sun, 16 Dec 2001 21:21:34 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:40105 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284966AbRLQCVS>; Sun, 16 Dec 2001 21:21:18 -0500
Date: Sun, 16 Dec 2001 19:21:10 -0700
Message-Id: <200112170221.fBH2LAx01188@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1 - intermediate bio stuff..
In-Reply-To: <Pine.LNX.4.33.0112161604030.11129-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0112161604030.11129-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> 2.5.1 is hopefully a good interim stage - many block drivers should
> work fine, but many more do not.  However, the pre-patches were
> getting largish, so I'd rather do a 2.5.1 than wait for all the
> details.

Trying a quick test-run here:
# modprobe ide-probe-mod
/lib/modules/2.5.1/kernel/drivers/ide/ide-mod.o: unresolved symbol block_ioctl

# modprobe ide-cd
/lib/modules/2.5.1/kernel/drivers/ide/ide-mod.o: unresolved symbol block_ioctl

# modprobe ide-disk
/lib/modules/2.5.1/kernel/drivers/ide/ide-mod.o: unresolved symbol block_ioctl

# modprobe nfs
/lib/modules/2.5.1/kernel/fs/nfs/nfs.o: unresolved symbol seq_escape
/lib/modules/2.5.1/kernel/fs/nfs/nfs.o: unresolved symbol seq_printf

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
