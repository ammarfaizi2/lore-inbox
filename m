Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSHATWL>; Thu, 1 Aug 2002 15:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSHATVj>; Thu, 1 Aug 2002 15:21:39 -0400
Received: from lucidpixels.com ([66.45.37.187]:53968 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S316856AbSHATVg>;
	Thu, 1 Aug 2002 15:21:36 -0400
Message-ID: <3D498A34.A1A914E4@lucidpixels.com>
Date: Thu, 01 Aug 2002 15:21:24 -0400
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lowlatency-preempt i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Ragnar Kj?rstad <kernel@ragnark.vestdata.no>, linux-kernel@vger.kernel.org,
       lftp@uniyar.ac.ru, lftp-devel@uniyar.ac.ru, apiszcz@mitre.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: Nasty ext2fs bug!
References: <Pine.LNX.4.44.0208011150310.17729-100000@lucidpixels.com> <20020801174856.GA29562@clusterfs.com> <20020801202718.S20768@vestdata.no> <20020801183825.GA20265@alpha.home.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My ISP = Adelphia.
The area in which I live in has many problems, simply check:
http://www.dslreports.com/forum/adelphia
The post with 700+ threads is where I am.
Basically, each thread from their service only gives you 10-20KB/s.
To get any decent speed while downloading, you must download in parallel or
split the file up.

Willy Tarreau wrote:

> On Thu, Aug 01, 2002 at 08:27:18PM +0200, Ragnar Kj?rstad wrote:
> > On Thu, Aug 01, 2002 at 11:48:56AM -0600, Andreas Dilger wrote:
> > > I find it hard to believe that this would actually make a huge
> > > difference, except in the case where the source is throttling bandwidth
> > > on a per-connection basis.  Either your network is saturated by the
> > > transfer, or some point in between is saturated.  I could be wrong, of
> > > course, and it would be interesting to hear the reasoning behind the
> > > speedup.
> > If some link is saturated with 1000 connections, you will get 1% of the
> > bandwith instead of 0.1% if you use 10 concurrent connections. right?
>
> wrong, you'll get 1% of the connections instead of 0.1%. So you'll be
> more responsible for the saturation of some active equipments which
> are sensible to connections, but this has nothing to do with the
> bandwidth, nor the link.
>
> It may be usefull only if you have a very high latency and a small
> TCP window, I think.
>
> Cheers,
> Willy

