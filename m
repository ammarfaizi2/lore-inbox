Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbUCASNz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 13:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbUCASNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 13:13:55 -0500
Received: from fmr99.intel.com ([192.55.52.32]:56014 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S261384AbUCASNy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 13:13:54 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
Date: Mon, 1 Mar 2004 10:13:39 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE999@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
Thread-Index: AcP/YPga8b5c8KVUQYeqXAPBwMmV0wAVzqUA
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Mar 2004 18:13:40.0248 (UTC) FILETIME=[EC723980:01C3FFB8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have rewritten and compiled tested the boot_ioremap code but I don't
> have a configuration to test it. This effects the EFI code and the
> numa srat code.   It might be worth replacing boot_ioremap with __va()
> to reduce the amount of error checking necessary.

I just blindly applied this patch and tried it on an x86 EFI system
with no luck.  It's not mapping correctly for some reason.  I'll look
at the problem closer in a bit.
 
matt 
