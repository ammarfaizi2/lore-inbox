Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVBLXVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVBLXVm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 18:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVBLXVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 18:21:42 -0500
Received: from dialin-159-245.tor.primus.ca ([216.254.159.245]:12928 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261211AbVBLXVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 18:21:40 -0500
Date: Sat, 12 Feb 2005 18:21:34 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: irq 10: nobody cared! (was: Re: 2.6.11-rc3-mm1)
Message-ID: <20050212232134.GA2242@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050204103350.241a907a.akpm@osdl.org> <20050205224558.GB3815@ime.usp.br> <20050212222104.GA1965@node1.opengeometry.net> <20050212224715.GA8249@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050212224715.GA8249@ime.usp.br>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 08:47:15PM -0200, Rog?rio Brito wrote:
> On Feb 12 2005, William Park wrote:
> > On Sat, Feb 05, 2005 at 08:45:58PM -0200, Rog?rio Brito wrote:
> > > For some kernel versions (say, since 2.6.10 proper, all the 2.6.11-rc's,
> > > some -mm trees and also -ac) I have been getting the message "irq 10:
> > > nobody cared!".
> > 
> > Try 'acpi=noirq'.
> 
> Unfortunately, I have already tried that and I still get stack traces
> like this one (this time, booted without any acpi-related option):
...
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
> PCI: setting IRQ 10 as level-triggered
> ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 10 (level, low) -> IRQ 10

This looks awefully like 'acpi' is on.  If 'acpi=noirq' does not work,
then try 'pci=noacpi'.

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
Slackware Linux -- because I can type.
