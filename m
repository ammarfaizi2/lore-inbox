Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbTEQC0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 22:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbTEQC0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 22:26:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11186 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261178AbTEQC0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 22:26:40 -0400
Date: Fri, 16 May 2003 19:38:47 -0700 (PDT)
Message-Id: <20030516.193847.15241922.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       davidm@hpl.hp.com, rth@twiddle.net
Subject: Re: [PATCH] Unlimited per-cpu allocation 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030517023420.7FCE42C04F@lists.samba.org>
References: <20030515.224232.63031915.davem@redhat.com>
	<20030517023420.7FCE42C04F@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Sat, 17 May 2003 11:58:55 +1000
   
   IA64 could just use the generic mechanism, like everyone else.  But
   they do the tricky 64k mapping thing.  As I pointed out, maybe their
   decision would have to be rethought if that proves inadaquate.

But we should also give them the option to implement module percpu
data using indirect buffers.
