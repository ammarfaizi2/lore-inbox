Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283658AbRLRBze>; Mon, 17 Dec 2001 20:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283603AbRLRBzV>; Mon, 17 Dec 2001 20:55:21 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:27658 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S283586AbRLRByk>;
	Mon, 17 Dec 2001 20:54:40 -0500
Date: Mon, 17 Dec 2001 23:54:26 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112171449520.1854-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0112172353420.15741-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Linus Torvalds wrote:

> You have to prioritize. Scheduling overhead is way down the list.

That's not what the profiling on my UP machine indicates,
let alone on SMP machines.

Try readprofile some day, chances are schedule() is pretty
near the top of the list.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

