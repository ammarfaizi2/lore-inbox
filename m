Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbRGXCxP>; Mon, 23 Jul 2001 22:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266738AbRGXCxG>; Mon, 23 Jul 2001 22:53:06 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:5849 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S266730AbRGXCw4>; Mon, 23 Jul 2001 22:52:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: user-mode port 0.44-2.4.7
Date: Mon, 23 Jul 2001 13:50:37 -0400
X-Mailer: KMail [version 1.2]
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107231259520.13272-100000@penguin.transmeta.com> <01072309203206.00996@localhost.localdomain> <20010724002742.J16919@athlon.random>
In-Reply-To: <20010724002742.J16919@athlon.random>
MIME-Version: 1.0
Message-Id: <01072313503700.06889@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Monday 23 July 2001 18:27, Andrea Arcangeli wrote:
> On Mon, Jul 23, 2001 at 09:20:32AM -0400, Rob Landley wrote:
> > On Monday 23 July 2001 18:09, Andrea Arcangeli wrote:
> > > GCC will obviously _never_ introduce a BUG(), I never said that, the
> > > above example is only meant to show what GCC is _allowed_ to do and
> > > what we have to do to write correct C code.
> >
> > "Correct" C code as in portable C code?  Standards compliant so it's
> > portable
>
> correct C code _mainly_ for gcc which is very aggressive.
>
> Andrea

Very aggressive and very known.

If we know how GCC is going to behave in a given situation (and have a fairly 
good idea of how it's going to behave in the future), we don't have to worry 
about theoretical stardards loopholes like it calling BUG(), do we?

Is there something in the current behavior that's causing trouble (in which 
case, what exactly is it), or are the gcc guys (who you mentioned earlier*) 
warning that the behavior of upcoming versions of gcc is likely to break 
known constructs in the current kernel?

Rob

(Has the english language officially held a funeral for the word "whom" yet?)
