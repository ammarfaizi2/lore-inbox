Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318706AbSICFAJ>; Tue, 3 Sep 2002 01:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318708AbSICFAJ>; Tue, 3 Sep 2002 01:00:09 -0400
Received: from dp.samba.org ([66.70.73.150]:36740 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318706AbSICFAJ>;
	Tue, 3 Sep 2002 01:00:09 -0400
Date: Tue, 3 Sep 2002 12:55:17 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: mk@fashaf.co.za
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18 Kernel Panics related to Netfilter/iptables
Message-Id: <20020903125517.4decaeb9.rusty@rustcorp.com.au>
In-Reply-To: <20020902082156.GA28503@fashaf.co.za>
References: <20020902082156.GA28503@fashaf.co.za>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2002 10:21:56 +0200
mk@fashaf.co.za wrote:

> Hi 
> 
> One of my machines running kernel 2.4.18 is getting kernel panics intermittently (30minutes to 4/5 hours). 
> 
> from the logs I believe is the culprit:
> 
> kernel: LIST_DELETE: ip_conntrack_core.c:165 `&ct->tuplehash[IP_CT_DIR_REPLY]'(c6c78e44) not in &ip_conntrack_hash [hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)].

This problem has been plaguing us for a while.  You're using gcc 2.96, which is interesting.

What connection tracking/NAT modules have you got?  What kind of traffic are
you getting? (eg. are you getting IRC traffic?  FTP traffic?).

I really want to chase this down, but I've yet to find the cause.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
