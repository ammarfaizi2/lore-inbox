Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318455AbSHKXMq>; Sun, 11 Aug 2002 19:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318458AbSHKXMq>; Sun, 11 Aug 2002 19:12:46 -0400
Received: from bitmover.com ([192.132.92.2]:37322 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S318455AbSHKXMq>;
	Sun, 11 Aug 2002 19:12:46 -0400
Date: Sun, 11 Aug 2002 16:15:01 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@arcor.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       frankeh@watson.ibm.com, davidm@hpl.hp.com,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
Message-ID: <20020811161501.E17310@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@arcor.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, frankeh@watson.ibm.com,
	davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
	"David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
	Martin.Bligh@us.ibm.com, wli@holomorpy.com,
	linux-kernel@vger.kernel.org
References: <E17e1H8-0001iE-00@starship> <Pine.LNX.4.44.0208111553010.1233-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208111553010.1233-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Aug 11, 2002 at 03:55:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 03:55:08PM -0700, Linus Torvalds wrote:
> 
> On Mon, 12 Aug 2002, Daniel Phillips wrote:
> > 
> > It goes on in this vein.  I suggest all vm hackers have a close look at
> > this.  Yes, it's stupid, but we can't just ignore it.
> 
> Actually, we can, and I will.
> 
> I do not look up any patents on _principle_, because (a) it's a horrible 
> waste of time and (b) I don't want to know. 
> 
> The fact is, technical people are better off not looking at patents. If
> you don't know what they cover and where they are, you won't be knowingly
> infringing on them. If somebody sues you, you change the algorithm or you 
> just hire a hit-man to whack the stupid git.

This issue is more complicated than you might think.  Big companies with 
big pockets are very nervous about being too closely associated with 
Linux because of this problem.  Imagine that IBM, for example, starts
shipping IBM Linux.  Somewhere in the code there is something that 
infringes on a patent.  Given that it is IBM Linux, people can make 
the case that IBM should have known and should have fixed it and 
since they didn't, they get sued.  Notice that IBM doesn't ship 
their own version of Linux, they ship / support Red Hat or Suse
(maybe others, doesn't matter).  So if they ever get hassled, they'll
vector the problem to those little guys and the issue will likely
get dropped because the little guys have no money to speak of.

Maybe this is all good, I dunno, but be aware that the patents 
have long arms and effects.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
