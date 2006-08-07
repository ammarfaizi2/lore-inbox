Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWHGC5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWHGC5m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 22:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWHGC5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 22:57:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32421 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750943AbWHGC5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 22:57:41 -0400
Subject: Re: PATCH 2 of 4] cpumask: export cpu_online_map and
	cpu_possible_map consistently
From: Greg Banks <gnb@melbourne.sgi.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@suse.de>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44D35D99.601@linux.intel.com>
References: <1154669759.21040.2353.camel@hole.melbourne.sgi.com>
	 <44D35D99.601@linux.intel.com>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1154919431.29877.69.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 07 Aug 2006 12:57:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-05 at 00:45, Arjan van de Ven wrote:
> Greg Banks wrote:
> > cpumask: ensure that the cpu_online_map and cpu_possible_map bitmasks,
> > and hence all the macros in <linux/cpumask.h> that require them, are
> > available to modules for all supported combinations of architecture
> > and CONFIG_SMP.
> 
> Are there any actual users of this?

knfsd-make-rpc-threads-pools-numa-aware.patch in -mm.

http://marc.theaimsgroup.com/?l=linux-kernel&m=115430697330586&w=2

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


