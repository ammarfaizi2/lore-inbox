Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131561AbRCNXg2>; Wed, 14 Mar 2001 18:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131569AbRCNXgJ>; Wed, 14 Mar 2001 18:36:09 -0500
Received: from ppp32.adsl89.pacific.net.au ([202.7.89.32]:36626 "HELO
	adsl.mailcall.com.au") by vger.kernel.org with SMTP
	id <S131561AbRCNXfx>; Wed, 14 Mar 2001 18:35:53 -0500
Message-Id: <5.0.2.1.2.20010316021553.01c71480@172.17.0.107>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Fri, 16 Mar 2001 02:31:47 +1100
To: Marko Kreen <marko@l-t.ee>, Dalton Calford <dcalford@distributel.ca>
From: Omar Kilani <ok@mailcall.com.au>
Subject: Adaptec/DPT RAID Drivers [Was: Re: DPT Driver Status]
Cc: Linux kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010314151515.A3954@l-t.ee>
In-Reply-To: <3AAF1072.A38B2508@distributel.ca>
 <3AAF1072.A38B2508@distributel.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Scanner: exiscan *14dKqN-0001k9-00*4EN5qmZqCPk* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marko/Dalton/Unfortunate person searching for working DPT drivers,

I too once felt your pain.
Searched far and wide, etc.
But then I stumbled upon ftp://ftp.suse.com/pub/people/mantel/next/
Which has patches for everything you could ever want, all integrated, if 
you choose them to be.
Anyway, inside those .tgz's was version 2.0 of the DPT I2O drivers.
I've separated them from the .tgz, and stuck them up here:

Kernel 2.2.18:
http://aurore.net/source/dpt_i2o-2.0-2.2.18.gz

Kernel 2.4.2
http://aurore.net/source/dpt_i2o-2.0-2.4.2.gz

Try 'em! :-) Not sure how they compare to Markos' version.
I exchanged my ASR2100S for a Mylex AcceleRAID 170 - because DAC960 support 
is so much better ;-) and I loved reading through the DAC960 sources - so 
clean and easy to understand!

Regards,
Omar Kilani

At 03:15 PM 3/14/01 +0200, Marko Kreen wrote:
>On Wed, Mar 14, 2001 at 01:32:18AM -0500, Dalton Calford wrote:
> > I have searched the archives, hunted through the adaptec site, tried
> > multiple patches, compilers, revisions.....
>
>Me too...
>
> >
> > I have a DPT/Adaptec DPT RAID V century card.  This has been a topic of
> > much discussion in the past on this list.
> >
> > What I have found is that almost every file I find has a patch that is 6
> > months old at best.
>
>When I last contacted them, couple of months ago, through
>I-dunno-how-many-middle[wo]men they assured that
>"driver is in developement" and "soon we make a release"...
>
> > I even contacted Deanna Bonds at Adaptec, but she has been unresponsive.
> >
> > Does anyone have a working patch for the 2.2.18 kernel?
> > What is the most stable version of the kernel for the use of the patch?
>
>I have ported the 1.14 version of the driver to 2.2.18.
>Basically converted their idea of patching with cp to
>normal diff and dropped all reverse changes.
>
>   http://www.l-t.ee/marko/linux/dpt114-2.2.18p22.diff.gz
>
>It was for pre22 but applies cleanly to final 2.2.18.
>The other soft was most current in valinux site:
>
>   http://ftp.valinux.com/pub/mirrors/dpt/
>
> > Has the native i2o driver been updated to handle what the dpt card is
> > doing?
>
>No, the DPT driver has not been updated to native Linux i2o.
>
>Note: the driver compiles only with gcc 2.7.2.3, (dunno about
>egcs).  2.95.2 makes it acting weird.  I do not know if
>thats gcc or driver problem.
>
>--
>marko
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

