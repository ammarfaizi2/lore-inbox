Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132760AbRDXErU>; Tue, 24 Apr 2001 00:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132763AbRDXErL>; Tue, 24 Apr 2001 00:47:11 -0400
Received: from www.mammoth.org ([204.26.91.1]:34564 "EHLO www.mammoth.org")
	by vger.kernel.org with ESMTP id <S132760AbRDXEq4>;
	Tue, 24 Apr 2001 00:46:56 -0400
Date: Mon, 23 Apr 2001 23:46:52 -0500 (CDT)
From: josh <skulcap@mammoth.org>
To: Johannes Erdfelt <johannes@erdfelt.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: USB problems since 2.4.2
In-Reply-To: <20010423230911.M12435@sventech.com>
Message-ID: <Pine.LNX.4.20.0104232346140.15411-100000@www>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, Apr 23, 2001, josh <skulcap@mammoth.org> wrote:
> > Kernel: 2.4.2 - latest (2.4.3-ac12)
> > Platform: x86 on mangled Slack7.1
> > Hardware: MSI 694D Pro-AR
> > ( http://www.msicomputer.com/products/detail.asp?ProductID=150 )
> > 
> > Problem: USB devices timeout on address assignment. Course thats with the
> > non JE driver, with the JE driver the bus doesnt even say that anything
> > gets connected.
> > 
> > when any device is plugged in:
> > *************************************
> > hub.c: USB new device connect on bus1/1, assigned device number 4
> > usb_control/bulk_msg: timeout
> > usb.c: USB device not accepting new address=4 (error=-110)
> > hub.c: USB new device connect on bus1/1, assigned device number 5
> > usb_control/bulk_msg: timeout
> > usb.c: USB device not accepting new address=5 (error=-110)
> > *************************************
> 
> Can you try booting your kernel with the "noapic" option and see if it
> still happens?
> 

DING DING DING!  that did the trick. Thnx!

                          www.mammoth.org/~skulcap
**********************************************BEGIN GEEK CODE BLOCK************
"Sometimes, if you're perfectly      * GCS d- s: a-- C++ ULSC++++$ P+ L+++ E--- 
still, you can hear the virgin       * W+(++) N++ o+ K- w--(---) O- M- V- PS-- 
weeping for the savior of your will."* PE Y+ PGP t+ 5 X+ R !tv b+>+++ DI++ D++  
 --DreamTheater, "Lines in the Sand" * G e h+ r-- y-   (www.geekcode.com)
**********************************************END GEEK CODE BLOCK**************

