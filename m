Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132982AbRDEVfz>; Thu, 5 Apr 2001 17:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132980AbRDEVfo>; Thu, 5 Apr 2001 17:35:44 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:54407 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S132978AbRDEVfc>;
	Thu, 5 Apr 2001 17:35:32 -0400
Date: Thu, 5 Apr 2001 23:34:46 +0200
From: David Weinehall <tao@acc.umu.se>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.0.39 oopses in sys_new(l)stat
Message-ID: <20010405233445.A28501@khan.acc.umu.se>
In-Reply-To: <20010405180927.A8000@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010405180927.A8000@niksula.cs.hut.fi>; from vherva@mail.niksula.cs.hut.fi on Thu, Apr 05, 2001 at 06:09:28PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2001 at 06:09:28PM +0300, Ville Herva wrote:
> I wonder if there might still be a bug in 2.0.39 sys_new(l)stat.
> Today, one of my trustworthy servers crashed (see details below), and
> it has actually given me two slightly similar looking oopses before.
> 
> While this might be a hardware problem (I'll run memory test asap), it
> seems that the oopses are quite similar and could perhaps be caused by
> a kernel bug.
> 
> This is vanilla 2.0.39 (2.0.37 before), gcc-2.7.2.3, Ppro-200, Intel
> motherboard etc. It has been very reliable in past. These oopses are
> the _only_ problems. It runs qmail, samba, cvs, rsync, apache, pop,
> sshd and oracle. All local fs's are plain ext2.
> 
> I hope somebody (with more kernel hacking experience than me) is still
> interested in the 2.0.39. I'll be happy to provide any additional
> details or try something. The oops will propably be hard to reproduce,
> however.

I'll look into it. A note, however: the additional oops:es that follow
the first one are almost never ever useful, because the system is no
longer in a consistent state after the first one.


/David, maintainer of the v2.0.xx kernel series
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
