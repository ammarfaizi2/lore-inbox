Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261589AbREOVki>; Tue, 15 May 2001 17:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbREOVk2>; Tue, 15 May 2001 17:40:28 -0400
Received: from [195.63.194.11] ([195.63.194.11]:64268 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S261589AbREOVkO>; Tue, 15 May 2001 17:40:14 -0400
Message-ID: <3B01A201.20D7ECD9@evision-ventures.com>
Date: Tue, 15 May 2001 23:39:13 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: James Simmons <jsimmons@transvirtual.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105151043360.2112-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> and then use
> 
>         fd = open("/dev/fd0/colourspace", O_RDWR);

> This, btw, is Al Viro's wet dream. But I have to agree: using name spaces
> etc is MUCH preferable to ioctl's, makes code more readable and logical,
> and often makes it possible to do things you couldn't sanely do before
> (control these things from scripts etc).
> 
> And using ASCII names ("eject") instead of numbers (see the "FDEJECT" and
> "CDROMEJECT" etc #defines) sure as hell makes for easier maintenance and
> avoids the whole issue of maintaining static numbers (all the same things
> that make me hate device number maintenance makes me also hate the fact
> that we need to maintain this list of ioctl numbers etc). By using
> descriptive names, the "maintenance" simple does not exist.


Blah blah blah.... Now we have just one ugly cluttered undocumented
(please insert the list of you favourite invictions here) /proc.
This way we would have TONS of them.
