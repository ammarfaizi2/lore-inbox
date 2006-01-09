Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWAIPg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWAIPg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWAIPg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:36:29 -0500
Received: from ns2.suse.de ([195.135.220.15]:1752 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751199AbWAIPg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:36:28 -0500
From: Andi Kleen <ak@suse.de>
To: Matt Tolentino <metolent@cs.vt.edu>
Subject: Re: [patch 2/2] add x86-64 support for memory hot-add
Date: Mon, 9 Jan 2006 16:36:20 +0100
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, discuss@x86-64.org, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org
References: <200601091521.k09FLU1t022321@ap1.cs.vt.edu>
In-Reply-To: <200601091521.k09FLU1t022321@ap1.cs.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091636.21118.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 January 2006 16:21, Matt Tolentino wrote:
> Add x86-64 specific memory hot-add functions, Kconfig options,
> and runtime kernel page table update functions to make
> hot-add usable on x86-64 machines.  Also, fixup the nefarious
> conditional locking and exports pointed out by Andi.

I'm trying to stabilize my tree for the 2.6.16 submission right now
and this one comes a bit too late and is a bit too involved
to slip through - sorry. I will consider it after Linus
has merged the whole batch of changes for 2.6.16 - so hopefully
in 2.6.17.

> +/* 
> + * Memory hotplug specific functions
> + * These are only for non-NUMA machines right now.

How much work would it be to allow it for NUMA kernels too? 

-Andi
