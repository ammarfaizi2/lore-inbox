Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBHQ5i>; Thu, 8 Feb 2001 11:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbRBHQ5S>; Thu, 8 Feb 2001 11:57:18 -0500
Received: from [62.172.234.2] ([62.172.234.2]:19937 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129055AbRBHQ5O>; Thu, 8 Feb 2001 11:57:14 -0500
Date: Thu, 8 Feb 2001 16:56:01 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: David Weinehall <tao@acc.umu.se>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Howells <dhowells@cambridge.redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] micro-opt DEBUG_ADD_PAGE
In-Reply-To: <20010208173745.A27383@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.21.0102081644360.12170-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, David Weinehall wrote:
> 
> Well, after all, it's debugging code, and the code now is easy to read.
> Your code, while more efficient, isn't. I think that clarity takes
> priority over efficiency in non-critical code such as debugging
> code. Of course, this is my personal opinion...

I agree my version isn't _as_ easy, and if this code only got built
into DEBUG kernels, I would never have bothered about it; but it's
built into every kernel, on executed paths, so it's no less critical.

Hugh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
