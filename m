Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131986AbRA2Sw2>; Mon, 29 Jan 2001 13:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131566AbRA2SwS>; Mon, 29 Jan 2001 13:52:18 -0500
Received: from foobar.napster.com ([64.124.41.10]:19210 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S131986AbRA2SwH>; Mon, 29 Jan 2001 13:52:07 -0500
Message-ID: <3A75BBB2.63CE124C@napster.com>
Date: Mon, 29 Jan 2001 10:51:30 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walton <zwwe@opti.cgi.net>
CC: whitney@math.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 Networking oddity
In-Reply-To: <5.0.2.1.2.20010128140720.03465e38@209.54.94.12>
	 <5.0.2.1.2.20010128140720.03465e38@209.54.94.12> <5.0.2.1.2.20010129002217.03362fe0@209.54.94.12>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walton wrote:
> 
> The server in question is running the tulip driver.  dmesg reports:
> 
> Linux Tulip driver version 0.9.13 (January 2, 2001)
> 
> I have seen this same behavior on a couple of my servers running 3com
> 3c905c adaptors as well.
> 
> The last time I was experiencing it I rebooted the system and it didn't
> solve the problem.  When it came up it was still lagging.  This would lead
> me to believe that it is caused by some sort of network condition, but what
> I don't know.
> 
> If anyone has ideas, I'd be more than happy to run tests/provide more info..
> 

If you are running an intelligent switch, double check to make sure your
duplex and speed match what the switch sees on it's port. The biggest
problem I've had with any of my machines is autonegotiation of port
speed and duplex. Typically all that is required is that I force speed
and duplex on the Linux end.


Jordan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
