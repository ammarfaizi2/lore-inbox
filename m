Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSJaRaE>; Thu, 31 Oct 2002 12:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262878AbSJaRaE>; Thu, 31 Oct 2002 12:30:04 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:52199 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262824AbSJaRaC>; Thu, 31 Oct 2002 12:30:02 -0500
Date: Thu, 31 Oct 2002 10:36:15 -0700
Message-Id: <200210311736.g9VHaF820663@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Stephen Wille Padnos <stephen.willepadnos@verizon.net>,
       Dax Kelson <dax@gurulabs.com>, Chris Wedgwood <cw@f00f.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
In-Reply-To: <Pine.GSO.4.21.0210311126450.16688-100000@weyl.math.psu.edu>
References: <3DC15931.9030601@verizon.net>
	<Pine.GSO.4.21.0210311126450.16688-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> On Thu, 31 Oct 2002, Stephen Wille Padnos wrote:
> 
> > >Then give them all the same account and be done with that.  Effect will
> > >be the same.
> > 
> > Unless I'm missing something, that only works if all the users need 
> > *exactly* the same permissions to all files, which isn't a good assumption.
> 
> That's the point.  In practice shared writable access to a directory
> can be easily elevated to full control of each others' accounts,
         ^^^^^^
While that may be true in theory, in practice it's not necessarily the
case. Many people don't have the expertise to make use of such
exploits. And before you say that they can download a pre-cooked
exploit kit, let me tell you that there are plenty of people who don't
have the time or inclination to do that.

I've seen you talk about these kinds of things before, and you always
seem to be talking about the typical nightmarish undergrad CS lab
where the kids spend all their time trying to crack each other and the
system. And I'm not saying that these don't exist: I've seen it.

But there are other environments (say a research lab with grad
students, post-docs and faculty) where the inhabitants either don't
have the skills or don't have the interest in cracking accounts.
Everyone is too busy doing their own research. Cracking the mysteries
of the universe seems to be more interesting.

So group write access and ACL's *can* lead to wanton cracking, but for
many environments it's not an issue. For many, the dangers lie outside
the firewall, not inside.

Note that I'm not specifically advocating ACL's, I'm just letting you
know that the problem you're concerned about is, for good reason, not
a problem for everyone.

I will note that one appealing aspect of ACL's is that they do not
require administrator intervention. That's good for a user who just
wants to set something up without having to wait for the sysadmin.
It's also good for the sysadmin (excepting control freaks) who doesn't
want to do things that the users can (or should) actually be doing by
themselves.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
