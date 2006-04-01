Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWDACyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWDACyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 21:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWDACyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 21:54:46 -0500
Received: from smtpout.mac.com ([17.250.248.97]:51675 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751455AbWDACyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 21:54:45 -0500
In-Reply-To: <442DD58B.7070801@shaw.ca>
References: <5VqEv-46l-49@gated-at.bofh.it> <5VqEv-46l-47@gated-at.bofh.it> <5WA8u-X3-5@gated-at.bofh.it> <5WAi6-19q-13@gated-at.bofh.it> <5WB4M-2kX-29@gated-at.bofh.it> <442DD58B.7070801@shaw.ca>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7873105C-8F66-4458-B669-3D6677203802@mac.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
Date: Fri, 31 Mar 2006 21:54:41 -0500
To: Robert Hancock <hancockr@shaw.ca>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 31, 2006, at 20:21:15, Robert Hancock wrote:
> Kyle Moffett wrote:
>> hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>> hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
>
> Hmm, are these new? Sure you don't have a bad IDE cable?

Oh, those aren't the errors I'm worried about; I've had those for a  
while and they're harmless.  Those are due to the kernel running the  
IDE controller at a higher-than-supported speed.  It gets errors for  
a couple seconds and automatically drops the bus down to a lower and  
safer speed.  The cable's aren't bad, I've tried at least 6 different  
80-conductor cables that all work fine in other systems.  The errors  
I _am_ worried about are these:

> Mar 28 03:15:13 penelope kernel: hdi: status timeout: status=0xd0  
> { Busy }
> Mar 28 03:15:13 penelope kernel: PDC202XX: Secondary channel reset.
> Mar 28 03:15:13 penelope kernel: hdi: no DRQ after issuing  
> MULTWRITE_EXT
> Mar 28 03:15:13 penelope kernel: ide4: reset: success
> Mar 28 03:30:13 penelope kernel: hdi: status timeout: status=0xd0  
> { Busy }
> Mar 28 03:30:13 penelope kernel: PDC202XX: Secondary channel reset.
> Mar 28 03:30:13 penelope kernel: hdi: no DRQ after issuing  
> MULTWRITE_EXT
> Mar 28 03:30:13 penelope kernel: ide4: reset: success

Cheers,
Kyle Moffett

