Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263165AbREaS50>; Thu, 31 May 2001 14:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263162AbREaS5G>; Thu, 31 May 2001 14:57:06 -0400
Received: from moon.govshops.com ([207.32.111.5]:32783 "HELO mail.govshops.com")
	by vger.kernel.org with SMTP id <S263159AbREaS5F>;
	Thu, 31 May 2001 14:57:05 -0400
From: "Alok K. Dhir" <alok@dhir.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Scsi data parity errors on aix7xxx in kernel 2.4.5
Date: Thu, 31 May 2001 15:02:11 -0400
Message-ID: <000901c0ea04$32b1b650$1e01a8c0@dhir.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <000801c0ea01$51d4eeb0$1e01a8c0@dhir.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forgot to mention (in case it matters) that I'm running ReiserFS on sdd6
which is hanging off of scsi1.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Alok K. Dhir
> Sent: Thursday, May 31, 2001 2:42 PM
> To: linux-kernel@vger.kernel.org
> Subject: Scsi data parity errors on aix7xxx in kernel 2.4.5
> 
> 
> 
> Running kernel 2.4.5 with two scsi controllers - scsi0 is a 
> sym53c8xx, scsi1 is aic7xxx.  
> 
> For the last month or so, I've been getting the following 
> error in my syslog 10 or so times a day:
> 
> -----
> May 31 14:09:51 dog kernel: scsi1: PCI error Interrupt at 
> seqaddr = 0x8e May 31 14:09:51 dog kernel: scsi1: Data Parity 
> Error Detected during address or write data phase
> -----
> 
> The box is a PIII-750 on an Aopen AX6BC (BX chipset) running 
> at 930Mhz (7.5 * 124Mhz bus speed), with 384 megs of RAM 
> (1*128MB PC100, 2*128MB PC133).  I've tried running at 
> 7.5*100 and I still get the errors.
> 
> Any advice as to what I should look at to solve this problem?
> 
> Thanks
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the 
> FAQ at  http://www.tux.org/lkml/
> 

