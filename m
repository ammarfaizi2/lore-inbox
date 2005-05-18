Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVERPlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVERPlU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVERPbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:31:42 -0400
Received: from fmr19.intel.com ([134.134.136.18]:35498 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262271AbVERPPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:15:36 -0400
Date: Wed, 18 May 2005 08:20:23 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200505181520.j4IFKNYi026893@snoqualmie.dp.intel.com>
To: ak@muc.de, akpm@osdl.org
Subject: [patch 0/4] x86-64 sparsemem support
Cc: apw@shadowen.org, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here are a set of patches against 2.6.12-rc4-mm2 that 
enable the use of the sparsemem implementation for x86-64
NUMA kernels.  I've boot tested these for the normal contiguous
configuration as well as NUMA configurations using both
discontigmem and sparsemem options.  The NUMA configurations
have been tested using the "numa=fake" option as I don't have
direct access to a true x86-64 NUMA machine.  

For reference, these have been in the memory hotplug tree
Dave has been maintaining and also form the basis for supporting
memory hotplug.  Please review and consider for inclusion in -mm
for wider testing.  Patches to follow...

matt

