Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280656AbRKBLRy>; Fri, 2 Nov 2001 06:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280655AbRKBLRp>; Fri, 2 Nov 2001 06:17:45 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:30469 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280656AbRKBLRi>;
	Fri, 2 Nov 2001 06:17:38 -0500
Date: Fri, 2 Nov 2001 09:17:16 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: safemode <safemode@speakeasy.net>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: graphical swap comparison of aa and rik vm
In-Reply-To: <20011102041819.4C36238C0A@perninha.conectiva.com.br>
Message-ID: <Pine.LNX.4.33L.0111020915390.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, safemode wrote:

> I think the answer of why AA's kernel beat rik's has nothing to do
> with how much swap rik is using or how much swap is being swapped back
> in.  It has to do with how rik decides what to swap.  Apparently the
> algorithm used by rik to play with memory is taking seriously too much
> cpu and it leaves little for the actual process to work.

Note that this is likely to be a side effect of running
completely out of swap, because that means many of the
"obvious candidates" of what to swap out cannot be swapped
out, meaning we have to scan more pages until we find
something which already has swap backing.

Before you draw conclusions like the one above, please test
again with more swap.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

