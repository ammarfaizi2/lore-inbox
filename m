Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271507AbRHXNfG>; Fri, 24 Aug 2001 09:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271520AbRHXNe4>; Fri, 24 Aug 2001 09:34:56 -0400
Received: from smtp.guardiandigital.com ([209.11.107.5]:4364 "HELO
	juggernaut.guardiandigital.com") by vger.kernel.org with SMTP
	id <S271507AbRHXNet>; Fri, 24 Aug 2001 09:34:49 -0400
Date: Fri, 24 Aug 2001 09:35:04 -0400 (EDT)
From: "Ryan W. Maple" <ryan@guardiandigital.com>
To: Denis Perchine <dyp@perchine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
In-Reply-To: <20010824020119.42D951FD7D@mx.webmailstation.com>
X-Base: ALL YOUR BASE ARE BELONG TO US. (http://www.scene.org/redhound/AYB.swf)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <20010824133505.B78EB11D303@juggernaut.guardiandigital.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Aug 2001, Denis Perchine wrote:

> On Friday 24 August 2001 02:41, Tom Rini wrote:
> > On Thu, Aug 23, 2001 at 09:26:33PM +0200, Jes Sorensen wrote:
> > > >>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:
> > You've said this before. :)  Just how small of an 'embedded' system are
> > you talking about?  I know of people who do compile a kernel now and
> > again on a 'small' system, for fun.  On a larger (cPCI) system, I
> > don't see your point.  If you can somehow transport the 21mb[1] bzip2
> > kernel source to your system, you can transport python.  If you're
> > porting to a brand new arch, there's still good tests before you
> > have shlib support (You've mentioned that before too I think).
> 
> There is another point why having Python installed is a problem. Usually when 
> you install a server you remove everything from it because of space, and 
> security reasons. The main security concern is the less is installed the 
> better security is. I always remove python from any servers I have. As I 
> remove guile, forth, and other useless (in terms of server) languages. Now 
> you tell me that I should have this bloat installed just to configure my 
> kernel. Do not you think that it is too much? Current kernel does not require 
> anything like this.

Personally, I'm on the "against Python" side of the argument, but I don't
think that this argument will hold up for very long.  I also remove just
about everything from a newly installed system _including_ compilers and
all devel tools.  Thus, I can't even compile a kernel on a "production"
box let alone configure it.

I build it on another box and either a) package it or b) tar it up for
"installation" on the target machine.

So this argument will not hold up very long, and I fear the Python
dependancy will be here to stay.  I'm just about over it. :)

Cheers,
Ryan

