Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132115AbRATTzY>; Sat, 20 Jan 2001 14:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132219AbRATTzM>; Sat, 20 Jan 2001 14:55:12 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:10770 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132147AbRATTyz>; Sat, 20 Jan 2001 14:54:55 -0500
Date: 20 Jan 2001 17:36:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <7uDh9tbHw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.10.10101181120070.18387-100000@penguin.transmeta.com>
Subject: Re: Is sendfile all that sexy?
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.10.10101181120070.18387-100000@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 18.01.01 in <Pine.LNX.4.10.10101181120070.18387-100000@penguin.transmeta.com>:

> (Short and sweet: most hogh-performance people want point-to-point serial
> line IO with no hops, because it's a known art to make that go fast.  No
> general-case routing in hardware - if you want to go as fast as the
> devices and the link can go, you just don't have time to route. Trying to
> support device->device transfers easily slows down the _common_ case,
> which is why I personally doubt it will even be supported 10-15 years from
> now. Better hardware does NOT mean "more features").

Well, maybe.

Then again, I could easily see those I/O devices go the general embedded  
route, which in a decade or two could well mean they run some sort of  
embedded Linux on the controller.

Which would make some features rather easy to implement.

(Think about it: twenty years from mow, a typical desktop machine may be a  
heterogenous Linux cluster. Didn't someone say something about World  
Domination?)

(Note that I predicted this 2001-01-20T16:35:30. Just in case it actually  
works out that way.)

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
