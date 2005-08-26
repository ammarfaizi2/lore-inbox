Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbVHZRH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbVHZRH0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbVHZRG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:06:58 -0400
Received: from web33307.mail.mud.yahoo.com ([68.142.206.122]:6018 "HELO
	web33307.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965144AbVHZRG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:06:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bEnX9fYwaDQkleGzNr6dDBEUTyikDweDZxD6qP2XkPCDoX7b+ZjmhaEIgTHnXFTP+MFJzSN1qCmD7RB1lQBE+dr7A4sBxGq+5EWBveENnLLH9FhRyJyYd5stBqF3o/Qr4nfUTubV4WQmUc0sFW8ZrdQ/A3GThi8bE3ysPpKZ8QQ=  ;
Message-ID: <20050826170652.19282.qmail@web33307.mail.mud.yahoo.com>
Date: Fri, 26 Aug 2005 10:06:51 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050826162132.GH6471@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Adrian Bunk <bunk@stusta.de> wrote:

> On Fri, Aug 26, 2005 at 08:34:14AM -0700,
> Danial Thom wrote:
> > 
> > --- Adrian Bunk <bunk@stusta.de> wrote:
> > > 
> > > That's not always true.
> > > 
> > > Imagine a slow computer with a GBit
> ethernet
> > > connection, where the user 
> > > is downloading files from a server that can
> > > utilize the full 
> > > network connection while listening to music
> > > from his local disk with 
> > > XMMS.
> > > 
> > > In this case, the audio stream is not
> depending
> > > on the network 
> > > connection. And the user might prefer
> dropped
> > > packages over a stuttering 
> > > XMMS.
> 
> > Audio connections are going to be
> windowed/flowed
> > in some way (thats how the internet works) so
> >...
> 
> I was talking about an audio stream coming from
> a file on the
> "local disk", IOW something like an mp3 file.
> 
> But the most interesting thing about your email
> is not what you were 
> answering to, but which part of my email you
> silently omitted. Since you 
> are not answering questions that might help to
> debug the problem you 
> claim to have, it seems your intention is not
> getting a Linux problem 
> fixed...

I don't think I'm obligated to answer every
single person who pipes into a thread. People who
say "show me your config and dmesg" are not
useful. Linux has long had a philisophical
problem of dropping packets as a "performance
feature", and we've already established I think
that you can't eliminate it altogether, if you
read the thread carefully.

Also, if you're on a slow machine you can't
download faster than your machine can handle it,
because the "server on a gig network" can't send
faster then you tell it to, not matter how fast
it is. You'll never overrun a machine with 1 or 2
or 5 connections. Having a clue how things work
is important. 


DT


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
