Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130372AbRANTNa>; Sun, 14 Jan 2001 14:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130801AbRANTNU>; Sun, 14 Jan 2001 14:13:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:58121 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130372AbRANTNM>; Sun, 14 Jan 2001 14:13:12 -0500
Date: Sun, 14 Jan 2001 11:12:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
In-Reply-To: <Pine.LNX.4.30.0101141741390.18663-100000@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.10.10101141111370.4086-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Jan 2001, David Woodhouse wrote:
> 
> But I have no particular attachment to it. All I'm asking for is a way to
> avoid having init order dependencies where previously there was no need
> for them, by having a way to put entries in the inter_module_get() table
> at compile time.

Note that previously there _were_ order dependencies. In fact, I consider
it very tasteless to have modules that act differently on whether another
module is loaded. I saw some arguments saying that this is th "right
thing", and I disagree completely.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
