Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315232AbSDWPMl>; Tue, 23 Apr 2002 11:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315233AbSDWPMk>; Tue, 23 Apr 2002 11:12:40 -0400
Received: from bitmover.com ([192.132.92.2]:58801 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315232AbSDWPMk>;
	Tue, 23 Apr 2002 11:12:40 -0400
Date: Tue, 23 Apr 2002 08:12:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Larry McVoy <lm@bitmover.com>, Jeff Garzik <garzik@havoc.gtf.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020423081239.F25771@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jes Sorensen <jes@wildopensource.com>,
	Larry McVoy <lm@bitmover.com>, Jeff Garzik <garzik@havoc.gtf.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16yfW9-0000aZ-00@starship> <20020421171629.GK4640@zip.com.au> <20020421104046.J10525@work.bitmover.com> <20020421134851.B7828@havoc.gtf.org> <20020421105437.L10525@work.bitmover.com> <m3elh6obt7.fsf@trained-monkey.org> <20020423080216.E25771@work.bitmover.com> <m38z7eo3m7.fsf@trained-monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 11:07:28AM -0400, Jes Sorensen wrote:
> My suggestion is actually a bandwidth saver, browsing it and searching
> for the text file made me download a lot of HTML I would never have
> downloaded.

No argument.  However, as soon as we do the patch interface and the plain
text interface, BK can be treated as a patch server.  Then we get automated
scripts slurping down the data that way.

If you're willing to use BK just as a transport, it's a far more efficient
transport.  Ask people who have run rsync/ftp/bk all on the same system,
the BK way gets the same information across in less bits.

We're not going to be a patch server or a plain text server on the end of
our little T1 line.  If you want us to do that, then find someone to pay
for another T1 line and I'll happily dedicate it to bkbits.net and apply
the changes you want.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
