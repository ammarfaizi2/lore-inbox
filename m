Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145367AbRA2G10>; Mon, 29 Jan 2001 01:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145383AbRA2G1H>; Mon, 29 Jan 2001 01:27:07 -0500
Received: from grunt.okdirect.com ([209.54.94.12]:28174 "HELO mail.pyxos.com")
	by vger.kernel.org with SMTP id <S145367AbRA2G1F>;
	Mon, 29 Jan 2001 01:27:05 -0500
Message-Id: <5.0.2.1.2.20010129002217.03362fe0@209.54.94.12>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 29 Jan 2001 00:27:47 -0600
To: whitney@math.berkeley.edu, linux-kernel@vger.kernel.org
From: Daniel Walton <zwwe@opti.cgi.net>
Subject: Re: 2.4.0 Networking oddity
In-Reply-To: <200101290314.f0T3E0601647@adsl-209-76-109-63.dsl.snfc21.pa
 cbell.net>
In-Reply-To: <5.0.2.1.2.20010128140720.03465e38@209.54.94.12>
 <5.0.2.1.2.20010128140720.03465e38@209.54.94.12>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The server in question is running the tulip driver.  dmesg reports:

Linux Tulip driver version 0.9.13 (January 2, 2001)

I have seen this same behavior on a couple of my servers running 3com 
3c905c adaptors as well.

The last time I was experiencing it I rebooted the system and it didn't 
solve the problem.  When it came up it was still lagging.  This would lead 
me to believe that it is caused by some sort of network condition, but what 
I don't know.

If anyone has ideas, I'd be more than happy to run tests/provide more info..

-Dan



At 10:14 PM 1/28/2001 -0500, you wrote:
>In mailing-lists.linux-kernel, you wrote:
>
> >I am running a web server under the new 2.4.0 kernel and am experiencing
> >some intermittent odd behavior from the kernel.  The machine will sometimes
> >go through cycles where network response becomes slow even though top
> >reports over 60% idle CPU time.   When this is happening ping goes from
> >reasonable response times to response times of several seconds in cycles of
> >about 15 to 20 seconds.
>
>FWIW, I have seen behaviour like this under kernel 2.2.x and 2.4.x,
>for me taking the interface down and then bringing it back up usually
>makes the problem stop, at least for the moment.
>
>I have always assumed that it is caused by a bug in the Ethernet card
>driver, as the first time I noticed this behaviour, I was using the
>Realtek 8139 driver about two years ago, it was really not good
>hardware and the driver was pretty new.  Anyway, it would do this, so
>I contacted Donald Becker about it, he pointed me to a newer version
>of the driver that did it _much_ less often.
>
>Cheers,
>Wayne

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
