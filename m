Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbTARFBQ>; Sat, 18 Jan 2003 00:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbTARFBQ>; Sat, 18 Jan 2003 00:01:16 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:40396 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262446AbTARFBO>;
	Sat, 18 Jan 2003 00:01:14 -0500
Date: Sat, 18 Jan 2003 05:10:12 +0000
From: Jamie Lokier <jamie@shareable.org>
To: David Schwartz <davids@webmaster.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented?
Message-ID: <20030118051012.GA18720@bjl1.asuk.net>
References: <20030118043309.GA18658@bjl1.asuk.net> <20030118045719.AAA8414@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030118045719.AAA8414@shell.webmaster.com@whenever>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 	I'm starting to think that one cannot legally use BitKeeper as the 
> preferred means of developing a GPLed program. The problem is, the 
> GPL defines the source as the preferred base to modify the software 
> from and requires you to be able to distribute the source without any 
> additional licensing requirements.

It doesn't require that you distribute the tools for editing the
source, though.  For example I believe it is fine to distribute a
program for Microsoft Visual Studio, in the form of the files you
would actually use with Visual Studio, even though the format of some
of those files is not documented.

> Providing the source in BK form without BK is as useless as
> providing it encrypted. Providing it in any other form does not
> satisfy the GPL (assuming that BK form is in fact the preferred way
> of modifying it).

I disagree, because the BK file format is actually quite well
documented - it is SCCS with some annotations that do not seem
essential if you are using a different tool.

The data is easily extracted using an SCCS-compatible tool.  It is
certainly not encrypted, and I had no difficulty writing a Perl script
to extract any version of the source, although I have yet to look if
changesets are so easy as individual files.

Credit to Larry, for choosing an easily read file format.

(Although not perfectly - see the CSSC documentation for some things
that they are not sure how to decode in an SCCS file - and yes, those
do appear in BK-generated SCCS files from time to time).

> 	If BitKeeper is the version management tool, then BitKeeper is part 
> of the source by this definition.

Linus and other people have said repeatedly that BitKeeper is _not_
essential to working with them on the kernel.

That said, it does seem that if you can't read bkbits.net, then you
are at a disadvantage sometimes.

-- Jamie
