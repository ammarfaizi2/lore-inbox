Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282882AbRLQVOe>; Mon, 17 Dec 2001 16:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282877AbRLQVOY>; Mon, 17 Dec 2001 16:14:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33288 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282880AbRLQVOM>; Mon, 17 Dec 2001 16:14:12 -0500
Date: Mon, 17 Dec 2001 13:13:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Udo A. Steinberg" <reality@delusion.de>
cc: Simon Kirby <sim@netnation.com>, <Andries.Brouwer@cwi.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kill(-1,sig)
In-Reply-To: <3C1E5AEE.7FD79DF4@delusion.de>
Message-ID: <Pine.LNX.4.33.0112171311400.1587-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Note that I've reverted the kill(-1...) thing in my personal tree: so far
I've gotten a lot of negative feedback, and the change doesn't seem to
actually buy us anything except for conformance to a unclearly weasel-
worded standards sentence where we could be even more weasely and just say
that "self" is a special process from the systems perspective.

		Linus

