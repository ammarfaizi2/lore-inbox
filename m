Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUDPAlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 20:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUDPAlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 20:41:45 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:57552 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261162AbUDPAlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 20:41:44 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Subject: Re: [PATCH] PCI MSI Kconfig consolidation
Date: Thu, 15 Apr 2004 18:41:24 -0600
User-Agent: KMail/1.6.1
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>, "Zwane Mwaikambo" <zwane@linuxpower.ca>,
       "Grant Grundler" <iod00d@hp.com>
References: <C7AB9DA4D0B1F344BF2489FA165E502404058251@orsmsx404.jf.intel.com>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502404058251@orsmsx404.jf.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404151841.24254.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 April 2004 2:49 pm, Nguyen, Tom L wrote:
> Based on your PCI MSI Kconfig consolidation patch, the below patch converts the
> use of CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI. Please let us know your comments.

Looks good to me.  We still have the #ifdefs in drivers/acpi/osl.s, but I
have a patch outstanding to remove that, since everybody now
implements acpi_gsi_to_irq().  I'll update my patch if yours goes
in first.
