Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRCASxr>; Thu, 1 Mar 2001 13:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129791AbRCASx2>; Thu, 1 Mar 2001 13:53:28 -0500
Received: from m596-mp1-cvx1c.col.ntl.com ([213.104.78.84]:10756 "EHLO
	[213.104.78.84]") by vger.kernel.org with ESMTP id <S129781AbRCASxM>;
	Thu, 1 Mar 2001 13:53:12 -0500
To: Michael Johnson <johnsom@home.com>
Cc: Jens Axboe <axboe@suse.de>, <Andries.Brouwer@cwi.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-cd for 2.4.1 are broken?
In-Reply-To: <001801c09e3a$4a189270$653b090a@sulaco>
From: John Fremlin <chief@bandits.org>
Date: 01 Mar 2001 18:52:24 +0000
In-Reply-To: "Michael Johnson"'s message of "Sat, 24 Feb 2001 00:17:54 -0800"
Message-ID: <m27l29tj87.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Johnson" <johnsom@home.com> writes:

> >> You know all about this stuff, so probably I am mistaken.
> >> However, my copy of SFF8020-r2.6 everywhere has
> >> "Sense 02 ASC 3A: Medium not present" without giving
> >> subcodes to distinguish Tray Open from No Disc.
> >> So, it seems to me that drives built to this spec will not have
> >> nonzero ASCQ.
> >
> >Right, old ATAPI has 3a/02 as the only possible condition, so we
> >can't really tell between no disc and tray open. I guess the safest
> >is to just keep the old behaviour for !ascq and report open.

> I don't understand why the current(2.4.1) behavior is a problem...

It isn't a problem, it just changed in the middle of a stable release.

[...]

-- 

	http://www.penguinpowered.com/~vii
