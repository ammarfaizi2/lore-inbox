Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbUAYS4D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 13:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUAYS4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 13:56:02 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:5347 "EHLO fed1mtao08.cox.net")
	by vger.kernel.org with ESMTP id S265162AbUAYS4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 13:56:00 -0500
Date: Sun, 25 Jan 2004 11:55:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Big powermac update
Message-ID: <20040125185549.GD15271@stop.crashing.org>
References: <1074825487.976.183.camel@gaston> <20040123175443.GA15271@stop.crashing.org> <1074905912.834.43.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074905912.834.43.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 11:58:33AM +1100, Benjamin Herrenschmidt wrote:

> 
> > 
> > Can you please put the 970 register definitions into
> > include/asm-ppc/reg_970.h or something along those lines?
> 
> I won't create a file for 3 registers :) Also, HID2/3 are defined
> on other CPUs, as HIOR, none of these are strictly 970 specific
> in fact though we only use them on it (coment may need fixing, bu
> that's ok at this point).

Are they found on regular, classic PPCs or just on others in the
64bit family?  The problem is we don't want to let <asm/reg.h> get to be
as bad as it used to be.

-- 
Tom Rini
http://gate.crashing.org/~trini/
