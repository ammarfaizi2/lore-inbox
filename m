Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVDDWIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVDDWIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVDDWFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:05:34 -0400
Received: from fmr17.intel.com ([134.134.136.16]:26288 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261421AbVDDWBa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:01:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Accessing performance counters for a processor in a multi-processor environment
Date: Mon, 4 Apr 2005 14:57:13 -0700
Message-ID: <D30E01168D637641AA9D3667F3BB74160426A646@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-topic: Accessing performance counters for a processor in a multi-processor environment
Thread-Index: AcU5YUImFVYKhjcSThuLYVPFbIcRdw==
From: "Abhinkar, Sameer" <sameer.abhinkar@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Apr 2005 21:58:41.0800 (UTC) FILETIME=[76D1D080:01C53961]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm a newbie in Linux kernel development and hopefully my question has
some quick solution..

I'm trying to access performance counters on a dual Xeon processor
machine (both processors are 32-bit and HT enabled). Since each
processor (logical/physical) has their own performance counter, I'd like
to get the numbers for a processor. Is there a way I can do some
pre-work before executing rdpmc instruction to set up the context to
access counter information of a certain processor? Or, what is the best
way to do get the counter information for a certain processor in a
multi-processor environment.

If anybody has some information, I'd really grateful..

Thanks in advance,

Regards,
Sameer
