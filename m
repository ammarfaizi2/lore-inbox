Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267124AbTBDGs1>; Tue, 4 Feb 2003 01:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbTBDGs1>; Tue, 4 Feb 2003 01:48:27 -0500
Received: from tag.witbe.net ([81.88.96.48]:27399 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S267124AbTBDGs0>;
	Tue, 4 Feb 2003 01:48:26 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'John Goerzen'" <jgoerzen@complete.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.20 panic in scheduler
Date: Tue, 4 Feb 2003 07:57:51 +0100
Message-ID: <002901c2cc1a$bc53f4f0$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <877kch8286.fsf@christoph.complete.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Maybe unrelated, maybe not...
I too have a Dell 2650, Perc 3/Di and bcm5700, running 2.4.20...

What I see is the machine hang (really hang, nothing on the console,
still pinging but nothing else) why doing two or three simultaneous
copy of a 2 Gb file between the three 75Gb disks I have...

I other question : bcm5700 is supported in RedHat, as a module
only. At the same time, Kernel includes support for Broadcomm
Tigon3... Is it safe to use Tigon3 driver with a bcm5700 hardware ?

Regards,
Paul

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of John Goerzen
> Sent: Monday, February 03, 2003 10:49 PM
> To: linux-kernel@vger.kernel.org
> Subject: Re: Kernel 2.4.20 panic in scheduler
> 
> 
> Chris Wright <chris@wirex.com> writes:
> 
> >> Today I experienced a kernel panic running kernel 2.4.20 (plus the 
> >> ctx vserver patch; otherwise vanilla) with a bcm5700 
> module added in.  
> >> It's
> >
> > Have you tried this without the vserver patch?  Last I looked it 
> > touched many of the code paths in your trace below.  Also, if 
> > possible, set up a serial console, it'll be a lot easier to 
> catch the 
> > full trace.
> 
> Unfortunately, this is on a production server, and such a 
> drastic change to the configuration is not really possible at 
> the moment. However, I have gone ahead and sent them this 
> info.  We will see.
> 
> I'm already on the serial console option.  Hope to have it soon.
> 
> I saw a lot of TCP-related symbols.  Is there any chance that 
> this is a bug in the bcm5700 module?  Or in the TCP stack?
> 
> -- John
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

