Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261383AbSIZPWu>; Thu, 26 Sep 2002 11:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbSIZPWu>; Thu, 26 Sep 2002 11:22:50 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:53259 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S261383AbSIZPWt>; Thu, 26 Sep 2002 11:22:49 -0400
Date: Fri, 27 Sep 2002 01:27:41 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <nf@hipac.org>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification for
 Netfilter
In-Reply-To: <20020925.224001.99456805.davem@redhat.com>
Message-ID: <Mutt.LNX.4.44.0209270122570.12511-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, David S. Miller wrote:

> If you have things that must happen in a sequence to flow through
> your path properly, that's where the "stackable" bit comes in.  You
> do that one bit, skb->dst = dst_pop(skb->dst), then your caller
> will pass the packet on to skb->dst->{output,input}().
> 
> Is it clearer now the kind of things you'll be able to do?
> 

So, this could be used for generic network layer encapsulation, and be 
used for GRE tunnels, SIT etc. without the kinds of kludges currently in 
use?  Sounds nice.


- James
-- 
James Morris
<jmorris@intercode.com.au>


