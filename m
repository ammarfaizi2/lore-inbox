Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283786AbRL1AzJ>; Thu, 27 Dec 2001 19:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283836AbRL1AzA>; Thu, 27 Dec 2001 19:55:00 -0500
Received: from ns.suse.de ([213.95.15.193]:10253 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S283786AbRL1Ayp>;
	Thu, 27 Dec 2001 19:54:45 -0500
Date: Fri, 28 Dec 2001 01:54:42 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: State of the new config & build system
In-Reply-To: <200112280024.fBS0OYH26337@snark.thyrsus.com>
Message-ID: <Pine.LNX.4.33.0112280147290.18346-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Eric S. Raymond wrote:

> ..., and Keith's stuff is stable
> enough that he's now adding features like kernel-image type selection
> that were obviously way down his to-do list.

How far down the list was "make it not take twice as long
to build the kernel as kbuild 2.4" ? Keith mentioned O(n^2)
effects due to each compile operation needing to reload
the dependancies etc.

Given how early your both pushing to get these into the tree(s),
and given how many kernels are going to be built between now
and 2.6.0, slowing down development for _every_ kernel developer
doesn't strike me as a bright move. Maybe keep them both in the
tree until this issue is worked out ? That way those who want to
play with kbuild can do so, and those who build a few dozen
kernels a day don't have to twiddle thumbs.

Don't get me wrong, I'm not knocking CML2 or kbuild2.5,
I'm just interested in some of timescale for getting wrinkles
like this out.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

