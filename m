Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268669AbTBZHNL>; Wed, 26 Feb 2003 02:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268670AbTBZHNL>; Wed, 26 Feb 2003 02:13:11 -0500
Received: from dp.samba.org ([66.70.73.150]:33679 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268669AbTBZHNK>;
	Wed, 26 Feb 2003 02:13:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [BUG] 2.5.63: ESR killed my box! 
In-reply-to: Your message of "Tue, 25 Feb 2003 21:51:06 -0800."
             <9530000.1046238665@[10.10.2.4]> 
Date: Wed, 26 Feb 2003 18:14:42 +1100
Message-Id: <20030226072327.7936B2C04B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <9530000.1046238665@[10.10.2.4]> you write:
> > SMP box, compiled for UP with CONFIG_LOCAL_APIC=y freezes on boot with
> > last lines:
> > 
> > 	POSIX conformance testing by UNIFIX
> > 	masked ExtINT on CPU#0
> > 	ESR value before enabling vector: 00000008
> > 	[ Freeze here ]

> I put an esr_disable flag in there a while back ... does that workaround it?

Yes.  Hmm.  Wonder if that helps my SMP wierness, too.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
