Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291079AbSAaOBN>; Thu, 31 Jan 2002 09:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291078AbSAaOBD>; Thu, 31 Jan 2002 09:01:03 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:23303 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291079AbSAaOAt>;
	Thu, 31 Jan 2002 09:00:49 -0500
Date: Thu, 31 Jan 2002 12:00:35 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Josh MacDonald <jmacd@CS.Berkeley.EDU>
Cc: Momchil Velikov <velco@fadata.bg>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020131024128.B14482@helen.CS.Berkeley.EDU>
Message-ID: <Pine.LNX.4.33L.0201311159500.32634-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, Josh MacDonald wrote:

> I've posted this before -- my cache-optimized skip list solves the
> problem of balanced-tree cache footprint.  It uses cacheline-sized
> nodes and per-node locking to avoid false-sharing and increase
> concurrency.  The memory usage for the skip list is also less than
> the red-black tree for trees larger than several hundred nodes.

I'd be happy to test a kernel where the page cache uses
these skip lists for indexing.

Where can I download the patch ?  ;)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

