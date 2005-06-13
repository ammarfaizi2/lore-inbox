Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVFMQRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVFMQRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVFMQRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:17:05 -0400
Received: from fmr18.intel.com ([134.134.136.17]:4776 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261706AbVFMQQu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:16:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Penance PATCH] PCI: clean up the MSI code a bit
Date: Mon, 13 Jun 2005 09:15:22 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502408E23C39@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Penance PATCH] PCI: clean up the MSI code a bit
Thread-Index: AcVt1H5cco+xX5rhS/232VRlN8tLZQCXatIA
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Stefan Smietanowski" <stesmi@stesmi.com>
Cc: "Andi Kleen" <ak@suse.de>, "Greg KH" <gregkh@suse.de>,
       "Grant Grundler" <grundler@parisc-linux.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <linux-kernel@vger.kernel.org>,
       "Roland Dreier" <roland@topspin.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Vasquez" <andrew.vasquez@qlogic.com>,
       "Jeff Garzik" <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 13 Jun 2005 16:15:24.0233 (UTC) FILETIME=[1AA10390:01C57033]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 10, 2005 8:56 AM Stefan Smietanowski wrote:
> If we default to MSI mode, then that is replaced by
> pci_disable_msi(dev); pci_enable_msix(dev, .., ..);
> with any error checking required, etc.
>
> If we implement an error code for each of the cases, so that
> the driver KNOWS which mode it's in after pci_enable_msix() is called
> I don't see a difference. I'm not an expert on the subject and likely
> missing things but ..

You have a good point. Please save your discussion and bring it back
when Linux Community's inputs agree that we should default to MSI mode.

Thanks,
Long
