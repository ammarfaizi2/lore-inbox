Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSHBP45>; Fri, 2 Aug 2002 11:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSHBP45>; Fri, 2 Aug 2002 11:56:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9478 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316309AbSHBP4s>; Fri, 2 Aug 2002 11:56:48 -0400
Date: Fri, 2 Aug 2002 17:00:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: gerg <gerg@snapgear.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.30uc0 MMU-less patches
Message-ID: <20020802170007.E11451@flint.arm.linux.org.uk>
References: <20020802145034.B24631@parcelfarce.linux.theplanet.co.uk> <3D4AAA87.8050508@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D4AAA87.8050508@snapgear.com>; from gerg@snapgear.com on Sat, Aug 03, 2002 at 01:51:35AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2002 at 01:51:35AM +1000, gerg wrote:
> Matthew Wilcox wrote:
> >  - the Makefile changes seem terribly inappropriate.
> Some simplify cross compilation (like the ARCH and CROSS_COMPILE changes).

make ARCH=foo CROSS_COMPILE=arm-linux-

variables on makes command line override variables in the makefile.

> >  - drivers/char/mcfserial.c needs to be converted to the new serial core
> >    and moved to drivers/serial.
> >  - ditto arch/m68knommu/platform/68360/quicc/uart.c
> 
> Yep, I am looking at that now. That will take me a little
> effort and time to put together.

You should be aware that I'm going to be submitting a minor change in
the interface (as detailed in Documentation/serial/driver) soon, mainly
to make Dave Miller happy.  Patch soon to be available.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

