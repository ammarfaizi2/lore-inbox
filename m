Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRAXPUg>; Wed, 24 Jan 2001 10:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129953AbRAXPU1>; Wed, 24 Jan 2001 10:20:27 -0500
Received: from mail.iex.net ([192.156.196.5]:61410 "EHLO mail.iex.net")
	by vger.kernel.org with ESMTP id <S129764AbRAXPUF>;
	Wed, 24 Jan 2001 10:20:05 -0500
Message-ID: <3A6EF2A1.286092D5@iex.net>
Date: Wed, 24 Jan 2001 08:20:01 -0700
From: Tim Sullivan <tsulliva@iex.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt_Domsch@Dell.com
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: No SCSI Ultra 160 with Adaptec Controller
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9C0F@ausxmrr501.us.dell.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com wrote:
> 
> > Justin's 6.0.9beta(latest release) hasn't corrected the problem yet.
> >
> > scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.0.9 BETA
> >         <Adaptec 29160 Ultra160 SCSI adapter>
> >         aic7892: Wide Channel A, SCSI Id=7, 32/255 SCBs
> >
> >   Vendor: QUANTUM   Model: ATLAS10K2-TY367L  Rev: DDD6
> >   Type:   Direct-Access                      ANSI SCSI revision: 03
> > (scsi0:A:0): async, 8bit
> > scsi0:0:0:0: Tagged Queuing enabled.  Depth 8
> > Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
> > (scsi0:A:0): async, 16bit
> > (scsi0:A:0): synchronous at 80.0MHz DT, offset 0x7f, 16bit
> > SCSI device sda: 71721820 512-byte hdwr sectors (36722 MB)
> 
> I could still be wrong, but 80 MHz * 16 bits (2 bytes) = 160 MB/sec.
> We are testing Justin's driver internally.  I'll grab our SCSI disk guys and
> make sure it's up to speed.
> 
> Thanks,
> Matt

My apologies, you're right of course :-)  I was seeing MHz and thinking
MB!

Thanks,
tim
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
