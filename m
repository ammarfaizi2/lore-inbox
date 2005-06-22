Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVFVExp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFVExp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 00:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVFVExp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 00:53:45 -0400
Received: from fmr16.intel.com ([192.55.52.70]:12421 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261152AbVFVExl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 00:53:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Variation in measure_migration_cost() with scheduler-cache-hot-autodetect.patch in -mm
Date: Tue, 21 Jun 2005 21:53:35 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F03BF8F41@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Variation in measure_migration_cost() with scheduler-cache-hot-autodetect.patch in -mm
Thread-Index: AcV22TLEFdKtCI6xSZCyAOFjzvSYuQADPGUg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 22 Jun 2005 04:53:36.0752 (UTC) FILETIME=[59968700:01C576E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nitpick: 

> 		printk("could not vmalloc %d bytes for cache!\n", 2*max_size);

You should change this printk() message to not say "vmalloc".

-Tony
