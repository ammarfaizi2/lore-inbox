Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288117AbSAXOnL>; Thu, 24 Jan 2002 09:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288127AbSAXOlx>; Thu, 24 Jan 2002 09:41:53 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:17027 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S288117AbSAXOll>; Thu, 24 Jan 2002 09:41:41 -0500
Message-ID: <007801c1a4e4$ee428480$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Daniel Nofftz" <nofftz@castor.uni-trier.de>
Cc: "Ed Sweetman" <ed.sweetman@wmich.edu>, "Vojtech Pavlik" <vojtech@suse.cz>,
        "Timothy Covell" <timothy.covell@ashavan.org>,
        "Dieter N?tzel" <Dieter.Nuetzel@hamburg.de>,
        "Dave Jones" <davej@suse.de>, "Andreas Jaeger" <aj@suse.de>,
        "Martin Peters" <mpet@bigfoot.de>,
        "Linux Kernel List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201232018530.2202-100000@infcip10.uni-trier.de>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Thu, 24 Jan 2002 15:39:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Daniel Nofftz" <nofftz@castor.uni-trier.de>
To: "Martin Eriksson" <nitrax@giron.wox.org>
Cc: "Ed Sweetman" <ed.sweetman@wmich.edu>; "Vojtech Pavlik"
<vojtech@suse.cz>; "Timothy Covell" <timothy.covell@ashavan.org>; "Dieter
N?tzel" <Dieter.Nuetzel@hamburg.de>; "Dave Jones" <davej@suse.de>; "Andreas
Jaeger" <aj@suse.de>; "Martin Peters" <mpet@bigfoot.de>; "Linux Kernel List"
<linux-kernel@vger.kernel.org>
Sent: Wednesday, January 23, 2002 8:21 PM
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset


> On Wed, 23 Jan 2002, Martin Eriksson wrote:
>
> > Problems (in Windows, with similar patches) have mostly been sound skips
and
> > general "skippy" behaviour (not the peanut butter). My VIA KT133 based
mobo
> > with Athlon 1000 had major sound skips, both with onboard VIA sound and
> > SB512. Also the graphics in most 3D games stuttered badly.
>
> this is the first time i hear about such problems ...
> i have no problems at all and it works great under linux and win 2k
> (vcool) ... there are no sound skips or skippy behaviors ...
>

Well I guess it's very mobo-dependent then. What I remember from the VCool
program is that it made windows go crazy on me. I dont know exactly what
happened, just that I removed vcool very quickly.

I just tried the function again, not using vcool, instead *only* enabling
bit 8 of register 0x52 ("Disconnect Enable When STPGNT Detected") with the
following results:

* No other (major) load than Winamp: Minor sound skips
* Winamp when reading from hard disk: Major sound skips
* Winamp when using distributed.net client: Almost no sound skips (one or
two on a 4 minute tune)
* Winamp when using distributed.net & using hard disk: Almost no sound skips

As both the HD controller and soundcard does much DMA, I guess it has some
connection to DMA transfers on the PCI bus?

OS: Windows 2000 Pro
Northbridge: VIA KT133
Southbridge: VIA 686B
CPU: Athlon(B) 1GHz

(Sorry, Linux is running on my BP6)

 _____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


