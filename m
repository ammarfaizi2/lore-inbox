Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280960AbRKGUel>; Wed, 7 Nov 2001 15:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280959AbRKGUeU>; Wed, 7 Nov 2001 15:34:20 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:21264 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280952AbRKGUeQ>; Wed, 7 Nov 2001 15:34:16 -0500
Message-ID: <3BE99992.A6BD18F4@zip.com.au>
Date: Wed, 07 Nov 2001 12:29:06 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: szonyi calin <caszonyi@yahoo.com>
CC: linux-kernel@vger.kernel.org, rml@tech9.net
Subject: Re: Q:Howto benchmark preemptible kernel ?
In-Reply-To: <20011107165153.91027.qmail@web13105.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

szonyi calin wrote:
> 
> Hi
> I'm have a Cyrix 486/66 with 12Megs of ram.
> I'm using preemptible patches from quite some time
> now.
> (2.4.10- 2.4.13)
> I was using both Robert Love and Andrew Morton's
> patch.
> I would like to do some benhmarks but there are some
> issues:
> 1. The system is slow and has low memory so a big
> benchmark is out of question (compiling the kernel
> take 4 hours if i don't touch the console)
> 2. The benchmark must be small and adequate (patching
> the kernel to make a benchmark is out of discussion)
> 
> Any ideas ?
> 

None of these patches make any significant difference
to throughput of anything, really.

If you have a particular latency-sensitive application then
that's the thing which you should be testing with.

There's a modified version of Mark Hahn's `realfeel' app in 
http://www.uow.edu.au/~andrewm/linux/amlat.tar.gz
which I find to be a convenient way of quantitatively
determining latencies.  There are some grubby scripts
in there which create graphical output too.

 
> P.S. (for Andrew ) Will there be a patch for 2.4.14 ?

J Sloan was the first to send me an updated patch this time.
Thanks!

It needs a bit of maintenance at present - last time I gave it
a good beating (a couple of weeks ago) there were a couple of
ten millisecond blips.

-
