Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUAWRyz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 12:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbUAWRyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 12:54:55 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:31938 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S261406AbUAWRyy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 12:54:54 -0500
Date: Fri, 23 Jan 2004 10:54:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Big powermac update
Message-ID: <20040123175443.GA15271@stop.crashing.org>
References: <1074825487.976.183.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074825487.976.183.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 01:38:08PM +1100, Benjamin Herrenschmidt wrote:

> Hi !
> 
> Time for a big PowerMac merge, a bunch of these things are driver
> updates and machine support fixes that went in after the 2.6.0-rc
> code freeze, and support for newer machines (including 32 bits support
> for the G5).
> 
> This is for inclusion with -mm and possible comments, currently, the 51
> changesets are folded in one big patch. When it's time to merge with
> linus, he'll get them as separate csets.
> 
> The full support for the G5 also need a sungem driver update currently
> in davem's hands.
> 
> The full support for all recent pmacs also wants some fbdev updates that
> will come separately.
> 
> Too big to be posted here (and I didn't feel like using Greg's script to
> post 51 emails in burst to lkml :) so here's an URL to pick it up:
> 
> http://gate.crashing.org/~benh/big-pmac.diff

Can you please put the 970 register definitions into
include/asm-ppc/reg_970.h or something along those lines?

-- 
Tom Rini
http://gate.crashing.org/~trini/
