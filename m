Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293069AbSBWBcn>; Fri, 22 Feb 2002 20:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293068AbSBWBcc>; Fri, 22 Feb 2002 20:32:32 -0500
Received: from bitmover.com ([192.132.92.2]:38805 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293067AbSBWBcX>;
	Fri, 22 Feb 2002 20:32:23 -0500
Date: Fri, 22 Feb 2002 17:32:22 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Rik van Riel <riel@conectiva.com.br>, Christoph Hellwig <hch@caldera.de>,
        lm@bitmover.com, hpa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 bitkeeper repository
Message-ID: <20020222173222.E11156@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Christoph Hellwig <hch@caldera.de>, lm@bitmover.com, hpa@kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020222193723.GL719@opus.bloom.county> <Pine.LNX.4.33L.0202221648320.7820-100000@imladris.surriel.com> <20020223003513.GM719@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020223003513.GM719@opus.bloom.county>; from trini@kernel.crashing.org on Fri, Feb 22, 2002 at 05:35:13PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 05:35:13PM -0700, Tom Rini wrote:
> > You forgot about setting the proper BK_USER, BK_HOST and
> > 'bk comment' commands ;)
> 
> heh.  Those are rather new things, aren't they? :)  Anyhow, the goal for
> these tree(s) is to keep the PPC children trees up to date.

BK_USER, BK_HOST have been around forever but their use is discouraged for
the following reason: BK is a distributed system, we need unique names for
things, and the user&host are part of the name we make up.

bk comments is new and a darned useful thing, too, I'm glad Linus asked
for it.  You just have to read the man page and realize that your updates
to the comments may not propogate.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
