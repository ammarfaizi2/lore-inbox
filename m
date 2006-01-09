Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWAIT25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWAIT25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWAIT24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:28:56 -0500
Received: from amdext4.amd.com ([163.181.251.6]:30860 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751167AbWAIT2z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:28:55 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [patch 2/2] add x86-64 support for memory hot-add
Date: Mon, 9 Jan 2006 11:28:19 -0800
Message-ID: <6F7DA19D05F3CF40B890C7CA2DB13A42030949CF@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2/2] add x86-64 support for memory hot-add
Thread-Index: AcYVUo1T2TLm6sjOTraSQJ7/PXzP6gAAB+sg
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "keith" <kmannth@us.ibm.com>
cc: "Andi Kleen" <ak@suse.de>, "Matt Tolentino" <metolent@cs.vt.edu>,
       akpm@osdl.org, discuss@x86-64.org, linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 09 Jan 2006 19:28:21.0544 (UTC)
 FILETIME=[D9FDFA80:01C61552]
X-WSS-ID: 6FDC66DF0T02750853-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know, even yes, according to BKDG, you still need to update
related Routing Table in NB.

YH

-----Original Message-----
From: keith [mailto:kmannth@us.ibm.com] 
Sent: Monday, January 09, 2006 11:25 AM
To: Lu, Yinghai
Cc: Andi Kleen; Matt Tolentino; akpm@osdl.org; discuss@x86-64.org;
linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] add x86-64 support for memory hot-add

On Mon, 2006-01-09 at 10:51 -0800, Yinghai Lu wrote:
> for Opteron NUMA, need to update
> 0. stop the DCT on the node that will plug the new DIMM
> 1. read spd_rom for the added dimm
> 2. init the ram size and update the memory routing table...
> 3. init the timing...
> 4. update relate info in TOM and TOM2, and MTRR, and e820
> 
> It looks like we need to get some code about ram init from
LinuxBIOS.....

Is the AMD box not going to use the ACPI add-memory mechanism?


-- 
keith <kmannth@us.ibm.com>



