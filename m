Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288262AbSACRJU>; Thu, 3 Jan 2002 12:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288267AbSACRJK>; Thu, 3 Jan 2002 12:09:10 -0500
Received: from dialin-212-144-145-018.arcor-ip.net ([212.144.145.18]:15087
	"EHLO merv") by vger.kernel.org with ESMTP id <S288262AbSACRI6>;
	Thu, 3 Jan 2002 12:08:58 -0500
Date: Thu, 3 Jan 2002 18:08:37 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dual athlon XP 1800 problems
Message-ID: <20020103170837.GB737@bombe.modem.informatik.tu-muenchen.de>
Mail-Followup-To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020101152156.GB12799@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020101152156.GB12799@gallifrey>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2002 at 03:21:56PM +0000, Dr. David Alan Gilbert wrote:
>   5) I bought Athlon MPs because I didn't want the hastle of knowing
>   whether XPs would work or not.  Now sure, it could be AMD just trying
>   to squeeze some more money out of us; but it is entirely possible that
>    a) the chips could be different,

Unlikely.  The way from silicon wafer to chip is 4 to 8 weeks, so it's
more efficient (and makes it easier to follow the market) to produce one
line and select/configure them after production.

The differences are more like blown fuse links or external jumpers on
the carrier board that select a mode of operation.  I think the Celerons
have the actually same cache on the die as the Pentiums which is just
halved by a configuration fuse.

>                                      b) that the critical timing path in
>   the device could be in the cache snooping/consistency stuff (that
>   stuff is probably pretty hairy!).  I mean there must be a reason why
>   it took them a month and a half longer to release the Athlon MP 1.9GHz
>   than the XP 1.9GHz.

More likely.  There are essentially three types of possible XPs:

a) Passed MP, but market needs no more MPs
b) Not tested for MP, market asks for lots of XPs
c) Failed MP test, sold as XP

If you're lucky, you get a pair of type a) and it works.  Types b) and
c) may appear to work 99.9% of the time ("it works for me") but that
does not make a stable system.  Type c) may even work for months, until
the first summer sun shines into your room and gives the extra few
degrees of heat that crashes your system.

-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
