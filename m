Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbVEAS4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVEAS4S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 14:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVEAS4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 14:56:17 -0400
Received: from jagor.srce.hr ([161.53.2.130]:64734 "EHLO jagor.srce.hr")
	by vger.kernel.org with ESMTP id S262642AbVEAS4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 14:56:14 -0400
Message-ID: <42752648.5010901@spymac.com>
Date: Sun, 01 May 2005 20:56:08 +0200
From: zhilla <zhilla@spymac.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Jewell <pete@phraxos.nildram.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix for bttv driver (v0.9.15) for Leadtek WinFast VC100
 XP capture cards
References: <200504252007.15329.pete@phraxos.nildram.co.uk>
In-Reply-To: <200504252007.15329.pete@phraxos.nildram.co.uk>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.479 (*) DOMAIN_BODY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Jewell wrote:
> This is a tiny patch that fixes bttv-cards.c so that Leadtek WinFast VC100 
> XP video capture cards work.  I've been advised to post it here after 
> having already posted it to the v4l mailing list.
> 
> --- bttv-cards.c	2005-04-24 23:39:41.000000000 +0100
> +++ /usr/src/kernel-source-2.6.11/drivers/media/video/bttv-cards.c	2005-04-25 19:59:27.000000000 +0100
> @@ -1939,7 +1939,6 @@
>          .no_tda9875     = 1,
>          .no_tda7432     = 1,
>          .tuner_type     = TUNER_ABSENT,
> -        .no_video       = 1,
>  	.pll            = PLL_28,
>  },{
>  	.name           = "Teppro TEV-560/InterVision IV-560",

works great for me, too. from "non working, not possible to make it 
work" to "works great" - 1 line of code.
to developers... make sure it gets to next 2.6.11.x/12 kernel version :)
