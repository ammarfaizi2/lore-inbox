Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290118AbSAKVOC>; Fri, 11 Jan 2002 16:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290117AbSAKVNw>; Fri, 11 Jan 2002 16:13:52 -0500
Received: from 89dyn161.com21.casema.net ([62.234.20.161]:62650 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S290113AbSAKVNj>; Fri, 11 Jan 2002 16:13:39 -0500
Message-Id: <200201112113.g0BLDKo05903@abraracourcix.bitwizard.nl>
Subject: Re: Bigggg Maxtor drives (fwd)
To: andre@linux-ide.org (Andre Hedrick)
Date: Fri, 11 Jan 2002 22:13:19 +0100 (CET)
Cc: ben@xmission.com (Benjamin S Carrell), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10201092011420.5104-100000@master.linux-ide.org> from "Andre Hedrick" at Jan 09, 2002 08:59:23 PM
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> 
> Sorry but the amount of capacity we are talking about is vastly different.
> 
> hdg: Maxtor 4G160J8, ATA DISK drive
> hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=317632/255/63, UDMA(133)

Hi Andre, 

I have one of these drives. Should I be able to run it off the promise 
controller? (Which didn't boast 48-bit compatibilty when I bought it?)

  Bus  0, device  10, function  0:
    Unknown mass storage controller: Promise Technology, Inc. 20262 (rev 1).
      IRQ 11.
      Master Capable.  Latency=32.  
      I/O at 0x9400 [0x9407].
      I/O at 0x9800 [0x9803].
      I/O at 0x9c00 [0x9c07].
      I/O at 0xa000 [0xa003].
      I/O at 0xa400 [0xa43f].
      Non-prefetchable 32 bit memory at 0xf74c0000 [0xf74dffff].

I tried it before on a "test-machine" where it ran off the onboard
controller just fine. But in my fileserver on the fast promise 
controller it just hangs while scanning the partition table. 

We're running 2.4.16 with your patch off linux-ide.org. 

	Roger. 

-----
I appreciate an Email copy on replies: I sometimes forget about the 
list for quite a while.... 
-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
