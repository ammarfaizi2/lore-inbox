Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbTFMSIw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265469AbTFMSIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:08:52 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:46240
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265468AbTFMSIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:08:51 -0400
Date: Fri, 13 Jun 2003 20:23:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030613182319.GP1571@dualathlon.random>
References: <20030527115314.GU3767@dualathlon.random> <20030527.150449.08322270.davem@redhat.com> <20030527222712.GB1453@dualathlon.random> <20030612.232249.104032251.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612.232249.104032251.davem@redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 11:22:49PM -0700, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Wed, 28 May 2003 00:27:12 +0200
> 
>    I see your point, please try with 2.4.21rc4aa1 or with this patch:
>    
>    	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc4aa1/00_ksoftirqd-max-loop-networking-1
>    
>    you can put a printk in the ksoftirqd loop and tune the N until it
>    behaves as you want.
> 
> Ingo's specweb testing indicated that a value somewhere between 8 and
> 10 appear optimal.

Sounds very good.

> 
> I've pushed this change into Andrew's -mm 2.5.x patch set.

Thanks!

Andrea
