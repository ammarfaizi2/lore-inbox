Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265389AbUAZWtB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 17:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbUAZWtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 17:49:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:29891 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265389AbUAZWtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 17:49:00 -0500
Date: Mon, 26 Jan 2004 14:48:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: James Simmons <jsimmons@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: monochrome display fix.
In-Reply-To: <Pine.LNX.4.44.0401262212140.5445-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.58.0401261446560.2313@home.osdl.org>
References: <Pine.LNX.4.44.0401262212140.5445-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Jan 2004, James Simmons wrote:
> 
> [CONSOLE] Don't let a monochrome display stomp all over the console color 
> values.

Why is this ugly patch required? If something can't do color, why does it 
care about "color" in the first place? We've never needed this patch 
before, it looks like something broke somewhere _else_ that causes this
to be relevant.

		Linus
