Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbTEQC6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 22:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTEQC6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 22:58:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23730 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261175AbTEQC6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 22:58:39 -0400
Date: Fri, 16 May 2003 20:10:48 -0700 (PDT)
Message-Id: <20030516.201048.116377975.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       davidm@hpl.hp.com, rth@twiddle.net
Subject: Re: [PATCH] Unlimited per-cpu allocation 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030517030820.E17F72C018@lists.samba.org>
References: <20030516.193847.15241922.davem@redhat.com>
	<20030517030820.E17F72C018@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Sat, 17 May 2003 13:07:21 +1000
   
   The question is not whether we need this allocator to implement
   percpu inside modules (we do), but whether it can also be used for
   kmalloc_percpu.

I hadn't caught this distinction, and thus I misunderstood what was
going on here.  Thanks for clarifying.
