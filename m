Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268652AbTBZFlC>; Wed, 26 Feb 2003 00:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268655AbTBZFlC>; Wed, 26 Feb 2003 00:41:02 -0500
Received: from franka.aracnet.com ([216.99.193.44]:12724 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268652AbTBZFlB>; Wed, 26 Feb 2003 00:41:01 -0500
Date: Tue, 25 Feb 2003 21:51:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
cc: mingo@redhat.com
Subject: Re: [BUG] 2.5.63: ESR killed my box!
Message-ID: <9530000.1046238665@[10.10.2.4]>
In-Reply-To: <20030226043457.8490E2C05D@lists.samba.org>
References: <20030226043457.8490E2C05D@lists.samba.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SMP box, compiled for UP with CONFIG_LOCAL_APIC=y freezes on boot with
> last lines:
> 
> 	POSIX conformance testing by UNIFIX
> 	masked ExtINT on CPU#0
> 	ESR value before enabling vector: 00000008
> 	[ Freeze here ]
> 
> With SMP, it boots fine (then freezes mysteriously a few mins after
> boot, which is what I am still chasing):
> 
> 	masked ExtINT on CPU#0
> 	ESR value before enabling vector: 00000000
> 	ESR value after enabling vector: 00000000
> 	...
> 
> Don't know exactly what kernel this first happened, I usually run SMP.

I put an esr_disable flag in there a while back ... does that workaround it?

M.

