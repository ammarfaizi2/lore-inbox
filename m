Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284242AbRLTLaR>; Thu, 20 Dec 2001 06:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284243AbRLTLaH>; Thu, 20 Dec 2001 06:30:07 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:7942 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S284242AbRLTL3y>;
	Thu, 20 Dec 2001 06:29:54 -0500
Date: Thu, 20 Dec 2001 09:29:28 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <torvalds@transmeta.com>, <bcrl@redhat.com>, <alan@lxorguk.ukuu.org.uk>,
        <davidel@xmailserver.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <20011219.213956.26276011.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0112200928110.15741-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2001, David S. Miller wrote:
> From: Rik van Riel <riel@conectiva.com.br>
>    On Tue, 18 Dec 2001, Linus Torvalds wrote:
>
>    > The thing is, I'm personally very suspicious of the "features for that
>    > exclusive 0.1%" mentality.
>
>    Then why do we have sendfile(), or that idiotic sys_readahead() ?
>
> Sending files over sockets are %99 of what most network servers are
> actually doing today, it is much more than 0.1% :-)

The same could be said for AIO, there are a _lot_ of
server programs which are heavily overthreaded because
of a lack of AIO...

cheers,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

