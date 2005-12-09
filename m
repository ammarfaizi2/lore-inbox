Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVLIPOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVLIPOL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVLIPOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:14:10 -0500
Received: from ap1.cs.vt.edu ([128.173.40.39]:48853 "EHLO ap1.cs.vt.edu")
	by vger.kernel.org with ESMTP id S932203AbVLIPOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:14:09 -0500
Date: Fri, 9 Dec 2005 10:13:22 -0500
From: Matt Tolentino <metolent@cs.vt.edu>
Message-Id: <200512091513.jB9FDMRb006562@ap1.cs.vt.edu>
To: ak@muc.de, akpm@osdl.org
Subject: [patch 0/3] x86-64 memory hotplug support and fixups
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following this mail are three memory hotplug patches.  The first
two are trivial patches that merely remove warnings in the 1)ACPI
memory hotplug driver and 2) sparsemem code - these do not affect
functionality in either case.  The third patch includes x86-64
specific support for memory hot-add on single node (non-NUMA)
systems. These changes are specifically isolated to the arch.  

Patches are against linux-2.6.15-rc5.  I've tested the x86-64 
memory hotplug patch for logical and physical hot-add operations. 
Please review and consider queuing this one to -mm for additional
testing.  Thanks...  

matt
