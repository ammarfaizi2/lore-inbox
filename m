Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318487AbSHQISr>; Sat, 17 Aug 2002 04:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318514AbSHQISq>; Sat, 17 Aug 2002 04:18:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9732 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318487AbSHQISp>; Sat, 17 Aug 2002 04:18:45 -0400
Date: Sat, 17 Aug 2002 09:22:39 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Larry McVoy <lm@bitmover.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020817092239.A2211@flint.arm.linux.org.uk>
References: <Pine.GSO.4.21.0208162057550.14493-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 16, 2002 at 06:35:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 06:35:29PM -0700, Linus Torvalds wrote:
> And then in five years, in Linux-3.2, we might finally just drop support 
> for the old IDE code with PIO etc. Inevitably some people will still use 
> it (the same way some people still use Linux-2.0 with hd.c), but it won't 
> have been in the way for making a cleaner driver in the meantime.

I think you're being too ""mainstream" orientated" here.  Let's look
at something called PCMCIA.  PCMCIA CF cards.  They're IDE devices
that only do PIO.

The majority of ARM platforms being actively produced today provide a
PCMCIA or CF (_not_ cardbus) socket.  Neither PCI nor Cardbus makes any
sense in these machines.  Why?  Because they're not your average power
hungry desktop box that's always plugged into the mains supply.

I think we're going to have PIO mode IDE around for a fair (ten at
least?) number of years yet.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

