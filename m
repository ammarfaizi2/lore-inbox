Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVIBSwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVIBSwG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 14:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVIBSwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 14:52:05 -0400
Received: from fmr17.intel.com ([134.134.136.16]:16054 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750770AbVIBSwE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 14:52:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC/PATCH]reconfigure MSI registers after resume
Date: Fri, 2 Sep 2005 11:51:52 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502409A46689@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH]reconfigure MSI registers after resume
thread-index: AcWvgP6/kqn2YEtkRCKqrDfKWTRq3gAbcZ0Q
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Sep 2005 18:51:54.0094 (UTC) FILETIME=[62E1D8E0:01C5AFEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 01, 2005 10:38 PM Greg KH wrote:
>> Existing pci_save_state(dev)/pci_restore_state(dev) covers only 64
bytes
>> of PCI header. One solution is to extend these APIs to cover up to
256
>> bytes. What do you think?
> Will that solve this issue? 
Yes.

Thanks,
Tom
