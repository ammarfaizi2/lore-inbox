Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVEJXQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVEJXQY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 19:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVEJXQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 19:16:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:58078 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261816AbVEJXQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 19:16:22 -0400
Date: Tue, 10 May 2005 16:16:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace
 cleanup)
Message-Id: <20050510161657.3afb21ff.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505110057500.2386@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0505110057500.2386@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> -	if (b == NULL || already_uses(a, b)) return 1;
> +	if (b == NULL || already_uses(a, b))
> +		return 1;

There are about 88 squillion of these in the kernel.  I think it would be a
mistake for me to start taking such patches, sorry.
