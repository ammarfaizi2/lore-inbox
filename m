Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267424AbRGLEpV>; Thu, 12 Jul 2001 00:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267425AbRGLEpL>; Thu, 12 Jul 2001 00:45:11 -0400
Received: from rillanon.amristar.com.au ([202.181.77.23]:29715 "HELO
	amristar.com.au") by vger.kernel.org with SMTP id <S267424AbRGLEo7>;
	Thu, 12 Jul 2001 00:44:59 -0400
From: "Daniel Harvey" <daniel@amristar.com.au>
To: "Daniel Harvey" <daniel@amristar.com.au>, "Chris Wedgwood" <cw@f00f.org>,
        <hahn@coffee.psychology.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: RE: FW: UPDATE: Linux SLOW on Compaq Armada 110 PIII Speedstep
Date: Thu, 12 Jul 2001 12:48:57 +0800
Message-ID: <NEBBJDBLILDEDGICHAGACEAGCGAA.daniel@amristar.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <NEBBJDBLILDEDGICHAGAKEAFCGAA.daniel@amristar.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got an idea - the video card in the Compaq uses a piece of shared memory
(between 2-8M).

Would Linux be able to detect that?

Daniel.

> -----Original Message-----
> From: Daniel Harvey [mailto:daniel@amristar.com.au]
> Sent: Thursday, 12 July 2001 12:43 PM
> To: Chris Wedgwood; Mark Hahn [hahn@coffee.psychology.mcmaster.ca];
> linux-kernel@vger.kernel.org
> Subject: RE: FW: UPDATE: Linux SLOW on Compaq Armada 110 PIII Speedstep
>
>
> At last getting something different!
>
> linux 2.4.5 with:
>
> no options - slow
> mem=64M - fast
> mem=128M - fast
> mem=200M - fast
> mem=224M - fast
> mem=240M - fast
> mem=248M - fast
> mem=249M - fast/medium, fast 'make dep' but slow boot/reboot
> mem=250M - slow
> mem=252M - slow
> mem=256M - hangs on boot, last line="Freeing unused kernel
> memory: 196k freed"
>
>
> > -----Original Message-----
> > From: Chris Wedgwood [mailto:cw@f00f.org]
> > Sent: Thursday, 12 July 2001 11:48 AM
> > To: Daniel Harvey
> > Subject: Re: FW: UPDATE: Linux SLOW on Compaq Armada 110 PIII Speedstep
> >
> >
> > On Thu, Jul 12, 2001 at 11:48:31AM +0800, Daniel Harvey wrote:
> >
> >     That's the weird thing - 2.4.5 is just as slow! Even though,
> > as you say, it
> >     has the patch etc incorporated ...
> >
> > boot 2.4.5 with the command line optino "mem=64M" and see how slow it is
> >
> >
> >
> >   --cw
> >

