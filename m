Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVCRSd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVCRSd7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 13:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVCRSd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 13:33:59 -0500
Received: from fmr19.intel.com ([134.134.136.18]:18352 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262037AbVCRSdy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 13:33:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PCI Error Recovery API Proposal. (WAS:: [PATCH/RFC]PCIErrorRecovery)
Date: Fri, 18 Mar 2005 10:33:00 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024081328D4@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI Error Recovery API Proposal. (WAS:: [PATCH/RFC]PCIErrorRecovery)
Thread-Index: AcUr5YSlEJHCIBHaTGOkGPVAIXlbjAAAsOBQ
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Grant Grundler" <grundler@parisc-linux.org>
Cc: "Paul Mackerras" <paulus@samba.org>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Hidetoshi Seto" <seto.hidetoshi@jp.fujitsu.com>,
       "Greg KH" <greg@kroah.com>, <linux-kernel@vger.kernel.org>, <ak@muc.de>,
       "linuxppc64-dev" <linuxppc64-dev@ozlabs.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>
X-OriginalArrivalTime: 18 Mar 2005 18:33:06.0514 (UTC) FILETIME=[ED64CB20:01C52BE8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 18, 2005 10:10 AM Grant Grundler wrote:
>A port bus driver does NOT sound like a normal device driver.
>If PCI Express defines a standard register set for a bridge
>device (like PCI COnfig space for PCI-PCI Bridges), then I
>don't see a problem with PCI-Express error handling code mucking
>with those registers. Look at how PCI-PCI bridges are supported
>today and which bits of code poke registers on PCI-PCI Bridges.

Please refer to PCIEBUS-HOWTO.txt for how port bus driver works.

Thanks,
Long
