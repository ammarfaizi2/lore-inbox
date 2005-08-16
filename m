Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVHPUo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVHPUo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbVHPUo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:44:56 -0400
Received: from fmr14.intel.com ([192.55.52.68]:46311 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932441AbVHPUoz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:44:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Multiple virtual address mapping for the same code on IA-64 linux kernel.
Date: Tue, 16 Aug 2005 13:44:50 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F04294461@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Multiple virtual address mapping for the same code on IA-64 linux kernel.
Thread-Index: AcWioji5ltHCX38GTymx/ljVBn7HXgAANkwg
From: "Luck, Tony" <tony.luck@intel.com>
To: "vamsi krishna" <vamsi.krishnak@gmail.com>, <linux-ia64@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Aug 2005 20:44:54.0209 (UTC) FILETIME=[5B1F8B10:01C5A2A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I have been investigating a problem in which there has been a dramatic
> core size (complete program size) of a program running on a IA-64
>machine running kernel version 2.4.21-4.0.1 (A redhat advanced server
>distribution) compared to other 64-bit architectures like amd64 and
>EM64T. There has been an increase of around 20% of the size.

Itanium instruction set is not as compact as some other architectures,
so the same program will typically require more bytes of code.

-Tony
