Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135259AbRDRTON>; Wed, 18 Apr 2001 15:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135263AbRDRTOE>; Wed, 18 Apr 2001 15:14:04 -0400
Received: from mhub5.tc.umn.edu ([160.94.218.235]:18610 "EHLO mhub5.tc.umn.edu")
	by vger.kernel.org with ESMTP id <S135259AbRDRTNy>;
	Wed, 18 Apr 2001 15:13:54 -0400
Date: Wed, 18 Apr 2001 14:13:33 -0500 (CDT)
From: Grant Erickson <erick205@umn.edu>
To: Linux I2C Mailing List <linux-i2c@pelican.tk.uni-linz.ac.at>,
        Linux/PPC Embedded Mailing List 
	<linuxppc-embedded@lists.linuxppc.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel Real Time Clock (RTC) Support for I2C Devices
Message-Id: <Pine.SOL.4.20.0104181408540.10793-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been unable to find an answer for this in the LKML archives, so I
am hoping someone on this list might perhaps have some insight or pointers
thereto on this question.

I have an embedded board with a PowerPC 405GP on which Linux 2.4.2
(MontaVista's version thereof) is running swimmingly. Attached to that
PowerPC's I2C controller is a Dallas DS1307 I2C RTC.

>From the looks of drivers/char/rtc.c it would appear that this kernel
driver only supports bus-attached RTCs such as the mentioned MC146818. Is
this correct?

What is the correct access method / kernel tie-in for supporting such an
I2C-based RTC device using the "standard" interfaces?

My hope is to use 'hwclock' from util-linux w/o modification. Is this
reasonable?

Thanks,

Grant Erickson


-- 
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE


