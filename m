Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbTAEVIn>; Sun, 5 Jan 2003 16:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbTAEVIn>; Sun, 5 Jan 2003 16:08:43 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:63930 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S265169AbTAEVIl>; Sun, 5 Jan 2003 16:08:41 -0500
Date: Sun, 5 Jan 2003 22:17:10 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.54-mm3
Message-ID: <20030105211710.GA23827@pusa.informat.uv.es>
References: <3E16A2B6.A741AE17@digeo.com> <20030105180446.GA20388@pusa.informat.uv.es> <3E1897B8.7688566B@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E1897B8.7688566B@digeo.com>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for your reply

	Ulisses


On Sun, Jan 05, 2003 at 12:38:16PM -0800, Andrew Morton wrote:
> uaca@alumni.uv.es wrote:
> > 
> > On Sat, Jan 04, 2003 at 01:00:38AM -0800, Andrew Morton wrote:
> > >
> > > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.54/2.5.54-mm3/
> > 
> > It seems to me that the patch you pointed here doesn't include the latency
> > instrumentation.
> 
> No, it doesn't.  You can monitor the latency using realfeel or realfeel2
> from http://www.zip.com.au/~akpm/linux/amlat.tar.gz
> 
> But that won't tell you _why_ large latencies are occurring.   For that,
> you'll need to apply
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.54/2.5.54-mm3/experimental/rtc-debug.patch
> and run `amlat'.  This combination will spit out stack backtraces whenever
> there is a 2 millisecond scheduling overrun.
> 
> > Where it is the needed instrumentation to meassure it?
> > 
> > In http://www.zip.com.au/~akpm/linux/ the are no timepeg/intlat patches for
> > 2.5...
> 
> That's not suitable for this work.  intlat is OK for locating and
> measuring interrupts-off code paths.   But it's a bit hard to drive.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
