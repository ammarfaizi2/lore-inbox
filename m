Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281663AbRLBR4G>; Sun, 2 Dec 2001 12:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281678AbRLBRz4>; Sun, 2 Dec 2001 12:55:56 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:60350 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281663AbRLBRzo>; Sun, 2 Dec 2001 12:55:44 -0500
Date: Sun, 2 Dec 2001 10:55:43 -0700
Message-Id: <200112021755.fB2Hthl10340@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <Pine.GSO.4.21.0112021150310.12801-100000@binet.math.psu.edu>
In-Reply-To: <3C0A025C.88B7A2C3@wanadoo.fr>
	<Pine.GSO.4.21.0112021150310.12801-100000@binet.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Sun, 2 Dec 2001, Pierre Rousselet wrote:
> 
> > Here is the final (i hope) verdict of my devfs testbox :
> > 
> > 2.4.16 with devfsd-1.3.18/1.3.20 : OK
> > 2.4.17-pre1         "            : Broken
> > 2.5.1-pre1          "            : OK
> > 2.5.1-pre2 with or without v200  : Broken
> > 2.5.1-pre5          "            : Broken
> 
> IOW, merge of new devfs code (2.4.17-pre1 in -STABLE, 2.5.1-pre2 in -CURRENT).
> 
> We really need CONFIG_DEBUG_* forced if CONFIG_DEVFS_FS is set.  Otherwise
> we'll be getting tons of bug reports due to silent memory corruption.
> 
> Keith, is there a decent way to do that?  For 2.4.17 it would help a
> lot...

Is that worth the effort? Hopefully by 2.4.17-rc I'll have fixed the
bug, so it won't be an issue.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
