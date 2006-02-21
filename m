Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWBUUWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWBUUWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWBUUWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 15:22:12 -0500
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:57733 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S932238AbWBUUWJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 15:22:09 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with MSI-X on ia64
Date: Tue, 21 Feb 2006 14:21:42 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10BAD8CA9@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with MSI-X on ia64
Thread-Index: AcYz/W30SdnG64fUQcK3cOXr6nYDrQDJq8ww
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Grundler, Grant G" <grant.grundler@hp.com>,
       "Luck, Tony" <tony.luck@intel.com>
Cc: "Chris Wedgwood" <cw@f00f.org>,
       "Grant Grundler" <grundler@parisc-linux.org>,
       "Greg KH" <gregkh@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>,
       "Jesse Barnes" <jbarnes@virtuousgeek.org>,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>
X-OriginalArrivalTime: 21 Feb 2006 20:21:43.0684 (UTC) FILETIME=[6E610440:01C63724]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Grundler, Grant G 
> 
> On Fri, Feb 17, 2006 at 11:52:45AM -0800, Luck, Tony wrote:
> > > Hrm, it may be doing this.  I wonder how that works though with 
> > > 4GB's of RAM installed?
> > 
> > Systems with 4G of RAM usually map part of the RAM above 4G 
> so as to 
> > leave a hole for i/o mapping etc.
> 
> exactly.
> rx2600 physical memory map only has 1GB of RAM below 4GB 
> address space.

So I looked at 2.6.16-rc3 which works in my lab, but phys_addr is still
an int. How can that work? I believe Andrew saw the same thing in
2.6.15.

mikem
