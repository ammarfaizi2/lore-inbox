Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272268AbRIKEEH>; Tue, 11 Sep 2001 00:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272272AbRIKED5>; Tue, 11 Sep 2001 00:03:57 -0400
Received: from techmonkeys.org ([24.72.12.135]:41396 "EHLO techmonkeys.org")
	by vger.kernel.org with ESMTP id <S272268AbRIKEDm>;
	Tue, 11 Sep 2001 00:03:42 -0400
Date: Mon, 10 Sep 2001 22:03:10 -0600
From: "Matthew S. Hallacy" <poptix@techmonkeys.org>
To: Adrian Burgess <kernel@corrosive.freeserve.co.uk>
Subject: Re: IDE Problems on SIS 735? (continued)
Message-ID: <20010910220310.C8597@techmonkeys.org>
In-Reply-To: <20010905085251.A3154@corrosive.freeserve.co.uk> <E15ebN4-0005g4-00@the-village.bc.nu> <20010905185946.A6828@corrosive.freeserve.co.uk> <20010909214900.A1135@corrosive.freeserve.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010909214900.A1135@corrosive.freeserve.co.uk>; from kernel@corrosive.freeserve.co.uk on Sun, Sep 09, 2001 at 09:49:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 09:49:00PM +0100, Adrian Burgess wrote:
> Okay, I've now changed the IDE cable attached to my hard drives twice, and I'm
> still getting IDE DMA problems - has anyone else with a SIS 735 based
> motherboard been having any problems, because I'm running short of ideas?
> Also - what are the chances of data corruption from these errors?
> Thanks,
> Adrian.
> 

I'm using the SiS 735 motherboard with ATA/100 IDE, I have an Quantum Bigfoot 8.1G drive,
along with two 45G IBM DTLA drives (ATA/100) on controller, I've had no problems beyond
some clicking on one of the IBM drives that also happens on a Promise PCI controller 
(no messages to syslog about it, and S.M.A.R.T. reports no errors (I use smartctl))
2.4.9 kernel..

				Matthew S. Hallacy

> 
> (error report)
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hda: drive not ready for command
> hda: status timeout: status=0xd0 { Busy }
> hdb: DMA disabled
> hda: drive not ready for command
> ide0: reset: success
