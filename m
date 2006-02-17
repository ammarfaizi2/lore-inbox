Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWBQTxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWBQTxa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWBQTxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:53:30 -0500
Received: from fmr23.intel.com ([143.183.121.15]:63155 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751417AbWBQTx3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:53:29 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Problems with MSI-X on ia64
Date: Fri, 17 Feb 2006 11:52:45 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05BF610F@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with MSI-X on ia64
Thread-Index: AcYz9/703elSa4jRQLq5LtGGB4wwagAA5OxQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chris Wedgwood" <cw@f00f.org>,
       "Grant Grundler" <grundler@parisc-linux.org>
Cc: "Greg KH" <gregkh@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>,
       "Miller, Mike \(OS Dev\)" <Mike.Miller@hp.com>,
       "Jesse Barnes" <jbarnes@virtuousgeek.org>
X-OriginalArrivalTime: 17 Feb 2006 19:52:46.0452 (UTC) FILETIME=[B9417340:01C633FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hrm, it may be doing this.  I wonder how that works though with 4GB's
> of RAM installed?

Systems with 4G of RAM usually map part of the RAM above 4G so as to
leave a hole for i/o mapping etc.

-Tony
