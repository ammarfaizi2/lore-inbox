Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbRFGQoi>; Thu, 7 Jun 2001 12:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261968AbRFGQo3>; Thu, 7 Jun 2001 12:44:29 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:53749 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S261866AbRFGQoO>;
	Thu, 7 Jun 2001 12:44:14 -0400
Message-ID: <3B1FAF79.DF86DA0A@fc.hp.com>
Date: Thu, 07 Jun 2001 10:44:41 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nico Schottelius <nicos@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi disk defect or kernel driver defect ?
In-Reply-To: <3B1FAA63.130E556A@pcsystems.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius wrote:
> 
> Hello guys!
> 
> Currently my scsi disc is only reporting errors!
> In the adaptect scsi bios I tried the verify media
> option and it worked fine. The output from the Linux
> kernel is more than worse!
> 
> Can you tell me what's wrong in my system ?
> 
> I will monitor the mailing list the next hours, if
> the hard disk allows that.
> 
> Please help me, this is the second scsi disc
> reporting such failures!
> 
> Regards,
> 
> Nico
>....... stuff deleted ......
> 
>  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>  I/O error: dev 08:01, sector 127304
> SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
> [valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
> ASC=47 ASCQ= 0
> Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>  I/O error: dev 08:01, sector 127312
> SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
> [valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
> ASC=47 ASCQ= 0

You are seeing lots of parity errors (ASC=47 ASCQ=0). I would suggest
checking cabling and terminator. 

-- 
Khalid

====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
