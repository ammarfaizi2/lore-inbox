Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWJHS1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWJHS1a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWJHS13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:27:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65037 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750815AbWJHS13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:27:29 -0400
Date: Sun, 8 Oct 2006 18:26:45 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       p.hardwick@option.com
Subject: Re: [PATCH 2/2] Char: nozomi, bad comment sings
Message-ID: <20061008182645.GB4033@ucw.cz>
References: <54435213243213@wsc.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54435213243213@wsc.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> nozomi, bad comment sings
> 
> Don't use // for comments in C.

> @@ -413,11 +413,11 @@ struct port {
>  	ctrl_ul_t ctrl_ul;
>  	ctrl_dl_t ctrl_dl;
>  	struct kfifo *fifo_ul;
> -//	u32 dl_addr[2];
> +/*	u32 dl_addr[2]; */

Simply delete unused code. We already have it under version control...

-- 
Thanks for all the (sleeping) penguins.
