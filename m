Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263393AbREXHaY>; Thu, 24 May 2001 03:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263395AbREXHaG>; Thu, 24 May 2001 03:30:06 -0400
Received: from [212.150.138.2] ([212.150.138.2]:38155 "EHLO
	ntserver.voltaire.com") by vger.kernel.org with ESMTP
	id <S263393AbREXH36>; Thu, 24 May 2001 03:29:58 -0400
Message-ID: <20083A3BAEF9D211BDB600805F8B14F3F68E17@NTSERVER>
From: Alon Ronen <alonr@voltaire.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: skbuffs under kernel 2.4.4
Date: Thu, 24 May 2001 10:26:58 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="windows-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all!

in sk_buff under kernel 2.4.4 there is a struct called skb_shared_info which
lives at the end of the header
data (at skb->end). one of it's fields is : struct sk_buff *frag_list. what
is the purpose for it's existance?
where in the tcp stack can I see the use for it, or where do I fill it? is
there a relation between this field
and the skb_frag_t frags[MAX_SKB_FRAGS] which also belongs to the same
struct and is simply an array
of objects the describe a fragment using page,offset & size?


thanks in advance,

--Alon

