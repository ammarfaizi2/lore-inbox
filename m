Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261611AbSJFNmy>; Sun, 6 Oct 2002 09:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261612AbSJFNmy>; Sun, 6 Oct 2002 09:42:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11527 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261611AbSJFNmw>; Sun, 6 Oct 2002 09:42:52 -0400
Date: Sun, 6 Oct 2002 14:48:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>, Ulrich Drepper <drepper@redhat.com>,
       bcollins@debian.org, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BK MetaData License Problem?
Message-ID: <20021006144821.B31147@flint.arm.linux.org.uk>
References: <20021006.035934.106436540.davem@redhat.com> <Pine.LNX.4.44.0210061324500.4303-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210061324500.4303-100000@localhost.localdomain>; from mingo@elte.hu on Sun, Oct 06, 2002 at 02:04:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 02:04:42PM +0200, Ingo Molnar wrote:
> the BKL.txt license currently says:
> 
>                              By transmitting the Metadata
>      to an Open Logging server, You hereby grant BitMover,
>      or any other operator of an Open Logging server, per-
>      mission  to  republish  the Metadata sent by the Bit-
>      Keeper Software to the Open Logging server.

IANAL, but this is just to protect BitMover against _you_ suing them for
publishing your log entries.  Completely sensible.  They're not claiming
copyright over the metadata.  They're not claiming any license over the
metadata.

> what i'm worried about is the following issue: by default the data and the
> MetaData is owned by whoever created it. You, me, other kernel developers.
> We GPL the code, but the metadata is not automatically GPL-ed, just like
> writing a book about the Linux kernel is is not necesserily GPL-ed.

It doesn't say "you transfer all your IP and soul to bitmover."

> it would be better if the license also said:
> 
> 	By transmitting the MetaData to an Open Logging server, You 
>         hereby also agree to license the MetaData under the same license
>         you license the data it describes.
> 
> (or something to that extent - i'm not a lawyer.)

That doesn't explicitly allow bitmover to put the metadata up in public
view, which would mean the openlogging stuff will leave bitmover wide
open for legal action.

> btw., this is also the case with the emails Linus puts into BK commit info
> - the email someone sends to Linus is _not_ GPL-ed by default.
> 
> (perhaps the solution is simple - i'd be really happy if it was.)

The exact same problem applies to pre-BK Linus and Alan, and whoever
else produces a change log that contains information produced by a
third party.

Does Linus and Alan have an implicit right to republish the documentation
that was sent to them with the patch?  Does Red Hat have the right to
republish comments placed into the bugzilla database by external users
of that service?  Does Debian have a right to reproduce emails on their
website which have been sent to foo@bugs.debian.org (or whatever the
address is?)

There is a _big_ question about reproducing peoples personal information
in the EU (eg, email addresses) on web sites, even archives of public
mailing lists.  The exim mailing lists were recently threatened with
legal action over this very point, and there was talk at one point about
having to shut down the whole exim.org site because of this.  The end
result of this debarcle was various posts were deleted from the list
archive.

So, this isn't a BK problem.  Its a community problem.

Please don't shovel shit into other peoples back yards.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

