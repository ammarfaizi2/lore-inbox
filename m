Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUBSVTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267321AbUBSVRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:17:11 -0500
Received: from fmr06.intel.com ([134.134.136.7]:25990 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267317AbUBSVPF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:15:05 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Intel x86-64 support patch breaks amd64
Date: Thu, 19 Feb 2004 13:14:27 -0800
Message-ID: <9AB83E4717F13F419BD880F5254709E5011EB8BE@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel x86-64 support patch breaks amd64
Thread-Index: AcP3K7kfN7QuPaosSemyMWcd+mvWewAAL6AQ
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <tony@atomide.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Feb 2004 21:14:27.0851 (UTC) FILETIME=[5B93D5B0:01C3F72D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Which change exactly is supposed to fix it? And why? 
> 
> For me the UP kernel boots just fine.
> 
> -Andi

GDT changes that I sent, fixes the boot problem. Its broken with CONFIG_X86_L1_CACHE_BYTES=64.

thanks,
suresh
