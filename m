Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbTAFTJO>; Mon, 6 Jan 2003 14:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbTAFTJO>; Mon, 6 Jan 2003 14:09:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9746 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267094AbTAFTJN>; Mon, 6 Jan 2003 14:09:13 -0500
Date: Mon, 6 Jan 2003 11:16:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] configurable LOG_BUF_SIZE
In-Reply-To: <20030106190648.GD796@opus.bloom.county>
Message-ID: <Pine.LNX.4.44.0301061114460.13525-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Jan 2003, Tom Rini wrote:
> 
> > Linus also told me that he's not crazy about this change.
> 
> Maybe he would be, if it was cleaner than the current code in the end.
> :)

No, the reason I'm not crazy about it is that I simply _hate_ having too 
many user knobs to tweak. I don't like tweaking like that, it's just 
disturbing. 

I'd probably be happier if the current one didn't even _ask_ the user (or
only asked the user if kernel debugging is enabled), and just silently
defaulted to the normal values. 

		Linus

