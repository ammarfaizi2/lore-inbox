Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUJARLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUJARLB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 13:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUJARLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 13:11:01 -0400
Received: from fmr06.intel.com ([134.134.136.7]:53457 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264980AbUJARKb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 13:10:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2.6.9-rc2-mm4 - Getting dev->irq equals 0
Date: Fri, 1 Oct 2004 10:10:00 -0700
Message-ID: <468F3FDA28AA87429AD807992E22D07E02B9512F@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.9-rc2-mm4 - Getting dev->irq equals 0
Thread-Index: AcSn2XvdGIBFQ4FUSq6XTIB18iOG9Q==
From: "Sy, Dely L" <dely.l.sy@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Oct 2004 17:10:01.0751 (UTC) FILETIME=[7CD85270:01C4A7D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I encountered a problem in running shpchp & pciehp drivers on
2.6.9-rc2-mm4 kernel.  With ACPI & MSI enabled in the kernel, I 
got dev->irq properly for the hot-plug controllers.  With ACPI 
enabled and MSI not-enabled in this kernel, I got dev->irq 
equal 0 for the controllers. With the same options set in 
2.6.8.1 & 2.6.9-rc2, things worked fine on the same system.

Do you know of any changes in the -mm4 that might have caused this
problem?

Thanks,
Dely
