Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267331AbTBPSPY>; Sun, 16 Feb 2003 13:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267334AbTBPSPY>; Sun, 16 Feb 2003 13:15:24 -0500
Received: from crack.them.org ([65.125.64.184]:46267 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267331AbTBPSPW>;
	Sun, 16 Feb 2003 13:15:22 -0500
Date: Sun, 16 Feb 2003 13:25:12 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
Message-ID: <20030216182512.GB4861@nevyn.them.org>
Mail-Followup-To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>,
	linux-kernel@vger.kernel.org
References: <20030216171050.A12489@flint.arm.linux.org.uk> <Pine.SOL.3.96.1030216224235.25827A-100000@osiris.csa.iisc.ernet.in> <20030216174411.B12489@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030216174411.B12489@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 05:44:11PM +0000, Russell King wrote:
> Please copy replies back to lkml.
> 
> On Sun, Feb 16, 2003 at 10:43:01PM +0530, Rahul Vaidya wrote:
> > the command is giving me the following:
> > 
> > Reading specs from
> > /usr/local/gcc-3.2/lib/gcc-lib/i686-pc-linux-gnu/3.2/specs
> > Configured with: ../gcc-3.2/configure --prefix=/usr/local/gcc-3.2
> > Thread model: posix
> > gcc version 3.2
> >  /usr/local/gcc-3.2/lib/gcc-lib/i686-pc-linux-gnu/3.2/cpp0 -lang-c -v
> > -iprefix /usr/local/bin/../lib/gcc-lib/i686-pc-linux-gnu/3.2/
>                       ^^^^^^^^^^
> 
> It looks like gcc 3.2 thinks its compiler prefix is in a place where it
> is not.  I'd suggest you report this to the gcc people; at a guess, it
> may be due to gcc getting confused during its configuration:
> 
> 	../gcc-3.2/configure --prefix=/usr/local/gcc-3.2
>         ^^^

No, that doesn't affect the search path.  It's detecting a GCC in
/usr/local and assuming the installation was moved.  Rahul, what does
it say when you run it from its real location?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
