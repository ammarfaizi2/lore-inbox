Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131156AbRAQCOk>; Tue, 16 Jan 2001 21:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131136AbRAQCOV>; Tue, 16 Jan 2001 21:14:21 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:3852 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130575AbRAQCOJ>; Tue, 16 Jan 2001 21:14:09 -0500
Date: Tue, 16 Jan 2001 20:14:01 -0600
To: Michael Meissner <meissner@spectacle-pond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010116201401.C6364@cadcamlab.org>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1> <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com> <20010116153757.A1609@munchkin.spectacle-pond.org> <20010117003205.A711@werewolf.able.es> <20010116194210.C1609@munchkin.spectacle-pond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010116194210.C1609@munchkin.spectacle-pond.org>; from meissner@spectacle-pond.org on Tue, Jan 16, 2001 at 07:42:10PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Michael Meissner]
> Ummm, I just reread the 2.4 Changes file once again just to be sure,
> and it did not cover this issue.  So how the *$@% are people supposed
> to "read some docs" to know about this, if the docs don't mention the
> information.  I know people have been complaining about this change
> since at least the fall time frame.

SCSI host probe order has never been guaranteed, afaik -- this is not
new to 2.4.  If you have multiple host adapters, you really need to use
the command line to say which is which, as always.  If you don't, you
will be bitten eventually.

"Eventually" in this case meant 2.2->2.4, perhaps, but that doesn't
make it an item for Documentation/Changes.  Or is this not what you
were talking about?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
