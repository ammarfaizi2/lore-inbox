Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267503AbUHWUYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267503AbUHWUYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUHWUX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:23:59 -0400
Received: from fmr06.intel.com ([134.134.136.7]:2277 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267503AbUHWTm2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:42:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] [broken?] Add MSI support to e1000
Date: Mon, 23 Aug 2004 12:41:36 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50240619DA25@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [broken?] Add MSI support to e1000
Thread-Index: AcSJR6O1FNuvxeX3RhqNsDZ9iFnUdgAAKZow
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Andi Kleen" <ak@muc.de>, "Roland Dreier" <roland@topspin.com>
Cc: <linux-kernel@vger.kernel.org>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 23 Aug 2004 19:41:39.0134 (UTC) FILETIME=[35328DE0:01C48949]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 23, 2004 Andi Kleen wrote:
>There seems to be something wrong with the MSI code in the kernel.
>I tried to add MSI support to the s2io driver on x86-64, but it just
didn't
>work (/proc/interrupts still displayed IO-APIC mode). I haven't 
>investigated in detail yet though.

Would you please tell me whether the MSI enable bit of the MSI
capability 
structure of the s2io device is set or not after successfully calling 
pci_enable_msi()?

Thanks,
Long
