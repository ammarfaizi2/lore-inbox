Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292891AbSCOQxK>; Fri, 15 Mar 2002 11:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292892AbSCOQxA>; Fri, 15 Mar 2002 11:53:00 -0500
Received: from Expansa.sns.it ([192.167.206.189]:62980 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S292891AbSCOQwo>;
	Fri, 15 Mar 2002 11:52:44 -0500
Date: Fri, 15 Mar 2002 17:52:47 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Thunder from the hill <thunder@ngforever.de>
cc: linux-kernel@vger.kernel.org, Martin Eriksson <nitrax@giron.wox.org>
Subject: Re: HPT370 RAID-1 or Software RAID-1, what's "best"?
In-Reply-To: <3C920ABB.6E17E324@ngforever.de>
Message-ID: <Pine.LNX.4.44.0203151716120.30388-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Mar 2002, Thunder from the hill wrote:

> Hi,
>
> Luigi Genoni wrote:
> > HPT370 IDE Raid is not really an hardware raid.
> > It is a software Raid, since Linux does not use tha raid implementation
> > that comes with the BIOS, but it uses softwareraid.
> That doesn't prevent me from saying that real hardware raid might be
> better. But is the thing you wish to say that there's no difference, or
> what?
Hardware RAID is indeed better, but what you get using HPT370 IDE
controlelr is not hardware raid at all. Just read the code of the driver.
You get a software raid, period.
>
> Alan Cox wrote:
> > The raid rebuild time is identical for pretty much any set up. With the
> > softraid its intentionally defaulting to a low fraction of I/O bandwidth
> > so it doesnt disrupt normal operation.
> I experienced it took at about twice the time for a rebuild. I don't
> exactly remember the test results, and they aren't available to me until
> Monday. If you're interested...
> Maybe things have changed a lot since last year, when I did the tests.
>
> > Also as far is his question goes - both are software raid
> See above.
>
> Thunder
> --
> begin-base64 755 -
> IyEgL3Vzci9iaW4vcGVybApteSAgICAgJHNheWluZyA9CSMgVGhlIHNjcmlw
> dCBvbiB0aGUgbGVmdCBpcyB0aGUgcHJvb2YKIk5lbmEgaXN0IGVpbiIgLgkj
> IHRoYXQgaXQgaXNuJ3QgYWxsIHRoZSB3YXkgaXQgc2VlbXMKIiB2ZXJhbHRl
> dGVyICIgLgkjIHRvIGJlIChlc3BlY2lhbGx5IG5vdCB3aXRoIG1lKQoiTkRX
> LVN0YXIuXG4iICA7CiRzYXlpbmcgPX4Kcy9ORFctU3Rhci9rYW5uXAogdW5z
> IHJldHRlbi9nICA7CiRzYXlpbmcgICAgICAgPX4Kcy92ZXJhbHRldGVyL2Rp
> XAplIExpZWJlL2c7CiRzYXlpbmcgPX5zL2Vpbi8KbnVyL2c7JHNheWluZyA9
> fgpzL2lzdC9zYWd0LC9nICA7CiRzYXlpbmc9fnMvXG4vL2cKO3ByaW50Zigk
> c2F5aW5nKQo7cHJpbnRmKCJcbiIpOwo=
> ====
> Extract this and see what will happen if you execute my
> signature. Just save it to file and do a
> > uudecode $file | perl
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

