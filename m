Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263176AbSJGUmE>; Mon, 7 Oct 2002 16:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263177AbSJGUmE>; Mon, 7 Oct 2002 16:42:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8204 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263176AbSJGUmC>; Mon, 7 Oct 2002 16:42:02 -0400
Date: Mon, 7 Oct 2002 13:46:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not3.0
 -   (NUMA))
In-Reply-To: <3DA1EF3C.65C0073F@digeo.com>
Message-ID: <Pine.LNX.4.33.0210071344200.10749-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, Andrew Morton wrote:
> 
> The other obvious heuristic is "if the parent directory was
> created in the last five seconds, use find_group_other()".  But
> that made Linus go "ewwww".

Well, it makes me go "less ewww" than the current scheme, so if that turns 
out to be acceptable to others, I won't mind _too_ much.

The reason I don't like time too much persoanlly is that it's not very 
reproducible. Especially if the times are in the second range. I'd rather 
have a heuristic that is deterministic.

		Linus

