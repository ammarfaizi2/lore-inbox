Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUJBQDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUJBQDB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 12:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266901AbUJBQDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 12:03:01 -0400
Received: from jade.aracnet.com ([216.99.193.136]:53991 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266896AbUJBQC7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 12:02:59 -0400
Date: Sat, 02 Oct 2004 09:02:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: colpatch@us.ibm.com
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: [RFC PATCH] sched_domains: Make SD_NODE_INIT per-arch
Message-ID: <159570000.1096732964@[10.10.2.4]>
In-Reply-To: <1096669257.20964.66.camel@arrakis>
References: <1096420339.15060.139.camel@arrakis> <415BC0BC.6040902@yahoo.com.au><1096569412.20097.13.camel@arrakis> <20040930122312.3f09ed73.akpm@osdl.org>  <78560000.1096611330@[10.10.2.4]> <1096669257.20964.66.camel@arrakis>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Martin, Andi, Andrew & anyone else still reading this thread,
> Here's yet another version of a patch to implement per-arch SD_*_INITs. 
> This follows the same basic idea of my last patch, but 
> 1) defines an arch-specific SD_NODE_INIT for the 4 NUMA arches (i386,
> x86_64, IA64 & PPC64), 
> 2) defines *default* SD_CPU_INIT & SD_SIBLING_INIT for *all* arches,
> with the possibility of them being overridden by simply defining an
> arch-specific version in include/asm/topology.h.

Looks good. tested. works ;-)

M.

