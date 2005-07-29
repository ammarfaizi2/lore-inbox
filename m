Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVG2HtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVG2HtF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbVG2HtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:49:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:16791 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262482AbVG2Hqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:46:53 -0400
Date: Fri, 29 Jul 2005 09:46:47 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, akpm@zip.com.au, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] x86_64: fix cpu_to_node setup for sparse apic_ids
Message-ID: <20050729074647.GC3726@bragg.suse.de>
References: <20050728011540.GA23923@localhost.localdomain> <20050727182445.52be6000.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727182445.52be6000.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 06:24:45PM -0700, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > While booting with SMT disabled in bios, when using acpi srat to setup
> > cpu_to_node[],  sparse apic_ids create problems.  Here's a fix for that.
> > 
> 
> Again, I don't have enough info here to judge the urgency of this patch.

The patch is broken, don't apply please.

Ravi, there is no reason the order of CPUs in SRAT has anything to do
with the order CPUs are brought up.

-Andi
