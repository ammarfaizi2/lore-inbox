Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289057AbSAaSuw>; Thu, 31 Jan 2002 13:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291012AbSAaSuk>; Thu, 31 Jan 2002 13:50:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55046 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289057AbSAaSue>; Thu, 31 Jan 2002 13:50:34 -0500
Date: Thu, 31 Jan 2002 10:49:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, Momchil Velikov <velco@fadata.bg>,
        John Stoffel <stoffel@casc.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33L.0201311635290.32634-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0201311047200.1682-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jan 2002, Rik van Riel wrote:
>
> It's still a question whether we'll want to use 128 as
> the branch factor or another number ... but I'm sure
> somebody will figure that out (and it can be changed
> later, it's just one define).

Actually, I think the big question is whether somebody is willing to clean
up and fix the "move_from_swap_cache()" issue with block_flushpage.

		Linus

