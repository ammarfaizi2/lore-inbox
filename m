Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280969AbRKDRmS>; Sun, 4 Nov 2001 12:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280970AbRKDRmK>; Sun, 4 Nov 2001 12:42:10 -0500
Received: from unthought.net ([212.97.129.24]:47832 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S281056AbRKDRmA>;
	Sun, 4 Nov 2001 12:42:00 -0500
Date: Sun, 4 Nov 2001 18:41:59 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104184159.E14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104163354.C14001@unthought.net> <160QM5-1HAz5sC@fmrl00.sul.t-online.com> <20011104172742Z16629-26013+37@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20011104172742Z16629-26013+37@humbolt.nl.linux.org>; from phillips@bonn-fries.net on Sun, Nov 04, 2001 at 06:28:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 06:28:47PM +0100, Daniel Phillips wrote:
> On November 4, 2001 05:45 pm, Tim Jansen wrote:
> > > The dot-proc file is basically a binary encoding of Lisp (or XML), e.g. it
> > > is a list of elements, wherein an element can itself be a list (or a
> > 
> > Why would anybody want a binary encoding? 
> 
> Because they have a computer?

Yes - good reason  :)

The "fuzzy parsing" userland has to do today to get useful information
out of many proc files today is not nice at all.  It eats CPU, it's 
error-prone, and all in all it's just "wrong".

However - having a human-readable /proc that you can use directly with
cat, echo,  your scripts,  simple programs using read(), etc.   is absolutely
a *very* cool feature that I don't want to let go.  It is just too damn
practical.

But building a piece of software that needs to reliably read out status
information from a system providing something more and more resembling a GUI in
text-files is becoming unnecessarily time-consuming and error-prone.

> 
> > It needs special parsers and will be almost impossible to access from shell 
> > scripts. 
> 
> No, look, he's proposing to put the binary encoding in hidden .files.  The 
> good old /proc files will continue to appear and operate as they do now.
> 

Exactly.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
