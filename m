Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVBFTsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVBFTsG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVBFTro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:47:44 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:33698 "EHLO suse.de")
	by vger.kernel.org with ESMTP id S261288AbVBFTrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 14:47:36 -0500
Date: Sun, 6 Feb 2005 20:47:53 +0100
From: Vojtech Pavlik <vojtech@suse.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Johan Myreen <jem@iki.fi>,
       Andrew Morton <akm@osdl.org>
Subject: Re: [PATCH] remove pointless <0 comparisons for unsigned vars, and avoid a few signed vs unsigned comparisons in drivers/char/keyboard.c
Message-ID: <20050206194753.GF23126@ucw.cz>
References: <Pine.LNX.4.61.0411220008030.3423@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411220008030.3423@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 12:21:55AM +0100, Jesper Juhl wrote:
> 
> Hi,
> 
> Sorry about the possibly irrelevant CC list, but I couldn't find a 
> maintainer for drivers/char/keyboard.c listed anywhere, so I ended up 
> sending to lkml and CC'ing a few people who has worked on the file, and 
> akpm as a fallback person due to his 2.6 maintainer role.
> 
> Here's a patch that removes a few pointless comparisons; "scancode" is 
> unsigned so it can never be <0 which makes the test pointless.
> Also, there are a few instances where signed and unsigned variables are 
> comared, and as far as I can tell they really should just all be unsigned.
> 
> Comments welcome (I must confess that I've only compile tested this so 
> far).
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
 
Looks sane: Applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
