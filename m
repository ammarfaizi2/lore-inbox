Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290672AbSA3WZa>; Wed, 30 Jan 2002 17:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290670AbSA3WZZ>; Wed, 30 Jan 2002 17:25:25 -0500
Received: from bitmover.com ([192.132.92.2]:44202 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290668AbSA3WZJ>;
	Wed, 30 Jan 2002 17:25:09 -0500
Date: Wed, 30 Jan 2002 14:25:08 -0800
From: Larry McVoy <lm@bitmover.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Larry McVoy <lm@bitmover.com>, Jeff Garzik <garzik@havoc.gtf.org>,
        Rob Landley <landley@trommello.org>,
        Miles Lane <miles@megapathdsl.net>, Chris Ricker <kaboom@gatech.edu>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130142508.H22323@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Rob Landley <landley@trommello.org>,
	Miles Lane <miles@megapathdsl.net>,
	Chris Ricker <kaboom@gatech.edu>,
	World Domination Now! <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130080642.E18381@work.bitmover.com> <Pine.LNX.4.33.0201301830320.9003-100000@serv> <20020130121752.B21235@work.bitmover.com> <3C585F4D.5195AC11@linux-m68k.org> <20020130131855.A22323@work.bitmover.com> <3C587009.A274BBF0@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C587009.A274BBF0@linux-m68k.org>; from zippel@linux-m68k.org on Wed, Jan 30, 2002 at 11:13:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 11:13:29PM +0100, Roman Zippel wrote:
> I meant the equivalent of cvs uses cases not the equivalent of three cvs
> commands, e.g. how would I handle cvs branches and join branches, how do
> I check out a specific version/date, how do I track external sources,
> which are not using bk, how do I get grep/cscope/... working without
> doubling the needed disk space with bk -r co.

s/branch/repository/ - every repository is essentially a vendor branch that
works.

bk clone -r<rev> reproduces the tree as of that rev.

bk -r grep is very useful.

Tracking external sources is fairly obvious, and BK excels at it, and
virtually 100% of our users have figured out how to do it without asking
us questions.

All of your issues are actually in the docs and well documented.  And if
you had asked us how to do it, we would have pointed you at the docs or
fixed them if they were incomplete.  I'm at a loss as to why you want to
prove to the entire lkml that you can't/won't read the docs, but hey,
if that's your bag go for it.  I'm willing to answer your questions as
they come up, so keep 'em coming.  It just helps educate the general 
list, though I suspect they may get a bit tired of it because most people
do read the docs and are more interested in the harder problems.  So
maybe we should take this offline?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
