Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268234AbRGWOKW>; Mon, 23 Jul 2001 10:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268235AbRGWOKN>; Mon, 23 Jul 2001 10:10:13 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:13837 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268234AbRGWOJ7>; Mon, 23 Jul 2001 10:09:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [OT] Re: 2.4.7: wtf is "ksoftirqd_CPU0"
Date: Mon, 23 Jul 2001 16:14:34 +0200
X-Mailer: KMail [version 1.2]
Cc: "peter k." <spam-goes-to-dev-null@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <000f01c111ff$73602ce0$c20e9c3e@host1> <01072201370202.02679@starship> <20010721165346.U3889@opus.bloom.county>
In-Reply-To: <20010721165346.U3889@opus.bloom.county>
MIME-Version: 1.0
Message-Id: <01072316143401.00315@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sunday 22 July 2001 01:53, Tom Rini wrote:
> On Sun, Jul 22, 2001 at 01:37:02AM +0200, Daniel Phillips wrote:
> > On Saturday 21 July 2001 18:38, Jeff Garzik wrote:
> > > "peter k." wrote:
> > > > i just installed 2.4.7, now a new process called
> > > > "ksoftirqd_CPU0" is started automatically when booting (by the
> > > > kernel obviously)? why? what does it do? i didnt find any
> > > > useful information on it in linuxdoc / linux-kernel archives
> > >
> > > it is used internally, ignore it.
> >
> > It's pretty hard to ignore a process with a name that ugly ;-)
> >
> > How about just ksoft0 ?  Or kirq0?
>
> Now this is just getting silly.  It follows the same convention the
> 6-8 other k* daemons follow.  Would you want kswpd? kupd? kreclmd? 
> Probably not.

Err, wasn't I arguing *against* trying to encode whole sentences in the 
daemon names?  Personally, I have a similar distaste for naming 
strategies that involve leaving out the vowels.

And no, I don't really like kirq or ksoft very much either.

I'd like to see the following in my ps -A list:

  kupdate
  kflush
  kinterrupt

Something like that.  We don't need d's at the ends because we have k's 
at the beginnings, don't you think?  I can see the logic for appending 
numbers to per-processor daemons, but as for doing it even on UP 
kernels, it's not so obviously a good idea.

As far as 'naming conventions' for daemons go, they went out the window 
when kflushd became bdflush.

--
Daniel
