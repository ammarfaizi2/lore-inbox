Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUBAMmT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 07:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbUBAMmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 07:42:19 -0500
Received: from dp.samba.org ([66.70.73.150]:20187 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265290AbUBAMmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 07:42:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au, dipankar@in.ibm.com,
       vatsa@in.ibm.com, mingo@redhat.com
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core 
In-reply-to: Your message of "Sun, 01 Feb 2004 00:03:14 -0800."
             <20040201000314.233e05a7.akpm@osdl.org> 
Date: Sun, 01 Feb 2004 23:07:25 +1100
Message-Id: <20040201124232.E40D32C223@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040201000314.233e05a7.akpm@osdl.org> you write:
> CPU_MASK_ALL and CPU_MASK_NONE may only be used for initialisers.  It
> doesn't compile if NR_CPUS>4*BITS_PER_LONG.  Fixes to the cpumask
> infrastructure for this remain welcome.

Of course: *THAT* makes sense.

I dislike the "flexibility" of the cpumask code immensley.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
