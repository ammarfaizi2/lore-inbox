Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbSJ2RXT>; Tue, 29 Oct 2002 12:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbSJ2RXT>; Tue, 29 Oct 2002 12:23:19 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:4071 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262120AbSJ2RXP>;
	Tue, 29 Oct 2002 12:23:15 -0500
Date: Tue, 29 Oct 2002 09:29:32 -0800
To: Adrian Bunk <bunk@fs.tum.de>
Cc: James McKenzie <james@fishsoup.dhs.org>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [2.5 patch] allow only one Toshiba Type-O IR Port driver in the kernel
Message-ID: <20021029172932.GE32449@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20021021173233.GA20616@bougret.hpl.hp.com> <Pine.NEB.4.44.0210291619310.14144-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0210291619310.14144-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 04:26:50PM +0100, Adrian Bunk wrote:
> On Mon, 21 Oct 2002, Jean Tourrilhes wrote:
> 
> > 	Adrian,
> 
> Hi Jean,
> 
> > 	Thanks very much for the report. I personally uses modules,
> > and I would prefer the ability to compile both modules, so that people
> > can try both without having to recompile their kernel.
> 
> notice that my patch doesn't disallow to build both drivers as modules.
> 
> > 	I think a much better patch (and simpler in the long term)
> > would be to just rename 'toshoboe_init' to 'donauboe_init' (plus the
> > few other offending function). This is a case where the name doesn't
> > really matter.
> > 	What do you think ?
> 
> That's an alternate solution that should also fix the compile problem.
> 
> But as stated above my patch doesn't affect the case when both drivers are
> modular which is usually the desired setup when you want to switch between
> the two drivers.

	I personally prefer to make the driver code cleaner rather
than making the config/Makefile rules more complex. I believe that in
the long run, it always pay to keep things simple.
	But, I'm not religious about it.

> cu
> Adrian

	How do we proceed ? Do you want to send patches yourself
directly, or do you want to wait until I send my next IrDA update ?
	Regards,

	Jean

