Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBGSSb>; Wed, 7 Feb 2001 13:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129053AbRBGSSW>; Wed, 7 Feb 2001 13:18:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:38404 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129032AbRBGSSI>; Wed, 7 Feb 2001 13:18:08 -0500
Date: Wed, 7 Feb 2001 10:17:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] micro-opt DEBUG_ADD_PAGE
In-Reply-To: <Pine.LNX.4.21.0102071755200.5243-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10102071016050.4623-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Feb 2001, Hugh Dickins wrote:
> 
> Micro-optimization season?

I'd rather not do these kinds of things that the compiler should be able
to trivially do for us.

(gcc sometimes _does_ do these things. I've seen it. Why doesn't it do it
here? Did you check the code? Have you asked the gcc lists?)

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
