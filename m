Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285192AbRLRV07>; Tue, 18 Dec 2001 16:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285180AbRLRVZk>; Tue, 18 Dec 2001 16:25:40 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:22034 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S285190AbRLRVY7>; Tue, 18 Dec 2001 16:24:59 -0500
Date: Tue, 18 Dec 2001 19:24:41 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "David S. Miller" <davem@redhat.com>
Cc: <rmk@arm.linux.org.uk>, <kuznet@ms2.inr.ac.ru>, <Mika.Liljeberg@welho.com>,
        <Mika.Liljeberg@nokia.com>, <linux-kernel@vger.kernel.org>,
        <sarolaht@cs.helsinki.fi>
Subject: Re: ARM: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
In-Reply-To: <20011218.131155.91757544.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0112181923030.28489-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001, David S. Miller wrote:
> From: Russell King <rmk@arm.linux.org.uk>
>    On Tue, Dec 18, 2001 at 11:29:06PM +0300, kuznet@ms2.inr.ac.ru wrote:
>    > No doubts it still has broken misaligned access.
>
>    You're way out of line with that comment.
>
> Not necessarily Russell.  You have even told us on several occaisions
> that the older ARMs simply cannot fix up unaligned loads/stores in
> fact.

Then the problem will have to be fixed elsewhere, maybe
by having the networking code do explicit unaligned
accesses through some macro which defaults to a normal
access on other systems ?

> Look, we're analyzing a problem and trying to explore every avenue for
> possible problems.  If this were sparc64 I'd be checking my unaligned
> handler for bugs :-)

If sparc64 had this hardware problems, I'm sure we'd have
special hacks to handle the situation all throughout the
kernel already, instead of having such hacks blocked by
subsystem maintainers.

cheers,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

