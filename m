Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbVLFDLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbVLFDLw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 22:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbVLFDLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 22:11:52 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:3808
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751500AbVLFDLw (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 5 Dec 2005 22:11:52 -0500
Date: Mon, 05 Dec 2005 19:11:53 -0800 (PST)
Message-Id: <20051205.191153.19905732.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: Linux-Kernel@vger.kernel.org, linux-mm@kvack.org, paul.mckenney@us.ibm.com,
       wfg@mail.ustc.edu.cn
Subject: Re: [RFC] lockless radix tree readside
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4394EC28.8050304@yahoo.com.au>
References: <4394EC28.8050304@yahoo.com.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Tue, 06 Dec 2005 12:40:56 +1100

> I realise that radix-tree.c isn't a trivial bit of code so I don't
> expect reviews to be forthcoming, but if anyone had some spare time
> to glance over it that would be great.

I went over this a few times and didn't find any obvious
problems with the RCU aspect of this.

> Is my given detail of the implementation clear? Sufficient? Would
> diagrams be helpful?

If I were to suggest an ascii diagram for a comment, it would be
one which would show the height invariant this patch takes advantage
of.

Nice work.
