Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRDEXzT>; Thu, 5 Apr 2001 19:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129679AbRDEXzJ>; Thu, 5 Apr 2001 19:55:09 -0400
Received: from [63.109.146.2] ([63.109.146.2]:35322 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S129669AbRDEXyu>;
	Thu, 5 Apr 2001 19:54:50 -0400
Message-ID: <B65FF72654C9F944A02CF9CC22034CE22E1B74@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Timothy D. Witham'" <wookie@osdlab.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RE: a quest for a better scheduler
Date: Thu, 5 Apr 2001 16:53:27 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy D. Witham wrote :
[...] 
> I propose that we work on setting up a straight forward test harness 
> that allows developers to quickly test a kernel patch against 
> various performance yardsticks.

[...
(proposed large server testbeds)
...]

I like this idea, but could the testbeds also include some 
resource-constrained "embedded" or appliance-style systems, and
include performance yardsticks for latency and responsiveness?

It would be unfortunate if work on a revised scheduler resulted
in Linux being a monster web server on 4-way systems, but having
lousy interactive performance on web pads, hand helds, and set top
boxes.  

How about a 120Mhz Pentium with 32MB of RAM and a flash disk, a 200 
Mhz PowerPC with 64 MB?  Maybe a Transmeta web pad?  

For the process load, something that tests responsiveness and 
latency - how about a set of processes doing multicast network 
transfers, CPU-intensive MPEG video and audio encode / decode,
and a test app that measures "user response", i.e. if X Windows 
was running, would the mouse pointer move smoothly or jerkily?

The "better" scheduler for these applications would make sure that 
multicast packets were never dropped, the MPEG decode never dropped 
frames, and the "user interface" stayed responsive, etc.

Also, I would not mind a bit if the kernel had tuning options, either 
in configuration or through /proc to adjust for these very different
situations.

Torrey Hoffman
Torrey.Hoffman@myrio.com

