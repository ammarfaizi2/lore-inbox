Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132991AbRDYWxE>; Wed, 25 Apr 2001 18:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132984AbRDYWwy>; Wed, 25 Apr 2001 18:52:54 -0400
Received: from juicer24.bigpond.com ([139.134.6.34]:14582 "EHLO
	mailin3.email.bigpond.com") by vger.kernel.org with ESMTP
	id <S132982AbRDYWwo>; Wed, 25 Apr 2001 18:52:44 -0400
Message-Id: <m14sOcl-001Q8NC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: andrew.cramer@cramer-ts.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: routing & ipchains 
In-Reply-To: Your message of "Wed, 25 Apr 2001 00:55:40 EST."
             <3AE6208C.8379.146C84FE@localhost> 
Date: Wed, 25 Apr 2001 22:42:27 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3AE6208C.8379.146C84FE@localhost> you write:
> Greetings All,
> 	After upgrading from kernel 2.0.38 w/ slackware-3.4 to
> kernel 2.2.16 w/ slackware-7.1 I have developed the following
> routing problems.
> 
> Hardware -
> 	eth0 - 10meg on net 192.168.0.0 i/f 192.168.0.1 subnet 
> 255.255.255.128
> 	eth1 - 100meg on net 192.168.0.128 i/f 192.168.0.130 subnet 
> 255.255.255.128
> 
> >From either network I can use ipchains and surf/telnet/ftp/... on 
> each network to the ppp0 dialup connection. I cannot ping or 
> anything from eth0 to eth1 or back.

Um, I don't see what this has to do with ipchains, but my guess is:

	echo 1 > /proc/sys/net/ipv4/ip_forward

Rusty.
--
Premature optmztion is rt of all evl. --DK
