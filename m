Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261328AbSJPSC7>; Wed, 16 Oct 2002 14:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261331AbSJPSC6>; Wed, 16 Oct 2002 14:02:58 -0400
Received: from fmr02.intel.com ([192.55.52.25]:39398 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261328AbSJPSCx>; Wed, 16 Oct 2002 14:02:53 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000E3C176B@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: root@chaos.analogic.com, Samuel Flory <sflory@rackable.com>
Cc: Mark Cuss <mcuss@cdlsystems.com>, linux-kernel@vger.kernel.org
Subject: RE: Kernel reports 4 CPUS instead of 2...
Date: Wed, 16 Oct 2002 11:08:41 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, execution resources are not doubled, but typically shared on an
HT-capable processor. There are two architecture states (registers, APIC,
etc.) in a processor package.

Thanks,
Jun

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com]
Sent: Wednesday, October 16, 2002 10:55 AM
To: Samuel Flory
Cc: Mark Cuss; linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...


On Wed, 16 Oct 2002, Samuel Flory wrote:

> >
> >
> >On Wed, 16 Oct 2002, Mark Cuss wrote:
> >
> >  
> >
> >
> >This is the correct behavior. If you don't like this, you can
> >swap motherboards with me ;) Otherwise, grin and bear it!
> >
> >  
> >
>  
>   Wouldn't it be easier just to turn off the hypertreading or jackson 
> tech option in the bios ;-)
> 

Why would you ever want to turn it off?  You paid for a CPU with
two execution units and you want to disable one?  This makes
no sense unless you are using Windows/2000/Professional, which
will trash your disks and all their files if you have two
or more CPUs (true).


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
