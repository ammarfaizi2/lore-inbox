Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284282AbRLRRCa>; Tue, 18 Dec 2001 12:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284258AbRLRRCV>; Tue, 18 Dec 2001 12:02:21 -0500
Received: from mail8.cadvision.com ([207.228.64.93]:23571 "EHLO
	mail8.cadvision.com") by vger.kernel.org with ESMTP
	id <S284282AbRLRRCN>; Tue, 18 Dec 2001 12:02:13 -0500
Message-ID: <004101c187e6$22629b40$0100007f@localdomain.wni.com.wirelessnetworksinc.com>
From: "Herman Oosthuysen" <Herman@WirelessNetworksInc.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1011218085823.10303A-100000@chaos.analogic.com>
Subject: Re: Mounting a in-ROM filesystem efficiently
Date: Tue, 18 Dec 2001 10:05:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: Richard B. Johnson <root@chaos.analogic.com>
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, December 18, 2001 7:00 AM
Subject: Re: Mounting a in-ROM filesystem efficiently


> On Tue, 18 Dec 2001, Helge Hafting wrote:
>
> > "Richard B. Johnson" wrote:
> >
> > >
> > > Security isn't a problem with embedded systems because everything
> > > that could possibly be done is handled with a "monitor". There is
> > > no shell. If there is no way to execute some foreign executable,
> > > you don't have a security issue unless some dumb alleged software
> > > engineer added some back-doors to the monitor.
> >
...
>
>    Embedded systems that perform critical functions such
>    as FMS (Flight Management Systems) have a reset button.
>    If it's screwing up, and they often do, the pilot not
>    flying says some four-letter prayers to be picked up
>    by the cockpit microphone, hits the reset switch, waits
>    for it to re-boot, and enters everything from scratch
>    again --usually the entire day's flight-plan routes,
>    taking nearly 1,000 key-strokes. Now, that's an embedded
>    system.
>
>
> Cheers,
> Dick Johnson
>
> Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).
>  Santa Claus is coming to town...
>           He knows if you've been sleeping,
>              He knows if you're awake;
>           He knows if you've been bad or good,
>              So he must be Attorney General Ashcroft.
>
....
Hmm, there are lots of embedded things with network capabilities.  Think of
wireless access points, network routers and switches.  Even a network
printer can cause network chaos if it would start to chatter on the net.
Many of these things run FTP or HTTP servers for management purposes.

However, figuring out how to hack into a non-standard piece of hardware
using an unknown processor is a non-trivial problem - it is very difficult
even if you designed the thing yourself and has all the info, but could
therefore be done by a disgruntled ex-employee.

Exploiting well known network services  such as FTP and HTTP for dark
purposes certainly should be a serious concern to manufactureres of these
devices.
--
Herman Oosthuysen
Herman@WirelessNetworksInc.com
Suite 300, #3016, 5th Ave NE,
Calgary, Alberta, T2A 6K4, Canada
Phone: (403) 569-5688, Fax: (403) 235-3965


