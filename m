Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbRGWWXK>; Mon, 23 Jul 2001 18:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbRGWWXA>; Mon, 23 Jul 2001 18:23:00 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:54744 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S261651AbRGWWWt>; Mon, 23 Jul 2001 18:22:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Andrea Arcangeli <andrea@suse.de>, Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: user-mode port 0.44-2.4.7
Date: Mon, 23 Jul 2001 09:20:32 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107231259520.13272-100000@penguin.transmeta.com> <200107232150.f6NLosh13126@vindaloo.ras.ucalgary.ca> <20010724000933.I16919@athlon.random>
In-Reply-To: <20010724000933.I16919@athlon.random>
MIME-Version: 1.0
Message-Id: <01072309203206.00996@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Monday 23 July 2001 18:09, Andrea Arcangeli wrote:

> GCC will obviously _never_ introduce a BUG(), I never said that, the
> above example is only meant to show what GCC is _allowed_ to do and what
> we have to do to write correct C code.

"Correct" C code as in portable C code?  Standards compliant so it's portable 
to other compilers?

The linux kernel is compiled on gcc.  It always has been.  Specific versions 
of the kernel have a specific range of "known working" gcc versions that in 
the past have produced a functional result.  gcc is -ALLOWED- to compile code 
the way Borland, Watcom, or Microsoft C compilers do.  Assuming somebody 
wants to rewrite gcc from scratch and still call the result gcc...

Standards are fun, but we don't even thread posixly yet...

Rob
