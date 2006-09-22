Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWIVCnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWIVCnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWIVCnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:43:15 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:59602 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932221AbWIVCnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:43:14 -0400
Date: Fri, 22 Sep 2006 11:46:23 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       tony.luck@intel.com, akpm@osdl.org
Subject: Re: [BUGFIX] [PATCH] [IA64] node hotplug : fixup cpu-to-node
 relationship
Message-Id: <20060922114623.321972b5.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060922100721.4714a8ed.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060922100721.4714a8ed.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 10:07:21 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

>
> ==
> When a cpu is not tied to its node at(before) cpu-onlining, the system panics.
> node_to_cpu_mask[] should be set to valid value before notifier of CPU_ONLINE
> is called.(if not, the system panics.)
> 

Sorry, please ignore this patch. I noticed cpu <-> node relation should be fixed
before CPU_UP_PREPARE. I'll post another one sonn.

-Kame

