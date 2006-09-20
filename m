Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWITC3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWITC3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 22:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWITC3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 22:29:42 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:47747 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750769AbWITC3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 22:29:41 -0400
Date: Wed, 20 Sep 2006 11:32:38 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: rohitseth@google.com
Cc: akpm@osdl.org, devel@openvz.org, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch04/05]- Containers: Core Container support
Message-Id: <20060920113238.29745a4b.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1158284550.5408.156.camel@galaxy.corp.google.com>
References: <1158284550.5408.156.camel@galaxy.corp.google.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006 18:42:30 -0700
Rohit Seth <rohitseth@google.com> wrote:

> This patch has the definitions and other core part of container support
> implementing all the counters for different resources (like tasks, anon
> memory etc.).
> 

> +int container_add_task(struct task_struct *task, struct task_struct *parent,
> +		struct container_struct *ctn)
> +{

What should happen if a process of thread-group is newly added/removed ?
(I think only thread-group-leader can be added/removed)

-Kame


