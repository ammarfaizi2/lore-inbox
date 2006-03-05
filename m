Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752083AbWCEHGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbWCEHGz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 02:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752122AbWCEHGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 02:06:55 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:63692 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752083AbWCEHGy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 02:06:54 -0500
Date: Sun, 5 Mar 2006 12:35:38 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, fabbione@ubuntu.com
Subject: Re: VFS nr_files accounting
Message-ID: <20060305070537.GB21751@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060304141717.GA456@in.ibm.com> <20060304.142202.32211471.davem@davemloft.net> <20060304.142821.105572446.davem@davemloft.net> <20060304.143222.01803877.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304.143222.01803877.davem@davemloft.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 02:32:22PM -0800, David S. Miller wrote:
> From: "David S. Miller" <davem@davemloft.net>
> Date: Sat, 04 Mar 2006 14:28:21 -0800 (PST)
> 
> And now that I've sucked in percpu_counter_sum.patch, the
> rcu-batch-tuning.patch gets a bunch of rejects.
> 
> Sorry, I really can't test this.  Can you by chance put together a
> patch against vanilla 2.6.16-GIT?  We'll need that to put a fix
> for this bug into Linus's tree anyways.

Dave,

Can you check if the following patchset applies to the latest git ?
These were against 2.6.16-rc3.

http://www.hill9.org/linux/kernel/patches/2.6.16-rc3/rcu-batch-tuning.patch
http://www.hill9.org/linux/kernel/patches/2.6.16-rc3/percpu-counter-sum.patch
http://www.hill9.org/linux/kernel/patches/2.6.16-rc3/fix-file-counting.patch

Thanks
Dipankar
