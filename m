Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315742AbSENOfO>; Tue, 14 May 2002 10:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSENOfN>; Tue, 14 May 2002 10:35:13 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:19585 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S315742AbSENOfM>; Tue, 14 May 2002 10:35:12 -0400
Date: Tue, 14 May 2002 08:35:03 -0600
Message-Id: <200205141435.g4EEZ3V07379@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove compat code for old devfs naming scheme
In-Reply-To: <20020514125339.A23979@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
> Hi Richard,
> 
> current init/do_mounts.c contains the devfs_make_root/convert_name
> functions which provide compatiblility for the old, pre kernel-merge
> devfs naming scheme in the root= kernel command line.
> 
> As this was never present in official kernels there is really no need
> in keeping it - it just bloats the kernel.
> 
> Could you please forward this patch to Linus and maybe Marcelo with
> your next devfs update?

What on earth are you talking about? This code has been in the kernel
since 2.3.46. It's just lived in a different place: fs/devfs/util.c.

And FYI: 2.5.x kernels *are* official!

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
