Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbRE2Iqa>; Tue, 29 May 2001 04:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261425AbRE2IqT>; Tue, 29 May 2001 04:46:19 -0400
Received: from zeus.kernel.org ([209.10.41.242]:39390 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261410AbRE2IqE>;
	Tue, 29 May 2001 04:46:04 -0400
Date: Tue, 29 May 2001 10:40:59 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: <werner@titro.de>, <isdn4linux@listserv.isdn4linux.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make kmalloc error return unconditional in hysdn_net.c
 (245ac1)
In-Reply-To: <20010528225305.M846@jaquet.dk>
Message-ID: <Pine.LNX.4.33.0105291037290.31783-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2001, Rasmus Andersen wrote:

> The patch below fixes what I believe is a bug in hysdn_net.c.
> I cannot see how we can proceed under _any_ circumstances
> after the kmalloc fails. Applies against 245ac1.

Yep, you're obviously right. Thanks, I'll check in your patch into our
CVS, and push it to Alan. Actually, maybe it makes sense to use
alloc_netdev here, I'll have a look.

Thanks a lot,
--Kai

