Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130844AbRA2OmA>; Mon, 29 Jan 2001 09:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131378AbRA2Olw>; Mon, 29 Jan 2001 09:41:52 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130844AbRA2Oll>;
	Mon, 29 Jan 2001 09:41:41 -0500
Message-ID: <20010128225530.A1300@bug.ucw.cz>
Date: Sun, 28 Jan 2001 22:55:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: jamal <hadi@cyberus.ca>, Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: ECN: Clearing the air
In-Reply-To: <20010128150813.A1595@metastasis.f00f.org> <Pine.GSO.4.30.0101272110470.24762-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.GSO.4.30.0101272110470.24762-100000@shell.cyberus.ca>; from jamal on Sat, Jan 27, 2001 at 09:15:48PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >     suggested blocking ECN. Article at:
> >
> >     http://www.securityfocus.com/frames/?focus=ids&content=/focus/ids/articles/portscan.html
> >
> > the site is now ATM -- can someone briefly explain the logic in
> > blocking it?
> 
> It is Queso they quoted not nmap, sorry -- same thing.
> The idea is to "detect" port scanners.
> Queso sets the two TCP reserved bits in the SYN (now allocated for ECN).
> Some OSes reflect that back in the SYN-ACK (Linux < 2.0.2? for example
> was such a culprit).

Does not that mean that Linux 2.0.10 mistakenly announces it is ECN
capable when offered ECN connection?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
