Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266466AbSKOQVp>; Fri, 15 Nov 2002 11:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbSKOQVp>; Fri, 15 Nov 2002 11:21:45 -0500
Received: from pc3-stoc3-4-cust114.midd.cable.ntl.com ([80.6.255.114]:61962
	"EHLO buzz.ichilton.co.uk") by vger.kernel.org with ESMTP
	id <S266466AbSKOQVn>; Fri, 15 Nov 2002 11:21:43 -0500
Date: Fri, 15 Nov 2002 16:28:33 +0000
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: Leopold Gouverneur <lgouv@pi.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Anyone use HPT366 + UDMA in Linux?
Message-ID: <20021115162833.GA3717@buzz.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20021115123541.GA1889@buzz.ichilton.co.uk> <20021115162704.GA1059@gouv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115162704.GA1059@gouv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> I am using an IBM-DTLA-307030 with HPT366

I am also using an IBM disk (can't rember the model number of hand but
it's a 45GB) with an Abit BP6.


> transfer rate to udma3 (44MB/s) in the HPT bios. You can also do it with
> hdparm if your boot disk is not on that controler. Trying udma4 resulted
> in _massive_ corruption (never tried recently).

It seemed to work for a while but then things went screwy and I kept
getting I/O errors all the time which needed a hard reset - could't even
shut down.

I also noticed things like this in the log:

Nov 14 23:26:40 buzz kernel: hda: status error:
status=0x58 { DriveReady SeekComplete DataRequest }
Nov 14 23:26:40 buzz kernel: hda: drive not ready for command
Nov 14 23:28:47 buzz kernel: hda: status error:
status=0x58 { DriveReady SeekComplete DataRequest }
Nov 14 23:28:47 buzz kernel: hda: drive not ready for command
Nov 14 23:29:00 buzz kernel: APIC error on CPU0: 02(02)

Is this anything like you got?

I'll try to drop it in the bios tonight (it is my boot drive). Are you
using hdparm commands at all or just setting the bios to udma3?


> HPT366 support in kernel configuration.

I am not sure I did this but I'll check. Maybe it's just working as a
normal ide interface or something?


Thanks!


Bye for Now,

Ian


                                \|||/ 
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton                  Web: http://www.ichilton.co.uk    |
 |  E-Mail: ian@ichilton.co.uk   Backup: ian@linuxfromscratch.org  | 
 |-----------------------------------------------------------------|
 |            There are 10 types of people in the world:           |
 |        Those who understand binary, and those who don't.        |
 \-----------------------------------------------------------------/

