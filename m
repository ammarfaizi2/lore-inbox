Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318538AbSH1Buv>; Tue, 27 Aug 2002 21:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318541AbSH1Buv>; Tue, 27 Aug 2002 21:50:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3220 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318538AbSH1Buv>;
	Tue, 27 Aug 2002 21:50:51 -0400
Date: Tue, 27 Aug 2002 18:49:33 -0700 (PDT)
Message-Id: <20020827.184933.62370803.davem@redhat.com>
To: seong@etri.re.kr
Cc: linux-kernel@vger.kernel.org
Subject: Re: sk_buff for frame fragmentation and reassembly
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <011401c24e34$382797e0$21abfe81@seong>
References: <011401c24e34$382797e0$21abfe81@seong>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Seong Moon" <seong@etri.re.kr>
   Date: Wed, 28 Aug 2002 10:42:50 +0900

   I want to know the meaning of alloc_skb() and skb_copy_bit().
   
alloc_skb allocates a new SKB.
skb_copy_bit copies data from a SKB to a kernel buffer.

net/core/skbuff.c has full documentation in the comments
above alloc_skb, perhaps you should read it :-)
