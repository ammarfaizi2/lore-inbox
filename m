Return-Path: <linux-kernel-owner+w=401wt.eu-S1750840AbXAIJLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbXAIJLU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbXAIJLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:11:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:34776 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbXAIJLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:11:19 -0500
Subject: Re: Linux 2.6.20-rc4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sylvain Munaut <tnt@246tNt.com>, Greg KH <gregkh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       paulus@samba.org
In-Reply-To: <1168327701.14763.324.camel@shinybook.infradead.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <200701081550.27748.m.kozlowski@tuxland.pl> <45A25C17.5070606@246tNt.com>
	 <1168303139.22458.246.camel@localhost.localdomain>
	 <20070109005624.GA598@suse.de>
	 <1168308323.22458.254.camel@localhost.localdomain>
	 <45A340E4.5030702@246tNt.com>
	 <1168327701.14763.324.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 20:08:54 +1100
Message-Id: <1168333734.22458.269.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 15:28 +0800, David Woodhouse wrote:
> On Tue, 2007-01-09 at 08:14 +0100, Sylvain Munaut wrote:
> > But maybe the question we should ask is why would it build
> > drivers/usb/host/ohci-ppc-soc.c for an iMac G3 ... Because that problem
> > (ohci multiple glue in module) is there since a long time, just never
> > spotted before.
> 
> Are you suggesting that distributions must choose to support OHCI from
> _either_ PCI or OF but not both?

I think not. What he meant I suppose is that in -addition- to the
problem that needs to be fixed, there is another one where efika support
defaults to y in Kconfig, thus gets enabled for pmac32_defconfig etc...

Ben.


