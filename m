Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318859AbSG0XSP>; Sat, 27 Jul 2002 19:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318858AbSG0XSP>; Sat, 27 Jul 2002 19:18:15 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:45813 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S318855AbSG0XSM>;
	Sat, 27 Jul 2002 19:18:12 -0400
Date: Sun, 28 Jul 2002 01:21:29 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Robert White <rwhite@pobox.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Ed Vance <EdV@macrolink.com>,
       "'Theodore Tso'" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: Re: n_tty.c driver patch (semantic and performance correction) (a ll recent versions)
Message-ID: <20020727232129.GA26742@win.tue.nl>
References: <11E89240C407D311958800A0C9ACF7D13A789A@EXCHANGE> <20020726151723.F19802@flint.arm.linux.org.uk> <200207271507.56873.rwhite@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207271507.56873.rwhite@pobox.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 03:07:56PM -0700, Robert White wrote:

> I agree that that is what that line of the text says, my position is that the 
> entire statement was was written nieavely, and proveably so.  Throughout the 
> entire section the standard (not the linux manual page) discusses "satisfying 
> a read" (singular).  The text was written with an "everybody will know 
> basically what I mean" aditude that leaves it flawed for strict 
> interpretation.  And the linux manual pages still show through enough to use 
> as the bases of my argument.

I followed this discussion with half an eye, and do not really want
to spend the time figuring out what my point of view would be.

But.

In such discussions the Linux man pages carry hardly any weight.
Of interest are the original man pages of the system where the
feature was introduced. And of interest is the original implementation.
And of interest is the POSIX standard.

Sometimes the POSIX author misunderstands something and writes some
silly text into the standard. There are technical committees that
one can approach and try to get a correction. Until such a time,
one should read the POSIX text as written, and not as intended.

Generally, Linux follows POSIX. That is good: since everybody else
also does that, we can exchange programs. Everybody the same silliness
has advantages over each his own correct solution.

Sometimes, when following POSIX is too silly or too painful, Linux
chooses its own way. But in such cases Linux does not follow the Linux
man pages, it is just the other way around. So, I am afraid citing
the Linux man pages will never give you a powerful argument.

Andries
aeb@cwi.nl

[yes, I maintain the man pages; of course they are almost perfect,
since few people have corrections; but corrections are always welcome]
