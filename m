Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVG0TQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVG0TQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 15:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVG0TJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 15:09:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63240 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261344AbVG0TIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 15:08:52 -0400
Date: Wed, 27 Jul 2005 21:08:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Vinicius <jdob@ig.com.br>
Cc: bernd@firmix.at, linux-kernel@vger.kernel.org
Subject: Re: Re: Kernel doesn't free Cached Memory
Message-ID: <20050727190841.GL3160@stusta.de>
References: <20050722_120205_006490.jdob@ig.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050722_120205_006490.jdob@ig.com.br>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 09:02:05AM -0300, Vinicius wrote:
Content-Description: Mail message body
> On Fri, 2005-07-22 at 08:27 -0300, Vinicius wrote: 
> [...] 
> >>    I have a server with 2 Pentium 4 HT processors and 32 GB of >>RAM, 
> this 
> >> server runs lots of applications that consume lots of memory to. >>When I 
> >>stop 
> >> this applications, the kernel doesn't free memory (the  memory >>still in 
> >>use) 
> >> and the server cache lots of memory (~27GB). When I start this 
> >>applications, 
> >> the kernel sends  "Out of Memory" messages and kill some random 
> >> applications. 
> >> 
> >>    Anyone know how can I reduce the kernel cached memory on RHEL >>3 
> (kernel 
> >> 2.4.21-32.ELsmp - Trial version)? There is a way to reduce the >>kernel 
> >>cached 
> >> memory utilization? 
> 
> >Probably RedHat's support can answer this for RHEL 3. 
> > 
> >	Bernd 
> 
> Bernd, 
> 
>    The server runs RHEL Trial Version, without support... for tests purpose. 
>...

The answers you already got are:
- for that much memory, 64bit processors are really recommended
- 2.6 kernels are a better choice for this scenario
- linux-kernel doesn't support vendor kernels, does the same problem 
  occur with kernel 2.6.12 ?

Another thing that surprises me is that why you are testing an old 
version of RHEL.

If you want to build a new system, you should better test RHEL 4.

> Vinicius. 
> Protolink Consultoria. 

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

