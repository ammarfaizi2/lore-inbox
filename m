Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTEPFbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 01:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264293AbTEPFbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 01:31:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15531 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264283AbTEPFaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 01:30:17 -0400
Date: Thu, 15 May 2003 22:42:32 -0700 (PDT)
Message-Id: <20030515.224232.63031915.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       davidm@hpl.hp.com, rth@twiddle.net
Subject: Re: [PATCH] Unlimited per-cpu allocation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030516053654.F09242C07C@lists.samba.org>
References: <20030516053654.F09242C07C@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Fri, 16 May 2003 15:30:36 +1000

   D: This patch allows an unlimited number of per-cpu allocations.

Except, of course, on IA64.  Maybe I missed the end of some thread,
but I thought we had all agreed that this kind of limitation was
a showstopper.
