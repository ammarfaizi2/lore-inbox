Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWB0SgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWB0SgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWB0SgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:36:15 -0500
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:16790 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751488AbWB0SgN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:36:13 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with MSI-X on ia64
Date: Mon, 27 Feb 2006 12:36:09 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10BB421EC@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with MSI-X on ia64
Thread-Index: AcY6JnnxGdR/81UZQ6O3W99cIuInOgBphBxA
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Grant Grundler" <grundler@parisc-linux.org>
Cc: "Grundler, Grant G" <grant.grundler@hp.com>,
       "Luck, Tony" <tony.luck@intel.com>, "Chris Wedgwood" <cw@f00f.org>,
       "Greg KH" <gregkh@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>,
       "Jesse Barnes" <jbarnes@virtuousgeek.org>,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>
X-OriginalArrivalTime: 27 Feb 2006 18:36:11.0373 (UTC) FILETIME=[AE8189D0:01C63BCC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Grant Grundler [mailto:grundler@parisc-linux.org] 
> Sent: Saturday, February 25, 2006 10:24 AM
> To: Miller, Mike (OS Dev)
> Cc: Grundler, Grant G; Luck, Tony; Chris Wedgwood; Grant 
> Grundler; Greg KH; linux-kernel@vger.kernel.org; 
> linux-scsi@vger.kernel.org; linux-ia64@vger.kernel.org; 
> linux-pci@atrey.karlin.mff.cuni.cz; Jesse Barnes; Patterson, 
> Andrew D (Linux R&D)
> Subject: Re: Problems with MSI-X on ia64
> 
> On Tue, Feb 21, 2006 at 02:21:42PM -0600, Miller, Mike (OS Dev) wrote:
> > So I looked at 2.6.16-rc3 which works in my lab, but phys_addr is 
> > still an int. How can that work?
> 
> "int" (u32) will work if the top bits are zero or alias to 
> the same thing as the full 64-bit address.
> Can you apply the patch and add printk's to dump the
> pci_resource_start(dev,bir) in msix_capability_init()?

My box is in a vegetative state. Working with HW folks to resolve.

mikem

> 
> 
> > I believe Andrew saw the same thing in 2.6.15.
> 
> Yes, AFIACT 2.6.15 has the same code.
> 
> thanks,
> grant
> 
