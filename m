Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132196AbRBKK5E>; Sun, 11 Feb 2001 05:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129251AbRBKK4y>; Sun, 11 Feb 2001 05:56:54 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:45033 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129218AbRBKK4l>; Sun, 11 Feb 2001 05:56:41 -0500
Message-ID: <3A8671FF.C390FDCC@uow.edu.au>
Date: Sun, 11 Feb 2001 22:05:35 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Hacksaw <hacksaw@hacksaw.org>,
        Tom Eastep <teastep@seattlefirewall.dyndns.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <Pine.LNX.4.30.0102040908320.877-100000@wookie.seattlefirewall.dyndns.org> <200102041804.f14I4br22433@habitrail.home.fools-errant.com> <3A7EA9B3.3507DC8D@uow.edu.au>,
		<3A7EA9B3.3507DC8D@uow.edu.au>; from Andrew Morton on Tue, Feb 06, 2001 at 12:25:07AM +1100 <20010210225851.G7877@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > > >I've discovered that heavy use of vesafb can be a major source of clock
> > > >drift on my system, especially if I don't specify "ypan" or "ywrap". On my
> > >
> > > This is extremely interesting. What version of ntp are you using?
> >
> > Is vesafb one of the drivers which blocks interrupts for (many) tens
> > of milliseconds?
> 
> Vesafb is happy to block interrupts for half a second.

And has this been observed to cause clock drift?

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
