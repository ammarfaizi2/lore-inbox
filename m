Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291088AbSBNJlz>; Thu, 14 Feb 2002 04:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291151AbSBNJlo>; Thu, 14 Feb 2002 04:41:44 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:20229 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S291088AbSBNJl1>; Thu, 14 Feb 2002 04:41:27 -0500
Date: Thu, 14 Feb 2002 11:41:26 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.2.20 RAM requirements
Message-ID: <20020214094126.GA19451@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16b5w1-0006Js-00@the-village.bc.nu> <200202140144.50805@pitt4u.2y.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202140144.50805@pitt4u.2y.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 01:48:28AM +0100, Christoph Pittracher wrote:
> On Wednesday 13 February 2002 21:23, Alan Cox wrote:
> > > I wanted to boot kernel version 2.2.20 on my old Pentium 75Mhz
> > > system with 16MB RAM. After "uncompressing linux" i get a: "Out Of
> > > Memory -- System halted".
> > > Kernel version 2.2.19 works without problems (same kernel
> > > configuration). I didn't tried 2.4 kernels yet, but I wonder that
> > > 2.2.20 needs so much memory?
> > It doesn't. What boot loader are you using ?
> 
> LILO version 21.5-1 beta
> from Debian 2.2r5.

If you are using zImage, try bzImage. zImage gives 'Out of memory -- System
halted' from version 2.2.20pre5 up to 2.2.20. In 2.2.21pre1 and pre2 it
works ok again.
