Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTFORTK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTFORTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:19:09 -0400
Received: from colin2.muc.de ([193.149.48.15]:64015 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262382AbTFORTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:19:07 -0400
Date: 15 Jun 2003 19:32:56 +0200
Message-ID: <20030615193256.29257@colin.muc.de>
Date: Sun, 15 Jun 2003 19:32:56 +0200
From: Andi Kleen <ak@colin.muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix undefined/miscompiled construct in kernel parameters
References: <m3of0zdzuz.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0306151021440.8088-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <Pine.LNX.4.44.0306151021440.8088-100000@home.transmeta.com>; from Linus Torvalds on Sun, Jun 15, 2003 at 10:24:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> They are not arbitrary symbols. They are symbols in the same data 
> structure, set up by the linker script. Gcc doesn't know that, but the 
> fact that gcc doesn't know doesn't mean that gcc should be lazy and 
> doesn't really excuse buggy code.
> 
> The gcc developers you talked to are picking their legalistic noses, and 
> it's sad that this isn't exactly the first time it has happened.

I tend to agree, feel free to flame them. But it doesn't help me right now 
when I want to get a booting kernel. Could you merge that change or if you 
prefer I can rewrite it to anonymous asm (but it will be probably more ugly). 
I just need some workaround.

Thanks.

-Andi

