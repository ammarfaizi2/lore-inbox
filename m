Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129699AbRCCTek>; Sat, 3 Mar 2001 14:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129719AbRCCTea>; Sat, 3 Mar 2001 14:34:30 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3566 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129699AbRCCTeO>;
	Sat, 3 Mar 2001 14:34:14 -0500
Date: Sat, 3 Mar 2001 14:34:10 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, davidge@jazzfree.com
Subject: Re: simple question about patches
In-Reply-To: <E14ZHdq-0003yb-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0103031425140.19484-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[cc trimmed]

On Sat, 3 Mar 2001, Alan Cox wrote:

> > Long ago, pre* and ac* patches were rare. Patches went from one
> 
> Umm wrong. -ac patches for 2.2 regularly did one a day
> 
> > line-by-line before the next one came out. Patches always applied
> > easily with the (pre-POSIX?) patch command. Version numbers made
> 
> patch is Larry Wall
> 
> > Pre-patches go like this:
> > 
> > 200 kB         (great: read the patch)
> > 200 kB + 200 kB of old stuff you already read   (ugh, read 1/2 of it)
> > 200 kB + 400 kB of old stuff you already read   (too boring)
> 
> Of course people with at least one functioning braincell read the differences
> between the two patches, or pick up the patch between the two (handily
> maintained on www.bzimage.org for the Linux 2.4ac series)

... or do something along the lines
cp -rl S2 S2-ac10
bzip2 -d <patch-2.4.2-ac10.bz2 | (cd S2-ac10 && patch -p1 -E)
diff -urN S2-ac{9,10} | tee delta-9-10 | less
							Cheers,
								Al

