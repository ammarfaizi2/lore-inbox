Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130742AbRCIXCY>; Fri, 9 Mar 2001 18:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130745AbRCIXCO>; Fri, 9 Mar 2001 18:02:14 -0500
Received: from hall.mail.mindspring.net ([207.69.200.60]:25148 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S130742AbRCIXBy>; Fri, 9 Mar 2001 18:01:54 -0500
Message-ID: <002101c0a8ec$af793b80$305079a5@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Dennis Noordsij" <dennis.noordsij@wiral.com>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E14bUio-0005ls-00@the-village.bc.nu>
Subject: Re: APM battery status reporting
Date: Fri, 9 Mar 2001 18:00:05 -0500
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

> > tested in previous kernels. Then again my dmesg says the BIOS is
probably
> > buggy (same BIOS though as mentioned in those posts). Apmd does notice
the
> > change from mains to battery and vice versa (I have disabled Speedstep
so now
> > everything actually survives this transition :-).
> > So to end all the confusion, is there a patch out there that enables
battery
> > status reporting for me (and other Dell owners :-) ?
>
> Yes but the update you need is a new BIOS revision. Ask Dell
>

The BIOS update has been around forever from Compal (the people who actually
OEM the unit for Dell), you can get their generic BIOS at
http://software.tuxtops.com. This probably violates your Dell warranty but I
know many who use it and we've now installed it on all the 5000e systems we
own, without any problem.

I'm not sure why Dell is taking so long to get an update to it consumers,
but it probably has something to do with the fact that Linux isn't a
supported platform on this machine.  Their official stance appears to be
"APM isn't supported on this laptop, only ACPI."  That's pretty bogus since
everything but this one system call works, and even that works with the
Compal generic BIOS, so I'd more likely guess it's just not high on the
priority list because it's not important enough for their largest user base
which is of course Windows.

Later,
Tom


