Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbSLQTwA>; Tue, 17 Dec 2002 14:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbSLQTwA>; Tue, 17 Dec 2002 14:52:00 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:48354 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S266686AbSLQTv6>; Tue, 17 Dec 2002 14:51:58 -0500
Message-Id: <5.1.0.14.2.20021217115447.04860be0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 17 Dec 2002 11:59:48 -0800
To: Colin Paul Adams <colin@colina.demon.co.uk>, linux-kernel@vger.kernel.org
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Alcatel speedtouch USB driver and SMP.
In-Reply-To: <m3adj6gwus.fsf@colina.demon.co.uk>
References: <20021216051300.GB12884@kroah.com>
 <m3n0n7hi52.fsf@colina.demon.co.uk>
 <20021215075913.GB2180@kroah.com>
 <m3hedfhd5l.fsf@colina.demon.co.uk>
 <20021216051300.GB12884@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:02 AM 12/16/2002 +0000, Colin Paul Adams wrote:
>>>>>> "Greg" == Greg KH <greg@kroah.com> writes:
>    >>  drivers/usb/misc/speedtouch.c
>
>    Greg> Ah good, you're using one that the source is available for
>    Greg> :) I think the developer has said it will work on SMP
>    Greg> machines, but what problems are you having, and have you
>    Greg> asked the author of the code?
>
>I haven't any problems yet, as I haven't bought the modem yet. I don't
>want to if it is going to give me problems.
>
>The 1.4 version of the driver (before integration into 2.5 series
>kernel), is supposed to not work with SMP kernels (that's why I asked
>in the first place). So I contacted the author (Johan Verrept) to ask on the status,
>and he said he thought it was probably OK now, as it was in the 2.5
>kernel.
>
>So I grabbed the 2.5.51 sources and looked at the see, and could see
>no mention of a change to fix SMP. So I then contacted Richard Purdie,
>who was the last person to make a change to the source. He said he
>didn't know.
>
>So, is anyone using it on SMP?
I was, until I got Bluetooth DSL access point :).

I used to have PPPoE setup with Speedtouch modem on my Dual Athlon box. It was running 
2.4.18 at that time. Most of the SMP problems were in the ATM code. I fixed some of them 
and my patches went into 2.4.19. I did some hack to the driver itself but those
were minor.

Max

