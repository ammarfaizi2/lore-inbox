Return-Path: <linux-kernel-owner+w=401wt.eu-S1030214AbWLTRg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWLTRg2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 12:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWLTRg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 12:36:27 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:56215 "EHLO
	mx2.cs.washington.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030214AbWLTRg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 12:36:26 -0500
X-Greylist: delayed 1255 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 12:36:26 EST
Date: Wed, 20 Dec 2006 09:15:11 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [Patch](memory hotplug) fix compile error for i386 with NUMA
 config (take 3).
In-Reply-To: <20061220225927.F016.Y-GOTO@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64N.0612200914520.10593@attu4.cs.washington.edu>
References: <20061220225927.F016.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006, Yasunori Goto wrote:

> Hello.
> 
> This is take 3 patch to fix compile error when config
> memory hotplug with numa on i386.
> 
> The cause of compile error was missing of arch_add_memory(), remove_memory(),
> and memory_add_physaddr_to_nid().
> 
> I fixed some bad points, and tested no compile error of it.
> 
> This is for 2.6.20-rc1. 
> 
> Please apply.
> 
> Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Acked-by: David Rientjes <rientjes@cs.washington.edu>
