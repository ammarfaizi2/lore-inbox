Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133035AbRAQRUl>; Wed, 17 Jan 2001 12:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133023AbRAQRUW>; Wed, 17 Jan 2001 12:20:22 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:12303 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S131795AbRAQRUN>; Wed, 17 Jan 2001 12:20:13 -0500
Date: Wed, 17 Jan 2001 12:22:34 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010117122234.A3480@munchkin.spectacle-pond.org>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1> <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com> <20010116153757.A1609@munchkin.spectacle-pond.org> <20010117003205.A711@werewolf.able.es> <20010116194210.C1609@munchkin.spectacle-pond.org> <20010116201401.C6364@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010116201401.C6364@cadcamlab.org>; from peter@cadcamlab.org on Tue, Jan 16, 2001 at 08:14:01PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 08:14:01PM -0600, Peter Samuelson wrote:
> 
> [Michael Meissner]
> > Ummm, I just reread the 2.4 Changes file once again just to be sure,
> > and it did not cover this issue.  So how the *$@% are people supposed
> > to "read some docs" to know about this, if the docs don't mention the
> > information.  I know people have been complaining about this change
> > since at least the fall time frame.
> 
> SCSI host probe order has never been guaranteed, afaik -- this is not
> new to 2.4.  If you have multiple host adapters, you really need to use
> the command line to say which is which, as always.  If you don't, you
> will be bitten eventually.
> 
> "Eventually" in this case meant 2.2->2.4, perhaps, but that doesn't
> make it an item for Documentation/Changes.  Or is this not what you
> were talking about?

What I'm talking about is that whenever you have these flag day(*) type of
operations, is weakens the whole Linux movement.  Yes, each individual change
might mean a few minutes to half an hour of a persons time, but cumulatively it
just sends the signal that Linux is just a hackers toy.  If people can't easily
switch between kernels for instance due to the wrong disk being listed as the
boot disk, or they have to replug which ethernet controller gets which cord, it
will mean fewer people testing new kernels for instance.

* http://www.tuxedo.org/~esr/jargon/html/entry/flag-day.html

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
