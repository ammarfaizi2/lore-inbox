Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262152AbRENPx3>; Mon, 14 May 2001 11:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262162AbRENPxU>; Mon, 14 May 2001 11:53:20 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:44037 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S262152AbRENPxD>; Mon, 14 May 2001 11:53:03 -0400
Date: Mon, 14 May 2001 11:33:45 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: John Kodis <kodis@mail630.gsfc.nasa.gov>, linux-kernel@vger.kernel.org
Subject: Re: Not a typewriterg
Message-ID: <20010514113345.B10909@munchkin.spectacle-pond.org>
In-Reply-To: <mharris@opensourceadvocate.org> <200105140103.f4E13U3r010249@sleipnir.valparaiso.cl> <20010514103148.B9532@tux.gsfc.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010514103148.B9532@tux.gsfc.nasa.gov>; from kodis@mail630.gsfc.nasa.gov on Mon, May 14, 2001 at 10:31:48AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 10:31:48AM -0400, John Kodis wrote:
> On Sun, May 13, 2001 at 09:03:30PM -0400, Horst von Brand wrote:
> 
> > The old C compiler/old Unix linker guaranteed 6 chars in an external symbol
> > name only, and C functions got an underscore prepended: _creat. I guess
> > this is the reason for this wart. As to why 6 chars only, I'd guess some
> > data structure in the linker was laid out that way. Machines had a few
> > dozen Kbs of RAM then, space was precious.
> 
> I recall that RSX-11 and a few other series of early DEC operating
> systems stored linker symbols in a "RAD50" encoding scheme which
> allowed 6 chararacters to be crammed into a 32-bit "long word".  I
> suspect that this is where the limitation originated.

More trivia.  Rad50 actually allows 5 characters per 32-bit word.  The 50 is
actually 050 in octal (ie, 40 decimal), and allows you to have all 26 english
letters, 10 digits, a null, and 3 characters.  At this stage, I don't remember
what the precise encoding is, or what the additional 3 characters were (I
suspect different systems used different characters).  One of the first systems
I worked on professionally (Data General RDOS) used RAD50 in their object file
format.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
