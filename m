Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbSKQSW0>; Sun, 17 Nov 2002 13:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267545AbSKQSW0>; Sun, 17 Nov 2002 13:22:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8197 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267544AbSKQSWZ>; Sun, 17 Nov 2002 13:22:25 -0500
Date: Sun, 17 Nov 2002 10:29:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PARAM 2/4 
In-Reply-To: <20021117182227.82F332C059@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211171028000.4425-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Nov 2002, Rusty Russell wrote:
> 
> Sure.  MODULE_AUTHOR(), MODULE_DESCRIPTION(), MODULE_PARM_DESC() and
> MODULE_LICENSE() fight the other way.

And they should stay MODULE-only. 

I do _not_ want to see these be compiled in and taking up space in a 
static kernel. 

I personally see the rule as: shouting MODULE_XXX() stuff is a no-op 
when the module is statically compiled into the kernel.

		Linus

