Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132271AbRBKKrd>; Sun, 11 Feb 2001 05:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132253AbRBKKrO>; Sun, 11 Feb 2001 05:47:14 -0500
Received: from [194.213.32.137] ([194.213.32.137]:12036 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132251AbRBKKq7>;
	Sun, 11 Feb 2001 05:46:59 -0500
Message-ID: <20010210225851.G7877@bug.ucw.cz>
Date: Sat, 10 Feb 2001 22:58:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <andrewm@uow.edu.au>, Hacksaw <hacksaw@hacksaw.org>
Cc: Tom Eastep <teastep@seattlefirewall.dyndns.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <Pine.LNX.4.30.0102040908320.877-100000@wookie.seattlefirewall.dyndns.org> <200102041804.f14I4br22433@habitrail.home.fools-errant.com> <3A7EA9B3.3507DC8D@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A7EA9B3.3507DC8D@uow.edu.au>; from Andrew Morton on Tue, Feb 06, 2001 at 12:25:07AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >I've discovered that heavy use of vesafb can be a major source of clock
> > >drift on my system, especially if I don't specify "ypan" or "ywrap". On my
> > 
> > This is extremely interesting. What version of ntp are you using?
> 
> Is vesafb one of the drivers which blocks interrupts for (many) tens
> of milliseconds?

Vesafb is happy to block interrupts for half a second.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
