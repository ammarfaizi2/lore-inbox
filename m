Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131414AbRCSMD5>; Mon, 19 Mar 2001 07:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131415AbRCSMDr>; Mon, 19 Mar 2001 07:03:47 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:1160 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S131414AbRCSMDh>;
	Mon, 19 Mar 2001 07:03:37 -0500
Date: Mon, 19 Mar 2001 13:02:41 +0100
From: David Weinehall <tao@acc.umu.se>
To: asenec@senechalle.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo for Intel P4 D850GB
Message-ID: <20010319130241.J10321@khan.acc.umu.se>
In-Reply-To: <200103190207.UAA13397@senechalle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200103190207.UAA13397@senechalle.net>; from asenec@senechalle.net on Sun, Mar 18, 2001 at 08:07:20PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2001 at 08:07:20PM -0600, asenec@senechalle.net wrote:
> On a 2.0.36 kernel the above-referenced mb
> shows:
> 
> dragonwind:/proc# cat cpuinfo
> processor	: 0
> cpu		: ?86
> model		: 386 SX/DX
> vendor_id	: GenuineIntel
> 
> At the least, java breaks because of the '?' char.
> 
> Is the problem is due to the older 2.0.36 kernel,
> or would the problem also present itself on a newer 2.2.x kernel?

Ahhhh, bit by the "IV written as 15 by Intel"-bug.

I'll hack up a fix to apply against v2.0.39.

And no, you won't be bit by this bug in a recent v2.2 or v2.4 kernel.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
