Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262848AbRE0SJ4>; Sun, 27 May 2001 14:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262852AbRE0SJq>; Sun, 27 May 2001 14:09:46 -0400
Received: from server1.cosmoslink.net ([208.179.167.101]:13893 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S262848AbRE0SJh>; Sun, 27 May 2001 14:09:37 -0400
Message-ID: <00c701c0e6d8$2b28ea40$4aa6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: <stepken@little-idiot.de>, <linux-kernel@vger.kernel.org>,
        "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <01052622193100.01317@linux.zuhause.de> <00a101c0e642$4f0791a0$52a6b3d0@Toshiba> <20010527224045.B3556@metastasis.f00f.org>
Subject: Re: IDE Performance lack !
Date: Sun, 27 May 2001 11:09:25 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chris Wedgwood" <cw@f00f.org> wrote:

> On Sat, May 26, 2001 at 05:16:42PM -0700, Jaswinder Singh wrote:
>
>     When ever i copy big data (around 400 to 700 MB ) from one
>     partion to another my machine do not response at all (i can not
>     work on another shell) during data transfer.
>
> Both paritions on the same spindle? That's going to suck no matter
> what you do...

I am having only one harddisk of 20 Gb , so i made four partitions on it.

> but it shouldn't be as bad as you describe.

But it is more bad then i described , especially when i do telnet/ssh from
my home .

I am not able to understand why Linux read and/or write harddisk after some
time (after few hours ) , harddisk read/write leds keep on glowing for few
minutes , even though nobody working on it and machine is in idle state.

>Have you tried 2.2.x ?
>

yes i am taking about 2.2.12 .

And in my 2.4.2 :-

Harddisk read-write problem is also there , during harddisk read-write
activity i took two hdparams and i got :-
i . 963.76 kB/sec
ii. 1.05 MB/sec

and when my machine becomes normal i got :-

9.07 MB/sec

and after hdparam -d1 i got :-

9.55 MB/sec

But my problem is why linux boxes do not response for few seconds
(sometimes) and especially during telnet/ssh it looks more worst and looks
similar to Microsoft Windows :(

there is problem in scheduling or what ?

Thank you,

Best Regards,

Jaswinder.
--
These are my opinions not 3Di.



