Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316247AbSEKShN>; Sat, 11 May 2002 14:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316257AbSEKShM>; Sat, 11 May 2002 14:37:12 -0400
Received: from bitmover.com ([192.132.92.2]:31398 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316247AbSEKShK>;
	Sat, 11 May 2002 14:37:10 -0400
Date: Sat, 11 May 2002 11:37:10 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Larry McVoy <lm@bitmover.com>, Gerrit Huizenga <gh@us.ibm.com>,
        Lincoln Dale <ltd@cisco.com>, Andrew Morton <akpm@zip.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14 IDE 56)
Message-ID: <20020511113710.C30126@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Larry McVoy <lm@bitmover.com>, Gerrit Huizenga <gh@us.ibm.com>,
	Lincoln Dale <ltd@cisco.com>, Andrew Morton <akpm@zip.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Padraig Brady <padraig@antefacto.com>,
	Anton Altaparmakov <aia21@cantab.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020511111935.B30126@work.bitmover.com> <Pine.LNX.4.44.0205111130080.879-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 11:35:21AM -0700, Linus Torvalds wrote:
> See my details on doing the perfect zero-copy copy thing.
> 
> The mmap doesn't actually touch the page tables - it ends up being nothing
> but a "placeholder".

Huh, I must have missed something, does the mmap() not create any page
tables at all?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
