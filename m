Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132488AbRDHEMS>; Sun, 8 Apr 2001 00:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132484AbRDHEMI>; Sun, 8 Apr 2001 00:12:08 -0400
Received: from cogent.ecohler.net ([216.135.202.106]:52411 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S132483AbRDHELq>; Sun, 8 Apr 2001 00:11:46 -0400
Date: Sun, 8 Apr 2001 00:11:32 -0400
From: lists@sapience.com
To: linux-kernel@vger.kernel.org
Cc: gibbs@scsiguy.com
Subject: Re: aic7xxx 6.1.10 and 2.4.4-pre1
Message-ID: <20010408001132.A28840@sapience.com>
In-Reply-To: <20010407195031.B25801@sapience.com> <200104080139.f381dZs92143@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200104080139.f381dZs92143@aslan.scsiguy.com>; from gibbs@scsiguy.com on Sat, Apr 07, 2001 at 07:39:35PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I used 5000ms. I still freeze up with 2.4.3 + 6.1.10.

Unfortunately i could not see any messages and nothing got logged.
This time an fsck allowed me to boot back to 2.4.1.  

The visible symptoms were the same as before (2.4.3 + 6.1.8) but this time I was
unable to flip virtual consoles before the freeze so I dont even
know 100% what is causing it - it boots fine - and the scsi driver 
makes no complaints - it all looks normal. X starts up and I can login. 
it starts ok and windows start popping up -  shortly thereafter it freezes 
- just like before. 

I will try investigate further and see if I can get any more log messages.

Is there any debug boot option or compile flag that will help me find out more 
what is going on?  

/var/log/messages says this about scsi.

Apr  7 19:56:13 snap kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.10
Apr  7 19:56:13 snap kernel:         <Adaptec 2940 Ultra2 SCSI adapter>
Apr  7 19:56:13 snap kernel:         aic7890/91: Wide Channel A, SCSI Id=7, 32/255 SCBs
Apr  7 19:56:13 snap kernel: 
Apr  7 19:56:13 snap kernel:   Vendor: YAMAHA    Model: CRW8424S          Rev: 1.0d
Apr  7 19:56:13 snap kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Apr  7 19:56:13 snap kernel:   Vendor: SEAGATE   Model: ST318275LW        Rev: 0001
Apr  7 19:56:13 snap kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Apr  7 19:56:13 snap kernel: (scsi0:A:5): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
Apr  7 19:56:13 snap kernel:   Vendor: SEAGATE   Model: ST318275LW        Rev: 0001
Apr  7 19:56:13 snap kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Apr  7 19:56:13 snap kernel: (scsi0:A:6): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
Apr  7 19:56:13 snap kernel: scsi0:0:5:0: Tagged Queuing enabled.  Depth 253
Apr  7 19:56:13 snap kernel: scsi0:0:6:0: Tagged Queuing enabled.  Depth 253


