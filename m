Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbTBJXTC>; Mon, 10 Feb 2003 18:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbTBJXTC>; Mon, 10 Feb 2003 18:19:02 -0500
Received: from jalon.able.es ([212.97.163.2]:10437 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S265414AbTBJXTB>;
	Mon, 10 Feb 2003 18:19:01 -0500
Date: Tue, 11 Feb 2003 00:28:40 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jakob Oestergaard <jakob@unthought.net>,
       Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030210232840.GA11145@werewolf.able.es>
References: <1044385759.1861.46.camel@localhost.localdomain> <200302041935.h14JZ69G002675@darkstar.example.net> <b1pbt8$2ll$1@penguin.transmeta.com> <20030204232101.GA9034@work.bitmover.com> <20030204235112.GB17244@unthought.net> <20030210222632.GD22275@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030210222632.GD22275@dualathlon.random>; from andrea@suse.de on Mon, Feb 10, 2003 at 23:26:32 +0100
X-Mailer: Balsa 2.0.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.02.10 Andrea Arcangeli wrote:
> On Wed, Feb 05, 2003 at 12:51:12AM +0100, Jakob Oestergaard wrote:
> > On Tue, Feb 04, 2003 at 03:21:01PM -0800, Larry McVoy wrote:
> > > > I'd love to see a small - and fast - C compiler, and I'd be willing to
> > > > make kernel changes to make it work with it.  
> > > 
> > > I can't offer any immediate help with this but I want the same thing.  At
> > > some point, we're planning on funding some extensions into GCC or whatever
> > > reasonable C compiler is around:
> > 
> > [snipping Linus from To:]
> > 
> > Cool.
> > 
> > > 
> > >     - associative arrays as a builtin type
> > > 
> > >       {
> > >       	  assoc	bar = {};	// anonymous, no file backing
> > > 
> > > 	  bar{"some key"} = "some value";
> > > 	  if (defined(bar{"some other value"})) ...
> > >       }
> > 
> > Allow me:
> > 
> > {
> >  std::map<std::string,std::string> bar;
> > 
> >  bar["some key"] = "some value";
> >  if (bar.find("some other value") != bar.end()) ...
> > }
> 

And don't forget smart pointers with reference counting so you can get rid of
all those stupind kfree's... ;)

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre4-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-5mdk))
