Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965350AbWI0FeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965350AbWI0FeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965348AbWI0FeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:34:10 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:46820 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965347AbWI0FeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:34:09 -0400
Date: Wed, 27 Sep 2006 14:36:00 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mm-commits@vger.kernel.org, stable@kernel.org
Subject: Re: + fix-cpu-to-node-relationship-fixup-map-cpu-to-node.patch
 added to -mm tree
Message-Id: <20060927143600.67418b15.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <200609270332.k8R3WWkm012520@shell0.pdx.osdl.net>
References: <200609270332.k8R3WWkm012520@shell0.pdx.osdl.net>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 20:32:32 -0700
akpm@osdl.org wrote:

> 
> The patch titled
> 
>      fix "cpu to node relationship fixup: map cpu to node"
> 
> has been added to the -mm tree.  Its filename is
> 
>      fix-cpu-to-node-relationship-fixup-map-cpu-to-node.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 

Tested on
- CONFIG_NUMA=n, on tiger4/ia64 smp 
- CONFIG_NUMA=y, on Fujitsu's PrimeQuest(ia64/NUMA)
  node hotplug also works fine.

Thanks,
-Kame

