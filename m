Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbTLBTJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbTLBTJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:09:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:57017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264315AbTLBTJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:09:34 -0500
Date: Tue, 2 Dec 2003 11:09:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
In-Reply-To: <20031202184513.GU16507@lug-owl.de>
Message-ID: <Pine.LNX.4.58.0312021101440.1519@home.osdl.org>
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet>
 <Pine.LNX.4.44.0312012302310.9674-100000@raven.themaw.net>
 <20031201153316.B3879@infradead.org> <200312020223.55505.snpe@snpe.co.yu>
 <20031202063912.GD16507@lug-owl.de> <Pine.LNX.4.58.0312020956120.1519@home.osdl.org>
 <20031202184513.GU16507@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Dec 2003, Jan-Benedict Glaw wrote:
>
> Whenever The ABI Question (TM) comes up, it seems to be about claiming a
> (binary compatible) interface - mostly for modules. But I think it's
> widely accepted that there isn't much work done to have these truly (sp?)
> binary compatible (eg. UP/SMP spinlocks et al.).

Absolutely. It's not going to happen. I am _totally_ uninterested in a
stable ABI for kernel modules, and in fact I'm actively against even
_trying_. I want people to be very much aware of the fact that kernel
internals do change, and that this will continue.

There are no good excuses for binary modules. Some of them may be
technically legal (by virtue of not being derived works) and allowed, but
even when they are legal they are a major pain in the ass, and always
horribly buggy.

I occasionally get a few complaints from vendors over my non-interest in
even _trying_ to help binary modules. Tough. It's a two-way street: if you
don't help me, I don't help you. Binary-only modules do not help Linux,
quite the reverse. As such, we should have no incentives to help make them
any more common than they already are. Adn we do have a lot of
dis-incentives.

			Linus
