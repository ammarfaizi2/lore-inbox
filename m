Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUJBDu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUJBDu3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 23:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUJBDu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 23:50:29 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:33970 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267235AbUJBDu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 23:50:28 -0400
Date: Sat, 02 Oct 2004 12:50:55 +0900 (JST)
Message-Id: <20041002.125055.74752207.taka@valinux.co.jp>
To: piggin@cyberone.com.au
Cc: marcelo.tosatti@cyclades.com, linux-mm@kvack.org, akpm@osdl.org,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <415E154A.2040209@cyberone.com.au>
References: <20041001182221.GA3191@logos.cnet>
	<415E154A.2040209@cyberone.com.au>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> >For example it doesnt re establishes pte's once it has unmapped them.
> >
> >
> 
> Another thing - I don't know if I'd bother re-establishing ptes....
> I'd say just leave it to happen lazily at fault time.

I think the reason is that his current implementation doesn't assign
a swap entry to an anonymous page to move.


Thank you,
Hirokazu Takahashi.
