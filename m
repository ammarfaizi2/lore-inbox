Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSFLGI7>; Wed, 12 Jun 2002 02:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317638AbSFLGI6>; Wed, 12 Jun 2002 02:08:58 -0400
Received: from netcore.fi ([193.94.160.1]:24076 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S317637AbSFLGI5>;
	Wed, 12 Jun 2002 02:08:57 -0400
Date: Wed, 12 Jun 2002 09:08:55 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: Mark Mielke <mark@mark.mielke.cc>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <20020612012004.A15773@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0206120905510.29780-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, Mark Mielke wrote:

> On Tue, Jun 11, 2002 at 11:57:26PM -0400, Richard Guy Briggs wrote:
> > On Tue, Jun 11, 2002 at 08:41:19PM -0700, David S. Miller wrote:
> > >    From: Bill Davidsen <davidsen@tmr.com>
> > >    Date: Tue, 11 Jun 2002 18:41:16 -0400 (EDT)
> > >      Actually your arguments sound like you have a solution to your problem
> > >    and you want everyone to use it even if it doesn't help them. Have you
> > >    some emotional tie to SNMP, like being an author?
> > Basically Bill, if you don't like this policy, fork the code.  That is
> > one of the strengths (and weaknesses) of open source.  If your tree
> > works better and gets wider use, then something about it must be better.
> > If not, then maybe it wasn't.  This community works on reputation
> > capital (and some diplomacy).
> 
> To some degree (i.e. I know it is not intentional), this comes across as
> blackmail.
> 
> Sorta like "if you want to play ball with me, you play by my rules,
> otherwise you can go find your own diamond and your own friends to
> play with."
> 
> I would still like to see David's logic as to why the approach is bad.
> 
> So far it amounts to 1) David doesn't like it, 2) David doesn't see a need
> for it, or can see other less adequate methods of approximating the same
> effect, and 3) David suspects that it will effect the performance of all
> users to provide a limited gain for some applications.

Just to chime in my support (not that I don't think anyone needs it), I 
think socket-based counters are An Extremely Bad Idea.  

They might be useful in some rather specific debugging scenarios (like 
100's on debugging printk's too!), but definitely not something we want to 
be cluttering the main tree with, _especially_ before they've shown their 
worth (doubtful).

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords


