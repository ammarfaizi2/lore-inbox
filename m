Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269265AbUIYLTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269265AbUIYLTx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 07:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269284AbUIYLTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 07:19:53 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:25093 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S269265AbUIYLTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 07:19:50 -0400
Date: Sat, 25 Sep 2004 14:18:48 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartmann <greg@kroah.com>, Len Brown <len.brown@intel.com>,
       tony.luck@intel.com, acpi-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org
Subject: Re: [ACPI] [PATCH] Updated patches for PCI IRQ resource deallocation
 support [2/3]
In-Reply-To: <Pine.LNX.4.53.0409251401560.2914@musoma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0409251416570.2908@musoma.fsmlabs.com>
References: <Pine.LNX.4.53.0409251356110.2914@musoma.fsmlabs.com>
 <Pine.LNX.4.53.0409251401560.2914@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004, Zwane Mwaikambo wrote:

> Kenji Kaneshige wrote:
> 
> >     - Changed acpi_pci_irq_disable() to leave 'dev->irq' as it
> >       is. Clearing 'dev->irq' by some magic constant
> >       (e.g. PCI_UNDEFINED_IRQ) is TBD.
> 
> This may not be safe with CONFIG_PCI_MSI, you may want to verify against 
> that if you already haven't.
> 
> > +acpi_unregister_gsi (unsigned int irq)
> > +{
> > +}
> > +EXPORT_SYMBOL(acpi_unregister_gsi);
> 
> Why not just make these static inlines in header files? Since you're on 
> this, how about making irq_desc and friends dynamic too?

Sorry, i broke Cc.
