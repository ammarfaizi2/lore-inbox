Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTLWR42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTLWR42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:56:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262055AbTLWR4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:56:25 -0500
Date: Tue, 23 Dec 2003 09:56:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mitchell Blank Jr <mitch@sfgoth.com>
cc: "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Eric S. Raymond" <esr@thyrsus.com>, Jonathan Magid <jem@ibiblio.org>,
       "H. J. Lu" <hjl@lucon.org>, "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: SCO's infringing files list
In-Reply-To: <20031223174454.GD45620@gaz.sfgoth.com>
Message-ID: <Pine.LNX.4.58.0312230946010.14184@home.osdl.org>
References: <1072125736.1286.170.camel@duergar> <200312221519.04677.tcfelker@mtco.com>
 <Pine.LNX.4.58.0312221337010.6868@home.osdl.org> <20031223002641.GD28269@pegasys.ws>
 <20031223092847.GA3169@deneb.enyo.de> <3FE811E3.6010708@debian.org>
 <Pine.LNX.4.58.0312230317450.12483@home.osdl.org> <3FE862E7.1@pixelized.ch>
 <20031223160425.GB45620@gaz.sfgoth.com> <20031223174454.GD45620@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Dec 2003, Mitchell Blank Jr wrote:
>
> (Replying to myself again)
> 
> > Now, does anyone have a copy of "0.96bp2inc.tar.Z" lying around?
> 
> BTW, a few more details on this file - the linux GCC 2.2.2 release was
> originally announced 28-Jun-1992.  The 0.96bp2inc.tar.Z file originally
> lived on the then-primary linux ftp site banjo.concert.net in directory
> pub/Linux/GCC.

Note that we really don't care about that "0.96bp2inc.tar.Z" file: that's 
just the kernel headers, and 0.96b-pl2 did _not_ contain the comments yet. 
But libc used to use the kernel headers for other things (for things like 
system call numbers etc).

It's almost certainly the "libc-2.2.2.tar.Z" file that we want - that's 
the one that is going to contain the sys_errlist[] lists etc. Note how 
this libc-2.2.2 announcement predates the merging of the kernel header by 
almost a month - the kernel header information came from libc, not the 
other way around.

> banjo stopped being an FTP server a couple months later - however,
> Jonathan Magid announced on 13-Aug-1992 that the entire banjo site
> was being reincarnated at host reggae.oit.unc.edu in directory
> ftp/pub/pc-stuff/Linux.  Here's a copy of the announcement:
>   http://www.kclug.org/old_archives/linux-activists/1992/aug/1/0708.shtml

Does anybody have old CD-ROM's lying around?

In particular, the Yggdrasil Linux/GNU/X alpha CD-ROM was apparently
released just a few months later. It would quite possibly contain the
libc-2.2.2 sources... Adam Richter is still active, and I added him to the
cc..

Who else was doing CD's back then? SLS? If nobody has the thing on a
web-site any more, maybe they exist in physical format on somebodys
bookshelf? The only reason that the really historic kernel archives still
exist is that people saved them, and even so we're missing versions 0.02
and 0.03, but by the latter half of -92 there were already CD-ROMs being 
manufactured...

Of course, maybe the CD's are unreadable by now.

			Linus
