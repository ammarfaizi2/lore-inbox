Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129441AbRAXGxU>; Wed, 24 Jan 2001 01:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAXGxK>; Wed, 24 Jan 2001 01:53:10 -0500
Received: from mail.iex.net ([192.156.196.5]:37559 "EHLO mail.iex.net")
	by vger.kernel.org with ESMTP id <S129401AbRAXGne>;
	Wed, 24 Jan 2001 01:43:34 -0500
Message-ID: <3A6E7991.6377220F@iex.net>
Date: Tue, 23 Jan 2001 23:43:29 -0700
From: Tim Sullivan <tsulliva@iex.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt_Domsch@Dell.com
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: No SCSI Ultra 160 with Adaptec Controller
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9C0C@ausxmrr501.us.dell.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com wrote:
> 
> Yes, that code is still necessary.  There's a new aic7xxx driver by Justin
> Gibbs at Adaptec which is now being beta tested which corrects this issue.

Justin's 6.0.9beta(latest release) hasn't corrected the problem yet.

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.0.9 BETA
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Wide Channel A, SCSI Id=7, 32/255 SCBs

  Vendor: QUANTUM   Model: ATLAS10K2-TY367L  Rev: DDD6
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): async, 8bit
scsi0:0:0:0: Tagged Queuing enabled.  Depth 8
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): async, 16bit
(scsi0:A:0): synchronous at 80.0MHz DT, offset 0x7f, 16bit
SCSI device sda: 71721820 512-byte hdwr sectors (36722 MB)

-tim
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
