Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265565AbSKABUG>; Thu, 31 Oct 2002 20:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265566AbSKABUF>; Thu, 31 Oct 2002 20:20:05 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:2776 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S265565AbSKABUB> convert rfc822-to-8bit; Thu, 31 Oct 2002 20:20:01 -0500
From: David Lang <david.lang@digitalinsight.com>
To: =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Reiserfs-List@namesys.com
Date: Thu, 31 Oct 2002 17:16:25 -0800 (PST)
Subject: Re: Reiser vs EXT3
In-Reply-To: <200210312352.07122.Dieter.Nuetzel@hamburg.de>
Message-ID: <Pine.LNX.4.44.0210311714040.25405-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing that concerns me is the warning to only use a filesystem created
in a certin way for the benchmark, don't use a tar of an ext2/3 filesystem
as that will kill performance.

they say taht there will be a tool to fix this in 4.1, but this makes me
treat the benchmark as a 'best possible' test case and expect the
real-world performance to be considerably worse (how much worse who knows,
I haven't seen anyone try to do worst-case performance tests on it)

David Lang


 On Thu, 31 Oct 2002, Dieter [iso-8859-15] Nützel wrote:

> Date: Thu, 31 Oct 2002 23:52:07 +0100
> From: "Dieter [iso-8859-15] Nützel" <Dieter.Nuetzel@hamburg.de>
> To: Jeff Garzik <jgarzik@pobox.com>
> Cc: Hans Reiser <reiser@namesys.com>,
>      Linux Kernel <linux-kernel@vger.kernel.org>, Reiserfs-List@namesys.com
> Subject: Re: Reiser vs EXT3
>
> Am Donnerstag, 31. Oktober 2002 22:05 schrieb Jeff Garzik:
> > Hans Reiser wrote:
> >
> > > If you want to talk about 2.6 then you should talk about reiser4 not
> > > reiserfs v3, and reiser4 is 7.6 times the write performance of ext3
> > > for 30 copies of the linux kernel source code using modern IDE drives
> > > and modern processors on a dual-CPU box, so I don't think any amount
> > > of improved scalability will make ext3 competitive with reiser4 for
> > > performance usages.
> >
> > What is the read performance like?
>
> From his mentioned paper http://www.namesys.com/v4/fast_reiser4.html, it is
> more then doubled compared to ext3 and ReiserFS v3.
>
> To be fair he should explain if it was compared to the latest ext3 (htree)
> stuff or not, yet.
>
> It looks truly impressive.
>
> Regards,
>         Dieter
>
> --
> Dieter Nützel
> Graduate Student, Computer Science
>
> University of Hamburg
> Department of Computer Science
> @home: Dieter.Nuetzel at hamburg.de (replace at with @)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
