Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135777AbRASR5b>; Fri, 19 Jan 2001 12:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136499AbRASR5W>; Fri, 19 Jan 2001 12:57:22 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:54791 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S135777AbRASR5I>; Fri, 19 Jan 2001 12:57:08 -0500
Message-Id: <200101191756.f0JHuns30179@aslan.scsiguy.com>
To: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Patch for aic7xxx 2.4.0 test12 hang 
In-Reply-To: Your message of "Fri, 19 Jan 2001 11:40:16 CST."
             <3A687C00.FAD6FFBE@mailhost.cs.rose-hulman.edu> 
Date: Fri, 19 Jan 2001 10:56:49 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This is a temporary patch to keep the scsi driver from eating
>your data.... I am working on a real fix....
>
>Leslie Donaldson

What is the firmware revision of your Seagate drives?  There
were several models shipped in the recent past with firware that
would cause the drive to drop off the bus under high load.

There is also a known issue with U160 modes and the currently
embedded aic7xxx driver.  You might want to try the Adaptec
supported driver from here:

http://people.FreeBSD.org/~gibbs/linux/

6.09 BETA should be released later today.

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
