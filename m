Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274627AbRJEXok>; Fri, 5 Oct 2001 19:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274633AbRJEXob>; Fri, 5 Oct 2001 19:44:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41096 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274627AbRJEXoZ>;
	Fri, 5 Oct 2001 19:44:25 -0400
Date: Fri, 05 Oct 2001 16:44:41 -0700 (PDT)
Message-Id: <20011005.164441.08321186.davem@redhat.com>
To: balbir.singh@wipro.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH]Small Minor optimization to kmem_cache_estimate
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BBD9ABD.6040909@wipro.com>
In-Reply-To: <3BBD9ABD.6040909@wipro.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "BALBIR SINGH" <balbir.singh@wipro.com>
   Date: Fri, 05 Oct 2001 17:04:21 +0530

   I verified the number of objects per slab is the same in both cases.
   This patch may not improve the performance of your CPU by a great amount,
   but when there is a faster way to do things, why live with the slower one.

Since this code only occurs during SLAB creation, you estimation on
CPU savings is correct.

Why live with it?  Less changes to verify would be one reason :-)

Franks a lot,
David S. Miller
davem@redhat.com
