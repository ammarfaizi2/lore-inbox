Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWAIPtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWAIPtL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWAIPtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:49:10 -0500
Received: from fmr16.intel.com ([192.55.52.70]:13024 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S964824AbWAIPtJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:49:09 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/2] add __meminit for memory hotplug
Date: Mon, 9 Jan 2006 07:48:43 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C0B7097@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/2] add __meminit for memory hotplug
Thread-Index: AcYVMw0DfY//mIduQ62YyKmiBpHqCgAAJ4cg
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Andi Kleen" <ak@suse.de>, "Matt Tolentino" <metolent@cs.vt.edu>
Cc: <akpm@osdl.org>, <discuss@x86-64.org>, <kmannth@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Jan 2006 15:48:46.0735 (UTC) FILETIME=[2D31A9F0:01C61534]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <mailto:ak@suse.de> wrote:
> On Monday 09 January 2006 16:19, Matt Tolentino wrote:
> 
>> Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com> ---
>> diff -urNp linux-2.6.15/arch/i386/mm/init.c
>> linux-2.6.15-matt/arch/i386/mm/init.c ---
>> linux-2.6.15/arch/i386/mm/init.c	2006-01-02 22:21:10.000000000
-0500
>> +++ linux-2.6.15-matt/arch/i386/mm/init.c	2006-01-06
>> 11:06:44.000000000 -0500  
> 
> Won't this need an x86-64 specific patch too?   I don't think
> any code in x86-64 has __meminit yet.

Right, this patch only changes the existing code that is already
in the tree.  For x86-64, these additions are in the hot-add patch.

matt
