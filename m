Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWCDWWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWCDWWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 17:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWCDWWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 17:22:16 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15064
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932243AbWCDWWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 17:22:15 -0500
Date: Sat, 04 Mar 2006 14:22:02 -0800 (PST)
Message-Id: <20060304.142202.32211471.davem@davemloft.net>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, fabbione@ubuntu.com
Subject: Re: VFS nr_files accounting
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060304141717.GA456@in.ibm.com>
References: <20060304.022546.85833873.davem@davemloft.net>
	<20060304141717.GA456@in.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dipankar Sarma <dipankar@in.ibm.com>
Date: Sat, 4 Mar 2006 19:47:17 +0530

> Dave, there is a set of patches in -mm that may handle this
> better -
> 
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/rcu-batch-tuning.patch
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/fix-file-counting.patch
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/fix-file-counting-fixes.patch
> 
> Could you please try this in your setup ?
> 
> The rcu-batch tuning patch provides automatic switching to
> process as many RCUs as possible if too many of them are queued.
> The file counting fixes count the file structures correctly.

Thanks, I'll give these patches a spin.
