Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135624AbRDSLbW>; Thu, 19 Apr 2001 07:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135625AbRDSLbM>; Thu, 19 Apr 2001 07:31:12 -0400
Received: from mail.axisinc.com ([193.13.178.2]:52241 "EHLO roma.axis.se")
	by vger.kernel.org with ESMTP id <S135624AbRDSLa4>;
	Thu, 19 Apr 2001 07:30:56 -0400
From: johan.adolfsson@axis.com
Message-ID: <02cb01c0c8c4$92ee2640$85b270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: "Grant Erickson" <erick205@umn.edu>,
        "Linux I2C Mailing List" <linux-i2c@pelican.tk.uni-linz.ac.at>,
        "Linux/PPC Embedded Mailing List" 
	<linuxppc-embedded@lists.linuxppc.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.20.0104181408540.10793-100000@garnet.tc.umn.edu>
Subject: Re: Kernel Real Time Clock (RTC) Support for I2C Devices
Date: Thu, 19 Apr 2001 13:33:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for DS1302 is available in the CRIS port.
A patch for 2.4.3 (and a lot of other stuff you don't need) is available in
http://developer.axis.com/download/devboard_lx/R1_0_0/

/Johan

----- Original Message -----
From: Grant Erickson <erick205@umn.edu>
To: Linux I2C Mailing List <linux-i2c@pelican.tk.uni-linz.ac.at>; Linux/PPC
Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>; Linux Kernel
Mailing List <linux-kernel@vger.kernel.org>
Sent: Wednesday, April 18, 2001 9:13 PM
Subject: Kernel Real Time Clock (RTC) Support for I2C Devices


> I have been unable to find an answer for this in the LKML archives, so I
> am hoping someone on this list might perhaps have some insight or pointers
> thereto on this question.
>
> I have an embedded board with a PowerPC 405GP on which Linux 2.4.2
> (MontaVista's version thereof) is running swimmingly. Attached to that
> PowerPC's I2C controller is a Dallas DS1307 I2C RTC.
>
> >From the looks of drivers/char/rtc.c it would appear that this kernel
> driver only supports bus-attached RTCs such as the mentioned MC146818. Is
> this correct?
>
> What is the correct access method / kernel tie-in for supporting such an
> I2C-based RTC device using the "standard" interfaces?
>
> My hope is to use 'hwclock' from util-linux w/o modification. Is this
> reasonable?
>
> Thanks,
>
> Grant Erickson
>
>
> --
>  Grant Erickson                       University of Minnesota Alumni
>   o mail:erick205@umn.edu                                 1996 BSEE
>   o http://www.umn.edu/~erick205                          1998 MSEE
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

