Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271627AbRI2WXA>; Sat, 29 Sep 2001 18:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271697AbRI2WWu>; Sat, 29 Sep 2001 18:22:50 -0400
Received: from [213.236.192.200] ([213.236.192.200]:56572 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S271627AbRI2WWh>; Sat, 29 Sep 2001 18:22:37 -0400
Message-ID: <008701c14935$90675530$0500000a@dead2>
From: "Dead2" <dead2@circlestorm.org>
To: "Mark Hahn" <hahn@physics.mcmaster.ca>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10109281126270.6506-100000@coffee.psychology.mcmaster.ca>
Subject: Re: Asus CUV266-D problems
Date: Sun, 30 Sep 2001 00:24:51 +0200
Organization: CircleStorm Productions
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It uses an UDMA-100 certified cable, it is the regular flat type.
80pin, both ends connected, no defects or sharp bends detected.

I have tried 3 _NEW_ cables now, and none of them fixes the problem.
I have also tried 2 disks with the same results.
I have not overclocked, and I run the safest bios config I can think of..

It is also _VERY_ predictable..  It only occurs at that one point during
booting of Linux. (See the logfile attached with the last mail)

I surely don't understand what I have done wrong if anything..

-=Dead2=-

PS: Thanx for any help!

----- Original Message ----- 
From: "Mark Hahn" <hahn@physics.mcmaster.ca>
To: "Dead2" <dead2@circlestorm.org>
Sent: Friday, 28 September, 2001 5:28 PM
Subject: Re: Asus CUV266-D problems


> > <4>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > <4>hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> BadCRC can only ever mean that there's signal corruption on the cable
> (detected and retried; harmless if infrequent.)  most often, this is 
> because your cable is out-of-spec: it must be <= 18", both ends must
> be plugged in, and it must be 80-conductor if you're using > udma33.
> overclocking and badly-designed motherboards can cause this as well;
> "rounded" cables will too, probably, since they trash the cable's
> crosstalk specs.
> 

