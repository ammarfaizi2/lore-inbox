Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSHRPEo>; Sun, 18 Aug 2002 11:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSHRPEo>; Sun, 18 Aug 2002 11:04:44 -0400
Received: from waste.org ([209.173.204.2]:2710 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S315214AbSHRPEo>;
	Sun, 18 Aug 2002 11:04:44 -0400
Date: Sun, 18 Aug 2002 10:08:31 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818150830.GR21643@waste.org>
References: <Pine.LNX.4.44.0208172019130.1537-100000@home.transmeta.com> <1029666605.15858.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029666605.15858.9.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 11:30:05AM +0100, Alan Cox wrote:
> 
> Its probably true there are low bits of randomness available from such
> sources providing we know the machine has a tsc, unless the I/O APIC is
> clocked at a divider of the processor clock in which case our current
> behaviour is probably much saner.

I actually looked at this a bit for embedded applications - there's a
technique for pulling entropy from free-running clock skew.

Unfortunately with modern chipsets, just about all clocks are
generated from a single source these days. This is even true in the
non-x86 world now. Any extra clocks you have are likely to be out in
peripheral-land and too slow (serial port) or too inaccessible (VGA
dot clocks) to be interesting.
 
> With modern systems that have real RNG's its a non issue.

Thankfully.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
