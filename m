Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290056AbSAQREH>; Thu, 17 Jan 2002 12:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290051AbSAQRD5>; Thu, 17 Jan 2002 12:03:57 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:27095 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S290062AbSAQRCy>;
	Thu, 17 Jan 2002 12:02:54 -0500
Date: Thu, 17 Jan 2002 18:02:48 +0100
From: David Weinehall <tao@acc.umu.se>
To: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] getting rid of suser/fsuser for good, first part
Message-ID: <20020117180248.Q5235@khan.acc.umu.se>
In-Reply-To: <20020117091203.N5235@khan.acc.umu.se> <20020117122704.E22171@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20020117122704.E22171@suse.de>; from davej@suse.de on Thu, Jan 17, 2002 at 12:27:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 12:27:04PM +0100, Dave Jones wrote:
> On Thu, Jan 17, 2002 at 09:12:03AM +0100, David Weinehall wrote:
>  > It is after all 2.5-time, and hence time for a spring-cleaning.
>  > These files are still naughty (feel free to fix!):
>  > 
>  > arch/i386/kernel/mtrr.c
> 
>  This file in particular needs more than just a spring clean imo.
>  As extra support was added for the different MTRR lookalikes,
>  it got messier and messier until it turned into the goop we
>  have now.  Doing a real cleanup on this has been on my TODO for
>  months now. Hopefully I'll get around to it in the 2.5 timeframe.

Agreed. I had a look in it, and it looked like a horrible mess.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
