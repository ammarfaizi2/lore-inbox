Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285338AbSALJcV>; Sat, 12 Jan 2002 04:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbSALJcN>; Sat, 12 Jan 2002 04:32:13 -0500
Received: from zeus.kernel.org ([204.152.189.113]:16312 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S285338AbSALJcA>;
	Sat, 12 Jan 2002 04:32:00 -0500
Date: Sat, 12 Jan 2002 01:14:20 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Benjamin S Carrell <ben@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Bigggg Maxtor drives (fwd)
In-Reply-To: <200201112113.g0BLDKo05903@abraracourcix.bitwizard.nl>
Message-ID: <Pine.LNX.4.10.10201120111440.12811-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rogier,

Please look at the pdc202xx.c code and see that it is addessed by using
the formerly unpublished DMA-ATAPI locations for the backwards support.

Please note this will require the very latest BIOS updates for the acards.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

On Fri, 11 Jan 2002, Rogier Wolff wrote:

> Andre Hedrick wrote:
> > 
> > 
> > Sorry but the amount of capacity we are talking about is vastly different.
> > 
> > hdg: Maxtor 4G160J8, ATA DISK drive
> > hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=317632/255/63, UDMA(133)
> 
> Hi Andre, 
> 
> I have one of these drives. Should I be able to run it off the promise 
> controller? (Which didn't boast 48-bit compatibilty when I bought it?)
> 
>   Bus  0, device  10, function  0:
>     Unknown mass storage controller: Promise Technology, Inc. 20262 (rev 1).
>       IRQ 11.
>       Master Capable.  Latency=32.  
>       I/O at 0x9400 [0x9407].
>       I/O at 0x9800 [0x9803].
>       I/O at 0x9c00 [0x9c07].
>       I/O at 0xa000 [0xa003].
>       I/O at 0xa400 [0xa43f].
>       Non-prefetchable 32 bit memory at 0xf74c0000 [0xf74dffff].
> 
> I tried it before on a "test-machine" where it ran off the onboard
> controller just fine. But in my fileserver on the fast promise 
> controller it just hangs while scanning the partition table. 
> 
> We're running 2.4.16 with your patch off linux-ide.org. 
> 
> 	Roger. 
> 
> -----
> I appreciate an Email copy on replies: I sometimes forget about the 
> list for quite a while.... 
> -- 
> ** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
> *-- BitWizard writes Linux device drivers for any device you may have! --*
> * There are old pilots, and there are bold pilots. 
> * There are also old, bald pilots. 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

