Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277165AbRJZBsT>; Thu, 25 Oct 2001 21:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277161AbRJZBsL>; Thu, 25 Oct 2001 21:48:11 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:25304 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S277165AbRJZBsB>;
	Thu, 25 Oct 2001 21:48:01 -0400
Date: Fri, 26 Oct 2001 03:48:34 +0200
From: David Weinehall <tao@acc.umu.se>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc-3.0.2 and 2.4.14-pre1
Message-ID: <20011026034833.H25701@khan.acc.umu.se>
In-Reply-To: <20011026010432.A1536@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011026010432.A1536@werewolf.able.es>; from jamagallon@able.es on Fri, Oct 26, 2001 at 01:04:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 01:04:32AM +0200, J . A . Magallon wrote:
> Hi.
> 
> Results of building with 3.0.2
> - It works
> - Kernel Sizes:
> 	903449 Oct 26 00:38 vmlinuz-2.4.14-pre1-beo			(2.96)
> 	864599 Oct 26 00:25 vmlinuz-2.4.14-pre1-beo.old		(3.0.2)

Aren't these figures swapped in some way? I find it hard to believe
that 2.96 would produce the 40k bigger kernel.

> - Modules Sizes:
> 	2750    /lib/modules/2.4.14-pre1-beo
> 	2758    /lib/modules/2.4.14-pre1-beo.org
> 	werewolf:/lib/modules# modprobe -l | wc -l
>    	  71
> 
> So it looks like the code is not bigger (modules) but some data structure
> in main kernel...

Quite likely due to the 16 bytes alignment that takes place (AFAIK).


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
