Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVB1Sy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVB1Sy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 13:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVB1Sy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 13:54:27 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39661 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261693AbVB1SyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 13:54:23 -0500
Subject: [PATCH 0/5] prepare x86/ppc64 DISCONTIG code for hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Keith Mannthey <kmannth@us.ibm.com>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 10:54:18 -0800
Message-Id: <1109616858.6921.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject pretty much says it all.  Descriptions are in the individual
patches.  These patches replace the
"allow-hot-add-enabled-i386-numa-box-to-boot.patch" which is currently
in -mm.  Please drop it.  

They apply to 2.6.11-rc5 after a few patches from -mm which conflicted:

	stop-using-base-argument-in-__free_pages_bulk.patch
	consolidate-set_max_mapnr_init-implementations.patch
	refactor-i386-memory-setup.patch
	remove-free_all_bootmem-define.patch
	mostly-i386-mm-cleanup.patch

Boot-tested on plain x86 laptop, NUMAQ, and Summit.  These probably
deserve to stay in -mm for a release or two.

-- Dave

