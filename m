Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288996AbSAUBlg>; Sun, 20 Jan 2002 20:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288999AbSAUBl3>; Sun, 20 Jan 2002 20:41:29 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:30475 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288996AbSAUBlV>;
	Sun, 20 Jan 2002 20:41:21 -0500
Date: Sun, 20 Jan 2002 23:40:40 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4B6E30.2020007@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201202340250.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Hans Reiser wrote:

> I think I must have said free when I meant clean, and this naturally
> confused you.
>
> writepage() cleans pages, which is sometimes necessary for freeing them,
> but it does not free them itself.
>
> The one place where we would free them is when we repack slums before
> writing them.  In this case, an empty node is not going to get accessed
> again, so it should be freed.

Agreed.

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

