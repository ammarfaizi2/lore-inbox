Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266191AbUHAV5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266191AbUHAV5l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 17:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUHAV5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 17:57:41 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:39569 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id S266185AbUHAV5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 17:57:39 -0400
Date: Sun, 1 Aug 2004 23:56:25 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [PATCH] fix inline related gcc 3.4 build failures in drivers/net/wan/dscc4.c
Message-ID: <20040801215625.GA29505@se1.cogenit.fr>
Mail-Followup-To: Francois Romieu <romieu@cogenit.fr>,
	Jesper Juhl <juhl-lkml@dif.dk>, LKML <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Adrian Bunk <bunk@fs.tum.de>
References: <Pine.LNX.4.60.0408012113530.2535@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0408012113530.2535@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> :
[inline fixes]
> drivers/net/wan/dscc4.c: In function `dscc4_found1':
> drivers/net/wan/dscc4.c:369: sorry, unimplemented: inlining failed in call to 'dscc4_set_quartz': function body not available
> drivers/net/wan/dscc4.c:898: sorry, unimplemented: called from here
> 
> This one I fixed by moving the function before the point of its first use 
> since it's quite small.

Fine. You forgot to include the patch which removes the forward declaration
though.

-- 
Ueimor
