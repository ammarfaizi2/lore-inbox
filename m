Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVGTOhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVGTOhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVGTOhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:37:00 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:37304 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261241AbVGTOg5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:36:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fjo33AoZo5EBpA9DdpFXmtJE3nz/MpMJtKeZb3zfdCxMF+L2GUEns81/M8Ov/rXW8WjuNJSunGtVRkvK4YfAQStglROcs0dpxdxNv0E9oadaK9Wg3nUdVyPBElC37qlCH/z9x5WfUwXCcq+Gq1im+e3r2zQ5a3wdcTK8bWBHkbA=
Message-ID: <9a874849050720073665b87c50@mail.gmail.com>
Date: Wed, 20 Jul 2005 16:36:25 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: eliad lubovsky <eliadl@013.net>
Subject: Re: Linux Benchmarks
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a87484905072007075a9b0bba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1121866937.3251.5.camel@localhost.localdomain>
	 <9a87484905072007075a9b0bba@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 7/20/05, eliad lubovsky <eliadl@013.net> wrote:
> > Where can I find common Linux benchmarks? I added some changes to system
> > calls and want to check whether it cause any performance degradation.
> > Thanks,
> >
> You could go search Google - http://google.com/
> You could go search Freshmeat - http://freshmeat.net/
> You could go search almost any Linux software archive...
> 
> Luckily for you I'm a bit bored and have 2min to spare, so I'll list a
> few for you, but in the future, please try finding them yourself
> first...
> 
> aiostress
>   ftp://ftp.suse.com/pub/people/mason/utils/aio-stress.c
> 
> bonnie
>   http://www.garloff.de/kurt/linux/bonnie/
> 
> clyde
>   http://tdec.free.fr/clyde/clyde.en.html
> 
> contest
>   http://contest.kolivas.org/
> 
> dbench
>   http://samba.org/ftp/tridge/dbench/
> 
> interbench
>   http://interbench.kolivas.org/
> 
> iozone
>   http://www.iozone.org/
> 
> lmbench
>   http://www.bitmover.com/lmbench/
> 
> nbench
>   http://www.tux.org/~mayer/linux/bmark.html
> 
> netperf
>   http://www.netperf.org/
> 
> re-aim
>   http://sourceforge.net/projects/re-aim-7
> 
> sysbench
>   http://sysbench.sourceforge.net/
> 
> tbench
>   http://gnunet.org/doxygen/html/dir_000026.html
> 
> volanomark
>   http://www.volano.com/benchmarks.html
> 
> 

For the bennefit of people searching the archives, I guss I might as
well list a few more now that I'm at it :

bonnie++
  http://www.coker.com.au/bonnie%2B%2B/

cpuburn
  http://pages.sbcglobal.net/redelm/

glxgears 
  http://www.xfree86.org/4.4.0/glxgears.1.html

hdparm (hdparm -tT /dev/drive_to_test)
  http://sourceforge.net/projects/hdparm/
  http://www.die.net/doc/linux/man/man8/hdparm.8.html

iometer
  http://www.iometer.org/

jmeter
  http://jakarta.apache.org/jmeter/index.html

kernprof
  http://oss.sgi.com/projects/kernprof/

llcbench
  http://icl.cs.utk.edu/projects/llcbench/index.html

lockmeter
  http://oss.sgi.com/projects/lockmeter/

openssl (openssl -speed)
  http://www.openssl.org/docs/apps/speed.html

siege
  http://www.joedog.org/siege/

spec
  http://www.spec.org/

specviewperf
  http://www.spec.org/gpc/opc.static/viewperf71info.html

stream
  http://www.cs.virginia.edu/stream/

stress
  http://weather.ou.edu/~apw/projects/stress/

testvidinfo (test program part of the SDL library source, contains a
-benchmark mode)
  http://www.libsdl.org/

vmregress
  http://www.skynet.ie/~mel/projects/vmregress/


And while not really a benchmark tool, the Linux Test Project's test
suite may also be good to use to test for regressions :
http://ltp.sourceforge.net/
StressLinux (http://www.stresslinux.org/) may also be of interrest.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
