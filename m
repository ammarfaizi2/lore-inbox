Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293182AbSBWSWY>; Sat, 23 Feb 2002 13:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293170AbSBWSWF>; Sat, 23 Feb 2002 13:22:05 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:29364 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S293169AbSBWSVz>; Sat, 23 Feb 2002 13:21:55 -0500
Date: Sat, 23 Feb 2002 19:21:54 +0100
From: bert hubert <ahu@ds9a.nl>
To: Alexander Viro <viro@math.psu.edu>
Cc: Dan Aloni <da-x@gmx.net>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] C exceptions in kernel
Message-ID: <20020223192154.A3837@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Alexander Viro <viro@math.psu.edu>, Dan Aloni <da-x@gmx.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020223162100.A1952@outpost.ds9a.nl> <Pine.GSO.4.21.0202231242030.26375-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0202231242030.26375-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Feb 23, 2002 at 05:49:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 05:49:04PM +0000, Alexander Viro wrote:

> On Sat, 23 Feb 2002, bert hubert wrote:
> 
> > Potentially this is very cool but I'm again appalled at the INSTANT
> > rejection seen here by kernel hackers, minor and major. Do NOT reject an
> > idea before you've thought it through.
> 
> Quite a few of us _had_ thought it through.

Good.

> You know, there's a reason why most of letal mutations are recessive.
> Namely, it's not the first time when they happen and mechanisms making
> them recessive had been selected for.

An ostrich might reason that way too. And that is basically my main gripe.

> Same story here.  It's _not_ the first time this topic had been discussed
> on l-k.  It might be new for you, but it sure as hell _not_ new for quite
> a few people here.

Oh I've seen it. What I resent is the kneejerk reaction. Most people
replying obviously hadn't even looked at the source. Keith Owen's reaction
was wonderful:

	The kernel model is "get it right the first time, so we don't need
	exception handlers".  You have not given any reason why the existing
	mechanisms are failing.

Or Edgar Toernig, who also had an implementation and rejected Dan's in one
line: 

	Bad idea ...

Richard B. Johnson:

	What is this supposed to do?  Are these a bunch of solutions waiting
	for a problem? Or is my Calendar wrong?

Davide Libenzi:

	Is today the 1st of April ? You kidding, don't you ?

I mean, this is just pathetic. There is valid criticism to new ideas, but
this isn't it.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
