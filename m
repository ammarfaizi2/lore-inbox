Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWEZJF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWEZJF0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 05:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWEZJF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 05:05:26 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:25011 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751343AbWEZJFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 05:05:25 -0400
Date: Fri, 26 May 2006 18:06:40 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com,
       linux-ia64@vger.kernel.org, ashok.raj@intel.com, steiner@sgi.com,
       tony.luck@intel.com
Subject: Re: [RFC][PATCH] ia64 node hotplug -- cpu - node relationship fix
 [0/2] intro
Message-Id: <20060526180640.76849095.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060526175622.13057d7e.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060526175622.13057d7e.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2006 17:56:22 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> current -mm tree includes node-hotplug codes.
> 
> But by following reason , ia64's node-hotplug doesn't work well now.
> 
> Following patch will fix it. I'd like to post this patch against next -mm.
> Feedbacks are welcome.
> 
> 1. empty-node-fix : avoid creating empty node
>    SRAT's enable bit just shows 'you can read this entry'. But the kernel know
							    ^^^^
                                                             And

-Kame

