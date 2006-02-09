Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422905AbWBIRE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422905AbWBIRE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422892AbWBIRE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:04:58 -0500
Received: from fmr21.intel.com ([143.183.121.13]:51397 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S965239AbWBIRE5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:04:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [Lhms-devel] [RFC:PATCH(000/003)] Memory add to onlined node. (ver. 2)
Date: Thu, 9 Feb 2006 09:04:43 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05AA16C3@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lhms-devel] [RFC:PATCH(000/003)] Memory add to onlined node. (ver. 2)
Thread-Index: AcYtR3OCbasF05daTp6P1eV/NPvM5gAUwAOg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Yasunori Goto" <y-goto@jp.fujitsu.com>, "Andi Kleen" <ak@suse.de>,
       "Brown, Len" <len.brown@intel.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       "S, Naveen B" <naveen.b.s@intel.com>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: "ACPI-ML" <linux-acpi@vger.kernel.org>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>, "x86-64 Discuss" <discuss@x86-64.org>,
       "Linux Hotplug Memory Support" <lhms-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 09 Feb 2006 17:04:44.0821 (UTC) FILETIME=[ECD4A450:01C62D9A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - if the node is already online.-  If the node is offline, 
> (It means new node is comming!)  then the memory will belongs
> to node 0 yet.

What is the long term plan to address this?  Can you make sure
that the new node is always brought online before you get to
this code?  Or will you have to bring the node online in the
middle of the memory hot-add code?

Presumably there is a similar issue with hot add cpu.

-Tony
