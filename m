Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276511AbRKDTwx>; Sun, 4 Nov 2001 14:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275270AbRKDTwn>; Sun, 4 Nov 2001 14:52:43 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:31153 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S275224AbRKDTwg>; Sun, 4 Nov 2001 14:52:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Sun, 4 Nov 2001 20:53:39 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0111041141100.14150-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111041141100.14150-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011104195234Z17036-23342+8@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 4, 2001 08:46 pm, Linus Torvalds wrote:
> On Sun, 4 Nov 2001, Daniel Phillips wrote:
> > >
> > > The computer can parse anything.
> >
> > OK, then lets keep the 'current' variable in ASCII.
> 
> Yeah, the old "argument by absurdity".
> 
> Did you ever take logics class? It isn't a valid argument at all.
> 
> My argument is: humans want the data they want in a readable format. What
> the _hell_ does that have to do with the "current" variable?




> > > Handling spaces and newlines is easy enough - see the patches from Al
> > > Viro, for example.
> >
> > Why are we doing this parsing in the kernel when it can be done in user
> > space?
> 
> We're not parsing anything.
> 
> We're marshalling the data into a format that is independent of whatever
> internal representation the kernel happens to have for it that particular
> day.
> 
> A representation that is valid across architectures, and a representation
> that is unambiguous. A representation that various scripts can trivially
> use, and a representation that is not bound by fixed-sized fields or other
> idiocy.
> 
> In short, text strings.
> 
> They have advantages even for a computer. Fixed-size binary interfaces are
> BAD for information interchange. They are bad as a word document file
> format, they are bad for email, and they are bad for /proc. Get it?
> 
> Would you prefer doc-files to be standard text, marshalled into some
> logical form? Or do you prefer binary blobs of data that is limited by the
> binary format?
> 
> 		Linus
> 
> 
