Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314213AbSEBBdD>; Wed, 1 May 2002 21:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314215AbSEBBdC>; Wed, 1 May 2002 21:33:02 -0400
Received: from oss.SGI.COM ([128.167.58.27]:50065 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S314213AbSEBBdB>;
	Wed, 1 May 2002 21:33:01 -0400
Date: Wed, 1 May 2002 18:32:50 -0700
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: discontiguous memory platforms
Message-ID: <20020501183250.A31464@dea.linux-mips.net>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship> <20020429153500.B28887@dualathlon.random> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <20020501180547.GA1212440@sgi.com> <20020502011750.M11414@dualathlon.random> <20020501232343.GA1214171@sgi.com> <20020501175133.A30649@dea.linux-mips.net> <20020502032725.S11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 03:27:25AM +0200, Andrea Arcangeli wrote:

> >  - 256MB at physical address 0
> >  - 512MB at physical address 0x80000000
> >  - 256MB at physical address 0xc0000000
> >  - The entire rest of the memory is mapped contiguously from physical
> >    address 0x1:00000000 up.
> >  All available memory is mapped from the lowest address up.
> 
> Is this a numa? If not then you should be just perfectly fine with
> discontigmem with this chip.

This is a system on a chip with memory controllers on die.  In theory
multiple of it can be combined to brew some crude ccNUMA system but I
don't know if people are actually doing that.

 Ralf
