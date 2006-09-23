Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbWIWBG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWIWBG1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 21:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWIWBG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 21:06:26 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:39553 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965025AbWIWBGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 21:06:25 -0400
Date: Sat, 23 Sep 2006 10:06:03 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com
Subject: Re: [BUGFIX][PATCH] cpu to node relationship fixup take2 [1/2]
 acpi_map_cpu2node
Message-Id: <20060923100603.52db1f5d.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060922170604.745d662a.akpm@osdl.org>
References: <20060922152447.42a83860.kamezawa.hiroyu@jp.fujitsu.com>
	<20060922170604.745d662a.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 17:06:04 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Fri, 22 Sep 2006 15:24:47 +0900
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
> > I rewrote the whoe patch..
> > 
> 
> Well I don't recall ever having seen a "cpu to node relationship fixup
> take1" and I have generally lost the plot regarding these fixes.
> 
Sorry....I noticed cpu-to-node relation ship should be fixed before onlining.
About subject, I should be more carefull.

> What I have now is:
> 
> cpu-to-node-relationship-fixup-take2.patch
> cpu-to-node-relationship-fixup-map-cpu-to-node.patch
> 
> I shall send those patches in reply to this email.  Please confirm that
> these are correct, sufficient, complete, etc.
> 
will do.

> Do you believe these are needed in 2.6.18.x?
> 
yes, I do, becasue my system panics now at cpu onlining.

Thank you.

-Kame

