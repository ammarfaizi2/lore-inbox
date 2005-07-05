Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVGEUE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVGEUE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 16:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVGEUE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 16:04:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46746 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261736AbVGEUEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 16:04:20 -0400
Date: Tue, 5 Jul 2005 21:05:55 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci: restore BAR values in pci_enable_device_bars
Message-ID: <20050705200555.GA4756@parcelfarce.linux.theplanet.co.uk>
References: <20050623191451.GA20572@tuxdriver.com> <20050624022807.GF28077@tuxdriver.com> <20050630171010.GD11369@kroah.com> <20050701014056.GA13710@tuxdriver.com> <20050701022634.GA5629.1@tuxdriver.com> <20050702072954.GA14091@colo.lackof.org> <20050702090913.B1506@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050702090913.B1506@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2005 at 09:09:13AM +0100, Russell King wrote:
> The PCI subsystem is incomplete for 64-bit BAR support.  What it does
> do though is ensure that 64-bit BARs will work correctly in a 32-bit
> system.  Therefore, I think that folk who want 64-bit BAR support to
> work need to do some code reviews on the PCI subsystem to resolve the
> remaining issues.

64-bit BARs work fine on 64-bit machines.  I'm ambivalent whether we
ought to support 64-bit BARs on 32-bit machines.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
