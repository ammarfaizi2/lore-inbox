Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWAIPSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWAIPSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWAIPSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:18:01 -0500
Received: from ap1.cs.vt.edu ([128.173.40.39]:33704 "EHLO ap1.cs.vt.edu")
	by vger.kernel.org with ESMTP id S932369AbWAIPSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:18:00 -0500
Date: Mon, 9 Jan 2006 10:17:45 -0500
From: Matt Tolentino <metolent@cs.vt.edu>
Message-Id: <200601091517.k09FHjkm022296@ap1.cs.vt.edu>
To: ak@suse.de, akpm@osdl.org
Subject: [patch 0/2] x86-64 memory hot-add support
Cc: discuss@x86-64.org, kmannthus.ibm.com@ap1.cs.vt.edu,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following this mail are two memory hotplug patches.  The first
adds __meminit to the __init lineup to ensure that functions
needed for memory hotplug remain available if CONFIG_MEMORY_HOTPLUG
is enabled but default to __init otherwise.  The second patch is
the reworked x86-64 specific patch for memory hot-add on single
node (non-NUMA) systems updated with Andi's suggestions.  These
changes are specifically isolated to x86-64.  

Patches are against linux-2.6.15.  Patches have been tested for
logical operations as well as physical memory hot-add operations
Please review and consider queuing to -mm for additional testing.
Thanks...  

matt
