Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284177AbRLRQ20>; Tue, 18 Dec 2001 11:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284191AbRLRQ2Q>; Tue, 18 Dec 2001 11:28:16 -0500
Received: from borg.org ([208.218.135.231]:36624 "HELO borg.org")
	by vger.kernel.org with SMTP id <S284177AbRLRQ2B>;
	Tue, 18 Dec 2001 11:28:01 -0500
Date: Tue, 18 Dec 2001 11:27:59 -0500
From: Kent Borg <kentborg@borg.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently
Message-ID: <20011218112759.C4923@borg.org>
In-Reply-To: <3C1F323F.ED6AE4F4@idb.hist.no> <Pine.LNX.3.95.1011218085823.10303A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1011218085823.10303A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Dec 18, 2001 at 09:00:58AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 09:00:58AM -0500, Richard B. Johnson wrote:
> On Tue, 18 Dec 2001, Helge Hafting wrote:
> > A hacker don't need a /bin/sh or any other onboard software
> > to exploit some security flaw.
[...]
>    You apparently don't know what an embedded system does.
>    It is a device that uses a processor to perform some
>    designed functions. It cannot do something that it
>    was not designed to do although it can certainly fail
>    to do what it was designed to do.

If it contains a CPU (that is designed to run code) and RAM (that is
designed to store code) and you can trick the CPU in running code you
tricked it into putting in the RAM, then it can do anything it wants
with the other hardware available, anything it is designed to do.

>    If you want to break it, it's easier to hit it with a
>    hammer or an axe. There is not any capability to "break in".
>    Even if there was, what could you do? Shut off a motor?
>    Screw up the ignition timing? Put porn pictures into
>    medical images?

Or, be a proxy on the inside of J. Random Paranoid Corporate Network
that can relay stuff, snoop, sniff interesting stuff that is being
printed, etc.  I mean, how about establishing an http connection out
to a computer controlled by the Bad Guy, and over that he tunnels
whatever he wants?  And maybe it gets setup by putting some rogue
Postscript in a file he somehow conspires to be printed.

>    Most embedded systems don't have network capabilities.

Certainly if the embedded system has extremely limited IO (Coke
vending machine?) there are limited opportunities for exploiting
things like buffer overflows.

But even Coke machines are starting to get IO: to report inventory and
apparent function to the vending company, some to even allow payment
via a cellphone.  Don't think that embedded == isolated, for it is
becoming less and less true.

My cellphone has embedded software in it, it can receive e-mail.
(There was a recent story of a mal formed e-mail message that would
hard-crash some Nokia phones such even a power cycle wouldn't fix it!)

>    There is no way that you can teach your Hewlett-Packard
>    printer to become a network rogue and break into the
>    Pentagon --regardless of what you send it.

Boy, are you ever complacent.  Just because HP manages to largely
obscure the details of its internal CPU and RAM doesn't mean it ain't
there and potentially exploitable.

I have a friend who used to be really into desktop publishing,
Illustrator, his font collection, etc.  He frequently made the
distinction between a "hardware RIP" and a "software RIP".  His point
was actually that the embedded systems were better productized, but I
still corrected him and said they were both software, one was simply
embedded.  He never seemed to get the point, and you don't either.


-kb
