Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131607AbRCQLku>; Sat, 17 Mar 2001 06:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131615AbRCQLkl>; Sat, 17 Mar 2001 06:40:41 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:5583 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S131607AbRCQLkd>;
	Sat, 17 Mar 2001 06:40:33 -0500
Date: Sat, 17 Mar 2001 12:39:45 +0100
From: David Weinehall <tao@acc.umu.se>
To: Jeff Dike <jdike@karaya.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] big stack variables
Message-ID: <20010317123945.D1962@khan.acc.umu.se>
In-Reply-To: <Pine.GSO.4.21.0103161154060.12618-100000@weyl.math.psu.edu> <200103170601.BAA05503@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200103170601.BAA05503@ccure.karaya.com>; from jdike@karaya.com on Sat, Mar 17, 2001 at 01:01:22AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2001 at 01:01:22AM -0500, Jeff Dike wrote:
> viro@math.psu.edu said:
> > ObUML: something fishy happens in UML with multiple exec() in PID 1.
> > Try to say "telinit u" (or just boot with init=/bin/sh and say exec /
> > sbin/init) and you've got a nice panic()... 
> 
> ObFix:  This is fixed in my current CVS.  If you're not so desperate for the 
> fix, then it will be in my 2.4.3 release.  Basically, the problem was that it 
> assumed that the only exec done by pid 1 was the kernel thread execing init, 
> and things got exciting when that turned out not to be true.

ObUML (again): Any estimated time of submission to Linus?! Is this
an early v2.5-thing, or are the changes minor enough to the rest of the
tree to allow for an v2.4-merge?


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
