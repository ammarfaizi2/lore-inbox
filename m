Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274708AbRITXnK>; Thu, 20 Sep 2001 19:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274710AbRITXnA>; Thu, 20 Sep 2001 19:43:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22922 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274708AbRITXmu>;
	Thu, 20 Sep 2001 19:42:50 -0400
Date: Thu, 20 Sep 2001 16:43:01 -0700 (PDT)
Message-Id: <20010920.164301.76328081.davem@redhat.com>
To: torvalds@transmeta.com
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [patch] block highmem zero bounce v14
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0109161447390.29507-100000@penguin.transmeta.com>
In-Reply-To: <20010916234307.A12270@suse.de>
	<Pine.LNX.4.33.0109161447390.29507-100000@penguin.transmeta.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sun, 16 Sep 2001 14:48:32 -0700 (PDT)
   
   Jens, what's your feeling about the stability of these things, especially
   wrt weird drivers?
   
   Ie do you think this is really a 2.4.x thing, or early 2.5.x?

On my side of this work I feel that the 64-bit PCI dma infrastructure
by itself is a safe merge in 2.4.11 or something like that.

Later,
David S. Miller
davem@redhat.com
