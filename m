Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264745AbTI2UfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 16:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbTI2UfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 16:35:12 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:7091 "EHLO fed1mtao06.cox.net")
	by vger.kernel.org with ESMTP id S264745AbTI2UfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 16:35:06 -0400
Date: Mon, 29 Sep 2003 13:34:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Judith Lebzelter <judith@osdl.org>
Cc: linux-kernel@vger.kernel.org, plm-devel@lists.sourceforge.net
Subject: Re: PowerPC Cross-compile of 2.6 kernels
Message-ID: <20030929203451.GB7563@ip68-0-152-218.tc.ph.cox.net>
References: <20030929165408.GA4102@ip68-0-152-218.tc.ph.cox.net> <Pine.LNX.4.33.0309291310080.21025-100000@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309291310080.21025-100000@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 01:21:53PM -0700, Judith Lebzelter wrote:
> On Mon, 29 Sep 2003, Tom Rini wrote:
> 
> >
> > As of 2.6.0-test6, allyesconfig (with no fiddling of other options)
> > on PPC is as sane as it's going to be. :)
> >
> 
> Does this mean that the results of the compile are not useful or even
> confusing, since they do not fuss with configuration options?  Would it be
> better not to run the 'allyesconfig' option?

Well, on PPC we get CONFIG_ISA, which is useful for a few drivers, but I
suspect that it will enable a number of 'other' drivers as well.  I'm
not sure what would be more useful however.

-- 
Tom Rini
http://gate.crashing.org/~trini/
