Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314139AbSEITQG>; Thu, 9 May 2002 15:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314221AbSEITQF>; Thu, 9 May 2002 15:16:05 -0400
Received: from [195.39.17.254] ([195.39.17.254]:43669 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314139AbSEITQD>;
	Thu, 9 May 2002 15:16:03 -0400
Date: Thu, 9 May 2002 13:58:21 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, benh@kernel.crashing.org,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020509135821.C37@toy.ucw.cz>
In-Reply-To: <200205071840.g47Ie1m32403@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.44.0205071142001.1067-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Also, you obviously haven't thought it through AT ALL. Hint: partitions.
> 
> If you have /dev/hda1, that _cannot_ be a symlink to the physical tree,
> because on a physical level that partition DOES NOT EXIST. It's purely a
> virtual mapping.

I don't see why partitions in devicefs are bad idea.

Some physical chips show as multiple devices in devicefs, so I'd guess it
would be okay for partitions to be there, too.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

