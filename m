Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270655AbRHJV7p>; Fri, 10 Aug 2001 17:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270656AbRHJV7f>; Fri, 10 Aug 2001 17:59:35 -0400
Received: from [216.101.162.242] ([216.101.162.242]:10880 "EHLO
	pizda.ninka.net") by vger.kernel.org with ESMTP id <S270655AbRHJV73>;
	Fri, 10 Aug 2001 17:59:29 -0400
Date: Fri, 10 Aug 2001 14:58:36 -0700 (PDT)
Message-Id: <20010810.145836.41632779.davem@redhat.com>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Newsgroups: lists.linux.kernel
Subject: Re: struct page to 36 (or 64) bit bus address?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <slrn9n71kn.28q.kraxel@bytesex.org>
In-Reply-To: <15218.61869.424038.30544@pizda.ninka.net>
	<20010809163531.D1575@sventech.com>
	<slrn9n71kn.28q.kraxel@bytesex.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I'm using the patch below (pulled out of Jens Axboe's bio
   patches, i386 only).

Are you sure you aren't missing anything in this patch?  For example,
one can't use the patch you've provided for 64-bit DMA unless the
dma_addr_t type is made larger.

Later,
David S. Miller
davem@redhat.com
