Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbVLND0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbVLND0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbVLND0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:26:34 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7914
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030419AbVLND0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:26:33 -0500
Date: Tue, 13 Dec 2005 19:26:23 -0800 (PST)
Message-Id: <20051213.192623.39998066.davem@davemloft.net>
To: ak@suse.de
Cc: clameter@engr.sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic_long_t & include/asm-generic/atomic.h V2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051214025710.GD23384@wotan.suse.de>
References: <20051213154916.6667b6d8.akpm@osdl.org>
	<Pine.LNX.4.62.0512131849550.24909@schroedinger.engr.sgi.com>
	<20051214025710.GD23384@wotan.suse.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Wed, 14 Dec 2005 03:57:10 +0100

> > > How about requiring that all 64-bit archs implement atomic64_t and do:
> > 
> > It may be reasonable to have 64 bit arches that are not 
> > capable of 64 bit atomic ops. As far as I can remember sparc was initially
> > a 32 bit platform without 32 bit atomic ops.
> 
> Why? I don't think we have any crippled 64bit platforms like this.
> And if somebody wants to port linux to such a hypothetical crippled
> 64bit platform they can do the necessary work themselves.
> 
> Or just implement 64bit atomic_t with spinlocks.

I definitely agree with Andi here.
