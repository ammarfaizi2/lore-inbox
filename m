Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292941AbSB0Ugp>; Wed, 27 Feb 2002 15:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292940AbSB0UfD>; Wed, 27 Feb 2002 15:35:03 -0500
Received: from [195.163.186.27] ([195.163.186.27]:55725 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S292938AbSB0Uec>;
	Wed, 27 Feb 2002 15:34:32 -0500
Date: Wed, 27 Feb 2002 22:34:26 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Barubary <barubary@cox.net>
Cc: linux-kernel@vger.kernel.org, Rick Stevens <rstevens@vitalstream.com>
Subject: Re: Big file support
Message-ID: <20020227223426.N23151@mea-ext.zmailer.org>
In-Reply-To: <3C7D3587.8080609@vitalstream.com> <006301c1bfc9$a5c6de90$a7eb0544@CX535256D>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006301c1bfc9$a5c6de90$a7eb0544@CX535256D>; from barubary@cox.net on Wed, Feb 27, 2002 at 12:02:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 12:02:12PM -0800, Barubary wrote:
> A lot of the kernel supports big files already.  The real problem is the
> fact that the primary Linux file system, ext3, does not.  If you use some
> file system besides ext3, big files should work.

  Bullshit.   EXT2/EXT3 does support large files.  Has done so since
kernel 1.2 in fact, altough formely only at 64 bit machines.

Since 2.4 the kernel has been changed internally so that it supports
large files also at measly 32 bit thingies including i386...

There are several filesystems which are 64-bit/large-file supporting,
but also some which are inherently incapable to exceed 2G or 4G.

It looks like the LOOP driver lands in between -- it should be LFS
capable, but it isn't.

> Linux already has API calls to read big files.

Those were done for 2.4 kernel too.

> -- Barubary
> 
> ----- Original Message -----
> From: "Rick Stevens" <rstevens@vitalstream.com>
> To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
> Sent: Wednesday, February 27, 2002 11:37 AM
> Subject: Big file support
> 
> 
> > I'm not certain if this is the right place, but are there plans to
> > have big file support (files >2GB) anytime soon?  I ask, as we use
> > Linux to serve LOTS of streaming media and the logs for popular sites
> > often exceed 2GB.  I'd like to see the ability to handle at least 16GB
> > files, possibly more.
> >
> > Please cc: me on any replies if possible.  I've been REALLY busy and
> > am finding it hard to keep up with l-k traffic.
> >
> > Thanks!
> > ----------------------------------------------------------------------
> > - Rick Stevens, SSE, VitalStream, Inc.      rstevens@vitalstream.com -
> > - 949-743-2010 (Voice)                    http://www.vitalstream.com -
> > -                                                                    -
> > -              Never eat anything larger than your head              -
> > ----------------------------------------------------------------------
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
