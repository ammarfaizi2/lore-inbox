Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbUAZP3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 10:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUAZP3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 10:29:36 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:55240 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S263803AbUAZP3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 10:29:35 -0500
Date: Mon, 26 Jan 2004 08:29:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Big powermac update
Message-ID: <20040126152921.GF15271@stop.crashing.org>
References: <1074825487.976.183.camel@gaston> <20040123175443.GA15271@stop.crashing.org> <1074905912.834.43.camel@gaston> <20040125185549.GD15271@stop.crashing.org> <1075075758.848.34.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075075758.848.34.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 11:09:18AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2004-01-26 at 05:55, Tom Rini wrote:
> > On Sat, Jan 24, 2004 at 11:58:33AM +1100, Benjamin Herrenschmidt wrote:
> > 
> > > 
> > > > 
> > > > Can you please put the 970 register definitions into
> > > > include/asm-ppc/reg_970.h or something along those lines?
> > > 
> > > I won't create a file for 3 registers :) Also, HID2/3 are defined
> > > on other CPUs, as HIOR, none of these are strictly 970 specific
> > > in fact though we only use them on it (coment may need fixing, bu
> > > that's ok at this point).
> > 
> > Are they found on regular, classic PPCs or just on others in the
> > 64bit family?  The problem is we don't want to let <asm/reg.h> get to be
> > as bad as it used to be.
> 
> HID2 exist on some 750FX afaik, HID3 and upper probably only on
> POWER4/GPUL at this point and HIOR is specific to HV capable CPUs,
> but then, afgain, it's only 3 registers :)

But that's how it starts out... :)  If it turns out that you need to add
more regs in later, can you please move all of the POWER4/GPUL
definitions into their own file?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
