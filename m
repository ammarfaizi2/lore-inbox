Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbVIBOzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVIBOzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVIBOzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:55:51 -0400
Received: from fmr19.intel.com ([134.134.136.18]:15848 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750991AbVIBOzu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:55:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: SMT_ID or APIC_ID caching
Date: Fri, 2 Sep 2005 07:55:48 -0700
Message-ID: <194B303F2F7B534594F2AB2D87269D9F06FC87EE@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SMT_ID or APIC_ID caching
Thread-Index: AcWvzmey2dezswXYQk+MRzUbHtBLHw==
From: "Wilkerson, Bryan P" <Bryan.P.Wilkerson@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Sep 2005 14:55:49.0669 (UTC) FILETIME=[683A1D50:01C5AFCE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On a P4 with HT, I'm trying to get the logical processor ID (SMT_ID) for
the currently executing thread in kernel mode.  The SMT_ID is part of
the APIC_ID which is in EBX[24:16] after calling cpuid with EAX=1.

Is the SMT_ID or APIC_ID per_cpu cached by the kernel anywhere?

Thanks,

-bryan
