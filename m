Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285073AbSAGSyT>; Mon, 7 Jan 2002 13:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285153AbSAGSyL>; Mon, 7 Jan 2002 13:54:11 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:56582 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S285073AbSAGSx4>;
	Mon, 7 Jan 2002 13:53:56 -0500
Date: Mon, 7 Jan 2002 16:53:31 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving oom detection in rmap10c.
In-Reply-To: <20020106154950.5B067693F@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.33L.0201071635170.872-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Ed Tomlinson wrote:

> This patch should prevent oom situations where the vm does not see
> pages released from the slab caches.

> Comments?

I have a feeling the OOM detection in rmap10c isn't working
out because of another issue ... I think it has something to
do with the swap allocation failure path indirectly triggering
OOM, I think I'll go audit the code now ;)

(oh the wonders of maintaining code ... auditing everybody's
code and tracking down bugs instead of doing fun development ;))

cheers,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

