Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317845AbSHUEpH>; Wed, 21 Aug 2002 00:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSHUEpH>; Wed, 21 Aug 2002 00:45:07 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:19617 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317845AbSHUEpG>; Wed, 21 Aug 2002 00:45:06 -0400
Date: Tue, 20 Aug 2002 22:49:11 -0600
Message-Id: <200208210449.g7L4nBo23764@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Ed Sweetman <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs
In-Reply-To: <1029712550.3331.43.camel@psuedomode>
References: <Pine.GSO.4.21.0208181852450.3920-100000@weyl.math.psu.edu>
	<1029712550.3331.43.camel@psuedomode>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman writes:
> Ok, that all makes sense.  I removed the dev entries because they
> weren't needed by me anymore but I suppose it doesn't hurt anything
> to just keep them there anyways so I've fixed all that.  Either way,
> removing devfs did nothing but apparently it was asked to be done to
> allow better testing and/or debugging to be done.  But i've yet to
> get any reason why I removed devfs to investigate promise ide
> controller's dma related memory failures.  I've removed devfs and
> replaced the old /dev entries, no problem.  I'm not getting off
> topic about that.  It's all done so i'm waiting for the next step
> here.

It seems the reason you removed devfs is that you followed Al's bad
advice:
Alexander Viro writes:
> Don't be silly - if you want to test anything, devfs is the last
> thing you want on the system.

In fact, devfs works quite robustly for many people, and wasn't
involved in the IDE problems you were having. Al is an absolutist: if
it's not 100% provably correct, it falls into his other category,
"spawn of satan".

So next time someone claims devfs is causing you problems, treat it
with the skepticism it deserves.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
