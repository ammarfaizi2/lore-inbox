Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286150AbRLTGAv>; Thu, 20 Dec 2001 01:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286146AbRLTGAs>; Thu, 20 Dec 2001 01:00:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60176 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286150AbRLTGAL>; Thu, 20 Dec 2001 01:00:11 -0500
Date: Wed, 19 Dec 2001 21:58:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <riel@conectiva.com.br>, <bcrl@redhat.com>, <alan@lxorguk.ukuu.org.uk>,
        <davidel@xmailserver.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <20011219.213956.26276011.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0112192155390.19321-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Dec 2001, David S. Miller wrote:
>
>    Then why do we have sendfile(), or that idiotic sys_readahead() ?
>
> Sending files over sockets are %99 of what most network servers are
> actually doing today, it is much more than 0.1% :-)

Well, that was true when the thing was written, but whether anybody _uses_
it any more, I don't know. Tux gets the same effect on its own, and I
don't know if Apache defaults to using sendfile or not.

readahead was just a personal 5-minute experiment, we can certainly remove
that ;)

		Linus

