Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932663AbWBTTwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbWBTTwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbWBTTwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:52:12 -0500
Received: from thunk.org ([69.25.196.29]:15775 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932663AbWBTTwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:52:10 -0500
Date: Mon, 20 Feb 2006 14:51:55 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pavel Machek <pavel@ucw.cz>, Sebastian K?gler <sebas@kde.org>,
       nigel@suspend2.net, Matthias Hensler <matthias@wspse.de>, rjw@sisk.pl,
       kernel list <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220195155.GB7444@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Pavel Machek <pavel@ucw.cz>, Sebastian K?gler <sebas@kde.org>,
	nigel@suspend2.net, Matthias Hensler <matthias@wspse.de>,
	rjw@sisk.pl, kernel list <linux-kernel@vger.kernel.org>,
	suspend2-devel@lists.suspend2.net
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de> <200602201105.35378.sebas@kde.org> <20060220130125.GA17627@elf.ucw.cz> <20060220191242.GB8512@osgiliath.brixandersen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220191242.GB8512@osgiliath.brixandersen.dk>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 08:12:42PM +0100, Henrik Brix Andersen wrote:
> > I'd love to have Nigel helping me and kernel, but he's not
> > interested. He wants suspend2 merged, he does not want better suspend
> > in kernel.
> 
> If you made comments like that about me on a public mailing list I
> would feel it would be very difficult trying to cooperate with you.
> 
> Please reconsider your public replies regarding this already delicate
> issue a bit more before you criticize people who has spent a great
> deal of time trying to get a working solution.

I'm going to have to second Henrik here.  Pavel, there are times when
you are starting to sound almost as strident as our cdrecord "friend".

Maybe you feel you are in a power position because your code happened
to enter the kernel first, so you few you can have veto power over all
other contenders.  It sometimes works that way, but only up to a
point.  The fact of the matter is, Nigel code's *works* and swsusp has
been at best slow and painful and unreliable.  And while your been
complaining about how swsusp2 has been splitting the user community
sounds suspiciously like the NetBSD folks complaining that Linux took
all over their user community -- never mind the fact that their
attitude for a long time was, "if you can't figure out how to
bootstrap NetBSD, you don't DESERVE to run our code"; in contrast, we
worked on making Linux easy to install (the original reason why I
implemented them ramdisk and boot floppy loader code was specifically
to make the user install experience easier).

When users report problems, Nigel tries to help them.  He doesn't say,
"driver problem, not my problem", or "should be done in user space;
why don't you implement it".  Is it any surprise he has a huge user
community?

						- Ted
