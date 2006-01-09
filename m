Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWAITzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWAITzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWAITzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:55:32 -0500
Received: from fmr15.intel.com ([192.55.52.69]:21725 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751255AbWAITzb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:55:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2/2] add x86-64 support for memory hot-add
Date: Mon, 9 Jan 2006 11:55:11 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C0B777A@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2/2] add x86-64 support for memory hot-add
Thread-Index: AcYVMsbswUoGyIFLT0eK7vob0QjQ0gAIzZZA
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Andi Kleen" <ak@suse.de>, "Matt Tolentino" <metolent@cs.vt.edu>
Cc: <akpm@osdl.org>, <discuss@x86-64.org>, <kmannth@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Jan 2006 19:55:13.0348 (UTC) FILETIME=[9AB3C040:01C61556]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <mailto:ak@suse.de> wrote:
> On Monday 09 January 2006 16:21, Matt Tolentino wrote:
>> Add x86-64 specific memory hot-add functions, Kconfig options,
>> and runtime kernel page table update functions to make
>> hot-add usable on x86-64 machines.  Also, fixup the nefarious
>> conditional locking and exports pointed out by Andi.
> 
> I'm trying to stabilize my tree for the 2.6.16 submission right now
> and this one comes a bit too late and is a bit too involved
> to slip through - sorry. I will consider it after Linus
> has merged the whole batch of changes for 2.6.16 - so hopefully
> in 2.6.17.
> 
>> +/*
>> + * Memory hotplug specific functions
>> + * These are only for non-NUMA machines right now.
> 
> How much work would it be to allow it for NUMA kernels too?

I've looked at it in the past, but haven't pursued it to 
date, nor have I quantified the work involved.
The reason for the this approach thus far has been to 
enable machines that support hot-add today...which are 
non-NUMA.  

matt
