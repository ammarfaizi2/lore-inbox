Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbUAZALz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 19:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbUAZALz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 19:11:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:36063 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265405AbUAZAJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 19:09:59 -0500
Subject: Re: [PATCH] Big powermac update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040125185549.GD15271@stop.crashing.org>
References: <1074825487.976.183.camel@gaston>
	 <20040123175443.GA15271@stop.crashing.org> <1074905912.834.43.camel@gaston>
	 <20040125185549.GD15271@stop.crashing.org>
Content-Type: text/plain
Message-Id: <1075075758.848.34.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 26 Jan 2004 11:09:18 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-26 at 05:55, Tom Rini wrote:
> On Sat, Jan 24, 2004 at 11:58:33AM +1100, Benjamin Herrenschmidt wrote:
> 
> > 
> > > 
> > > Can you please put the 970 register definitions into
> > > include/asm-ppc/reg_970.h or something along those lines?
> > 
> > I won't create a file for 3 registers :) Also, HID2/3 are defined
> > on other CPUs, as HIOR, none of these are strictly 970 specific
> > in fact though we only use them on it (coment may need fixing, bu
> > that's ok at this point).
> 
> Are they found on regular, classic PPCs or just on others in the
> 64bit family?  The problem is we don't want to let <asm/reg.h> get to be
> as bad as it used to be.

HID2 exist on some 750FX afaik, HID3 and upper probably only on
POWER4/GPUL at this point and HIOR is specific to HV capable CPUs,
but then, afgain, it's only 3 registers :)

Ben.
 

