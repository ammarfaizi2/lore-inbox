Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289057AbSAIWhL>; Wed, 9 Jan 2002 17:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289056AbSAIWgz>; Wed, 9 Jan 2002 17:36:55 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:32521 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289057AbSAIWgh>;
	Wed, 9 Jan 2002 17:36:37 -0500
Date: Wed, 9 Jan 2002 20:36:13 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt Dainty <matt@bodgit-n-scarper.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Where's all my memory going?
In-Reply-To: <E16OMpF-0001pj-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0201092034590.2985-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Alan Cox wrote:

> > However, over time, (30-45 minutes), more and more memory seems to just
> > disappear from the system until it looks like this, (note that swap is
> > hardly ever touched):
>
> I don't see any disappearing memory. Remember that Linux will
> intentionally keep memory filled with cache pages when it is possible.

Matt's system seems to go from 900 MB free to about
300 MB (free + cache).

I doubt qmail would eat 600 MB of RAM (it might, I
just doubt it) so I'm curious where the RAM is going.

Matt, do you see any suspiciously high numbers in
/proc/slabinfo ?

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

