Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132920AbRDEPP0>; Thu, 5 Apr 2001 11:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132922AbRDEPPP>; Thu, 5 Apr 2001 11:15:15 -0400
Received: from [212.97.52.90] ([212.97.52.90]:11765 "HELO odino.preciso.net")
	by vger.kernel.org with SMTP id <S132920AbRDEPPC>;
	Thu, 5 Apr 2001 11:15:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: gianpaolo racca <gianpaolo@preciso.net>
Reply-To: gianpaolo@preciso.net
Organization: gianpaolo racca
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 kernel on LH4
Date: Thu, 5 Apr 2001 17:11:48 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01040517114808.02185@loki.preciso.mgt>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 April 2001 16:57, you wrote:

> At some Kernel release between 2.4.2 and 2.4.3 I succeeded to install
> Mandrake Cooker (Devel-Tree) out of the box.
> However, we have switched to another SCSI RAID controller as the AMI
> MegaRAID driver in conjunction with I2O seems to be very buggy/broken.
> Apart from it, the AMI is does not perform that good. We now use an
> ICP Vortex 4 Chanel RAID controller that has a very good Linux support.
> However it's not I2O, it outperforms the AMI by at least 250% ...
> So we simply leave the on-board AMI unused :-)


I have disabled (don't ask me why, it was not my decision) the raid 
controller.
I had a look at the old (2.2.18) config and I see the SCSI_MEGA_RAID is 
torned on, while I forgot this with the new kernel.
I thought that, having the raid controller disabled in the bios, I don't need 
it anymore. But probably I'm in fail...
As soon as I can (probably next week) I try another time.
Do you think that this could be the problem?
If yes, so why it have some problem with:

PCI: cannot allocate resource region 0 for 0:1.4

I remember that according to lspci of kernel 2.2.18:
01:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
01:06.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c895
01:07.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c895

> Second, BigMem support (>2GB RAM) seems to be a problem with recent
> initial RAM disks (the ones current distributions use for their graphical



Well I have only 512Mb for the moment, so I don't think this is the problem.

Anyway, thanks a lot.

         gianpaolo racca
         gianpaolo@preciso.net
