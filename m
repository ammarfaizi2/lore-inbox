Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSIEEkB>; Thu, 5 Sep 2002 00:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSIEEkB>; Thu, 5 Sep 2002 00:40:01 -0400
Received: from dp.samba.org ([66.70.73.150]:8668 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316857AbSIEEkB>;
	Thu, 5 Sep 2002 00:40:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Harald Welte <laforge@gnumonks.org>,
       Netfilter Mailing List <netfilter-devel@lists.netfilter.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Patrick Schaaf <bof@bof.de>
Subject: Re: ip_conntrack_hash() problem 
In-reply-to: Your message of "Wed, 04 Sep 2002 15:26:26 +0200."
             <20020904152626.A11438@wotan.suse.de> 
Date: Thu, 05 Sep 2002 10:39:40 +1000
Message-Id: <20020905044436.0772A2C0DF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020904152626.A11438@wotan.suse.de> you write:
> > I think the hash function should be fixed, not the possible choice of
> > hash sizes, if that is at feasible.
> I also agree with Martin that it is better to fix the hash function in
> this case. Restricting to magic hash table sizes looks like a bad hack.

This work is already done:
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Netfilter/conntrack_hashing.patch.gz

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
