Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285484AbRLNU0G>; Fri, 14 Dec 2001 15:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285491AbRLNUZ4>; Fri, 14 Dec 2001 15:25:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49166 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285484AbRLNUZw>; Fri, 14 Dec 2001 15:25:52 -0500
Date: Fri, 14 Dec 2001 12:25:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <Andries.Brouwer@cwi.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kill(-1,sig)
In-Reply-To: <UTC200112141734.RAA20953.aeb@cwi.nl>
Message-ID: <Pine.LNX.4.33.0112141224200.2957-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Dec 2001 Andries.Brouwer@cwi.nl wrote:
>
> The new POSIX 1003.1-2001 is explicit about what kill(-1,sig)
> is supposed to do. Maybe we should follow it.

Well, we should definitely not do it in 2.4.x, at least not until proven
that no real applications break.

But I applied it to 2.5.x, let's see who (if anybody) hollers.

		Linus

