Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131581AbQLVFk0>; Fri, 22 Dec 2000 00:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131707AbQLVFkQ>; Fri, 22 Dec 2000 00:40:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:4228 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131581AbQLVFkF>;
	Fri, 22 Dec 2000 00:40:05 -0500
Date: Thu, 21 Dec 2000 20:53:13 -0800
Message-Id: <200012220453.UAA12313@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: michael@linuxmagic.com
CC: kernel@pineview.net, linux-kernel@vger.kernel.org
In-Reply-To: <0012212020061G.24471@mistress> (message from Michael Peddemors
	on Thu, 21 Dec 2000 20:20:06 -0800)
Subject: Re: No more DoS
In-Reply-To: <977453684.3a42c2744fbb7@ppro.pineview.net> <200012220200.SAA05057@pizda.ninka.net> <0012212020061G.24471@mistress>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Michael Peddemors <michael@linuxmagic.com>
   Date: Thu, 21 Dec 2000 20:20:06 -0800

   > I think not holding onto any state for an incoming SYN is nothing but
   > a dream in any serious modern TCP implementation.  It can be reduced,
   > but not eliminated.  The former is what most modern stacks have done
   > to fight these problems.

   A dream, maybe .... but hey so were most things that we now take for granted..
   Worth kicking around a bit tho...  

At a minimum you have to remember the MSS value given by the remote
host in the initial SYN, it is impossible to avoid this and provide
a TCP implementation of any level of quality.

The foundations of this person's scheme simply cannot work.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
