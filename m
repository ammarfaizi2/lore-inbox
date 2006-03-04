Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWCDWcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWCDWcY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 17:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWCDWcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 17:32:24 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1417
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932249AbWCDWcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 17:32:24 -0500
Date: Sat, 04 Mar 2006 14:32:22 -0800 (PST)
Message-Id: <20060304.143222.01803877.davem@davemloft.net>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, fabbione@ubuntu.com
Subject: Re: VFS nr_files accounting
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060304.142821.105572446.davem@davemloft.net>
References: <20060304141717.GA456@in.ibm.com>
	<20060304.142202.32211471.davem@davemloft.net>
	<20060304.142821.105572446.davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 04 Mar 2006 14:28:21 -0800 (PST)

> Sigh, this is going to take a while, because there are -mm
> dependencies in these patches such as percpu_counter_sum().
> 
> I'll have to fish those out of -mm before I can start testing
> this.

And now that I've sucked in percpu_counter_sum.patch, the
rcu-batch-tuning.patch gets a bunch of rejects.

Sorry, I really can't test this.  Can you by chance put together a
patch against vanilla 2.6.16-GIT?  We'll need that to put a fix
for this bug into Linus's tree anyways.

Thanks.
