Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282898AbRLLXx7>; Wed, 12 Dec 2001 18:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282904AbRLLXxu>; Wed, 12 Dec 2001 18:53:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49680 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282898AbRLLXxo>; Wed, 12 Dec 2001 18:53:44 -0500
Date: Wed, 12 Dec 2001 23:53:14 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: Alp ATICI <atici@math.columbia.edu>, linux-kernel@vger.kernel.org
Subject: Re: Network related
Message-ID: <20011212235314.B4606@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.40.0112121821260.4894-100000@intel4.math.columbia.edu> <20011212183843.3db1580b.dang@fprintf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011212183843.3db1580b.dang@fprintf.net>; from dang@fprintf.net on Wed, Dec 12, 2001 at 06:38:43PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 06:38:43PM -0500, Daniel Gryniewicz wrote:
> My guess is that this is becuase you have IPv6 turned on, and these sites
> resolve to an IPv6 address, as well as an IPv4 address.  Linux will not,
> under these circumstances, fall back on the IPv4 address.  Turn of IPv6,
> or connect to the 6bone.

Good theory, apart from a major flaw - www.nvidia.com nor www.sun.com
resolve to any IPv6 records (AAAA nor A6).

A better explaination would probably be ECN, and indeed, I am unable to
reach www.sun.com from a local ECN-enabled host.

> On Wed, 12 Dec 2001 18:29:17 -0500 (EST)
> Alp ATICI <atici@math.columbia.edu> wrote:
> 
> > I get a "connection timed out". Most of the sites work ok but some
> > specific ones like www.nvidia.com, www.sun.com, www.ingdirect.com
> > never works and gives the same error.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

