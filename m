Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276135AbRJPNOo>; Tue, 16 Oct 2001 09:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276150AbRJPNOe>; Tue, 16 Oct 2001 09:14:34 -0400
Received: from mailhost.iitb.ac.in ([203.197.74.142]:15635 "HELO
	mailhost.iitb.ac.in") by vger.kernel.org with SMTP
	id <S276135AbRJPNOS>; Tue, 16 Oct 2001 09:14:18 -0400
Date: Tue, 16 Oct 2001 18:44:41 +0530
From: Ravindra Jaju <jaju@it.iitb.ac.in>
To: linux-kernel@vger.kernel.org
Subject: Re: P4 problems
Message-ID: <20011016184441.A15508@akash.it.iitb.ac.in>
In-Reply-To: <3BCC0A5B.846C20E8@psimation.com> <23891.1003232529@ocs3.intra.ocs.com.au> <20011016161209.A6038@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011016161209.A6038@stingr.net>; from i@stingr.net on Tue, Oct 16, 2001 at 04:12:09PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2001 at 04:12:09PM +0400, Paul P Komkoff Jr wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: RIPEMD160
> 
> Replying to Keith Owens:
> > If nobody can point to a known bug, try this to localize the problem.
> 
> I think this is a well-known bug. In apic init, we got cpu frequency xxxx.yy
> mhz, then bus frequency 0.000
> then we hang
> 
> :)
> 
> ( don't know solution - just get rid of these p4 ... for now. maybe later )

I thought this was some bug in some chipset I use, and enabled 
* chipset bugfix/support
options in my .config

****
[*]   CMD640 chipset bugfix/support
[*]   CMD640 enhanced support
[*]   RZ1000 chipset bugfix/support
[*]   Generic PCI IDE chipset support
[*]   Sharing PCI IDE interrupts support
[*]   Generic PCI bus-master DMA support
****

And I could boot.

I'm no expert, so if this information helps, good.

-- 
jaju
