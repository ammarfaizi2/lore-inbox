Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292392AbSBBVQd>; Sat, 2 Feb 2002 16:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292390AbSBBVQO>; Sat, 2 Feb 2002 16:16:14 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:61956 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292389AbSBBVQG>;
	Sat, 2 Feb 2002 16:16:06 -0500
Date: Sat, 2 Feb 2002 19:15:54 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Richard Henderson <rth@twiddle.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Anton Blanchard <anton@samba.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020202105714.A13803@are.twiddle.net>
Message-ID: <Pine.LNX.4.33L.0202021915160.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2002, Richard Henderson wrote:
> On Fri, Feb 01, 2002 at 09:04:45AM -0200, Rik van Riel wrote:
> > As for not putting kernel objects everywhere, this comes
> > naturally with HIGHMEM ;)
>
> Not for 64-bit targets.

Agreed.  We'll probably want to find something else to fix this
problem ...

(like, allocating kernel area as much contiguously as possible,
leaving space for large freeable areas elsewhere)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

