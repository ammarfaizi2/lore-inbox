Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292304AbSBBPkF>; Sat, 2 Feb 2002 10:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292306AbSBBPj4>; Sat, 2 Feb 2002 10:39:56 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:12041 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292304AbSBBPjw>;
	Sat, 2 Feb 2002 10:39:52 -0500
Date: Sat, 2 Feb 2002 13:39:34 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: <arjan@fenrus.demon.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020201144751.A32553@havoc.gtf.org>
Message-ID: <Pine.LNX.4.33L.0202021339090.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002, Jeff Garzik wrote:

> > the biggest reason for this is that we *suck* at readahead for mmap....
>
> Is there not also fault overhead and similar issues related to mmap(2)
> in general, that are not present with read(2)/write(2)?

If a fault is more expensive than a system call, we're doing
something wrong in the page fault path ;)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

