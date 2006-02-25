Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWBYHhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWBYHhP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 02:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWBYHhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 02:37:15 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:28847 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932462AbWBYHhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 02:37:13 -0500
Date: Sat, 25 Feb 2006 16:38:18 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_online_pgdat (take2)  [1/5]  define
 for_each_online_pgdat
Message-Id: <20060225163818.a89c5a22.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060224233030.3fd18e25.akpm@osdl.org>
References: <20060225150528.98386921.kamezawa.hiroyu@jp.fujitsu.com>
	<20060224221651.58950b8c.akpm@osdl.org>
	<20060225152218.a9e74acf.kamezawa.hiroyu@jp.fujitsu.com>
	<20060225160736.56f9393e.kamezawa.hiroyu@jp.fujitsu.com>
	<20060224233030.3fd18e25.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006 23:30:30 -0800
Andrew Morton <akpm@osdl.org> wrote:

> > I'll rewrite this if necessary.
> > (make this patch depends on some config or move the place of funcs...)
> 
> We wouldn't want a config option for it.
> 
> And the new mmzone.c probably makes sense too - I expect there are a few
> related things (page_alloc.c) which could be moved there.

Yes, I'd like to move some of initialization funcs and counting pages funcs to mmzone.c.
Maybe I'll do so for patches related to node-hotplug.

--Kame


