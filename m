Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132883AbQL2AIy>; Thu, 28 Dec 2000 19:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132925AbQL2AIo>; Thu, 28 Dec 2000 19:08:44 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:20485 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132883AbQL2AId>; Thu, 28 Dec 2000 19:08:33 -0500
Date: Thu, 28 Dec 2000 15:37:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
In-Reply-To: <20001229002527.C25388@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.10.10012281536510.1123-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2000, Andi Kleen wrote:
> 
> Hopefully all the "goto out" micro optimizations can be taken out then too,

"goto out" often generates much more readable code, so the optimization is
secondary.

> I recently found out that gcc 2.97's block moving pass has the tendency
> to move the outlined blocks inline again ;) 

Too bad. Maybe somebody should tell gcc maintainers about programmers that
know more than the compiler again.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
