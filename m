Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281524AbRKHKVQ>; Thu, 8 Nov 2001 05:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281517AbRKHKVG>; Thu, 8 Nov 2001 05:21:06 -0500
Received: from web13105.mail.yahoo.com ([216.136.174.150]:16649 "HELO
	web13105.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281500AbRKHKUw>; Thu, 8 Nov 2001 05:20:52 -0500
Message-ID: <20011108102048.99358.qmail@web13105.mail.yahoo.com>
Date: Thu, 8 Nov 2001 02:20:48 -0800 (PST)
From: szonyi calin <caszonyi@yahoo.com>
Subject: Re: Q:Howto benchmark preemptible kernel ?
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, rml@tech9.net
In-Reply-To: <3BE99992.A6BD18F4@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Andrew Morton <akpm@zip.com.au> wrote:

> 
> None of these patches make any significant
> difference
> to throughput of anything, really.
> 

Shell scripts and related tools (i.e. make) run
faster.


> If you have a particular latency-sensitive
> application then
> that's the thing which you should be testing with.
> 

Gcc seems to be a "latency-sensitive application"
because it runs faster (but it could be the mm
improvements in kernel 2.4 -- i have't use a
non-preemptible kernel from a long time )

> There's a modified version of Mark Hahn's `realfeel'
> app in 
> http://www.uow.edu.au/~andrewm/linux/amlat.tar.gz
> which I find to be a convenient way of
> quantitatively
> determining latencies.  There are some grubby
> scripts
> in there which create graphical output too.
> 
>  

I'll give it a try. 
Thanks


__________________________________________________
Do You Yahoo!?
Find a job, post your resume.
http://careers.yahoo.com
