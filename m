Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWAIT7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWAIT7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWAIT7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:59:36 -0500
Received: from fmr15.intel.com ([192.55.52.69]:63709 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751270AbWAIT7e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:59:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2/2] add x86-64 support for memory hot-add
Date: Mon, 9 Jan 2006 11:58:15 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C0B7793@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2/2] add x86-64 support for memory hot-add
Thread-Index: AcYVVFBbPvr6kiW2QbGUiYryMth1ggAAmKsw
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Andi Kleen" <ak@suse.de>, "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "keith" <kmannth@us.ibm.com>, "Matt Tolentino" <metolent@cs.vt.edu>,
       <akpm@osdl.org>, <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Jan 2006 19:58:16.0984 (UTC) FILETIME=[08286180:01C61557]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <mailto:ak@suse.de> wrote:
> On Monday 09 January 2006 20:28, Lu, Yinghai wrote:
>> I don't know, even yes, according to BKDG, you still need to update
>> related Routing Table in NB.
> 
> I don't really want any memory controller or HT routing
> touching code in the kernel. It would be far too fragile.
> Pushing that work over to firmware using ACPI seems like
> the right thing to do.

The proposals I've seen for NUMA systems have all done this
through ACPI.  

matt
