Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbREVEov>; Tue, 22 May 2001 00:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262570AbREVEol>; Tue, 22 May 2001 00:44:41 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:22958 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S262568AbREVEog>;
	Tue, 22 May 2001 00:44:36 -0400
Date: Tue, 22 May 2001 06:44:30 +0200
From: David Weinehall <tao@acc.umu.se>
To: Dave Jones <davej@suse.de>
Cc: Steven Walter <srwalter@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
Message-ID: <20010522064430.D4934@khan.acc.umu.se>
In-Reply-To: <20010521215927.B31289@hapablap.dyn.dhs.org> <Pine.LNX.4.30.0105220519160.20545-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0105220519160.20545-100000@Appserv.suse.de>; from davej@suse.de on Tue, May 22, 2001 at 05:22:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 05:22:35AM +0200, Dave Jones wrote:
> On Mon, 21 May 2001, Steven Walter wrote:
> 
> > > Any particular reason this needs to be done in the kernel, as opposed
> > > to having your script read /dev/cpu/*/cpuid?
> > Wouldn't that be the same reason we have /anything/ in cpuinfo?
> 
> When /proc/cpuinfo was added, we didn't have /dev/cpu/*/cpuid
> Now that we do, we're stuck with keeping /proc/cpuinfo for
> compatability reasons.

AFAIK, not all processors support cpuid.


/david
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
