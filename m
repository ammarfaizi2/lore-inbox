Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132304AbRARQwK>; Thu, 18 Jan 2001 11:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132294AbRARQwC>; Thu, 18 Jan 2001 11:52:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18694 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132301AbRARQvz>; Thu, 18 Jan 2001 11:51:55 -0500
Date: Thu, 18 Jan 2001 08:51:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.30.0101181422180.823-100000@elte.hu>
Message-ID: <Pine.LNX.4.10.10101180850290.18072-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Jan 2001, Ingo Molnar wrote:
> 
> Basically MSG_MORE is a simplified probability distribution of the next
> SEND, and it already covers all the other (iovec, nagle, TCP_CORK)
> mechanizm available, in a surprisingly easy way IMO. I believe MSG_MORE is
> very robust from a theoreticaly point of view.

Yeah, and how are you going to teach a perl CGI script that writes to
stdout to use it?

Face it, it's limited. It has, in fact, many of the same limitations
TCP_NOPUSH has.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
