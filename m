Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUJFAy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUJFAy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 20:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUJFAy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 20:54:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41856 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266555AbUJFAy1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 20:54:27 -0400
Message-ID: <41634236.1020602@pobox.com>
Date: Tue, 05 Oct 2004 20:54:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gianluca Cecchi <gianluca.cecchi@tiscali.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA)
References: <4136E4660006E2F7@mail-7.tiscali.it>
In-Reply-To: <4136E4660006E2F7@mail-7.tiscali.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gianluca Cecchi wrote:
> Eventually I can provide config. Btw, I'm using udev and kernel preemption.

I strongly recommend disabling kernel preemption.  It is a hack that 
hides bugs.



> ata1: dev 0 ATA, max UDMA/133, 240121728 sectors:
> ata1: dev 0 configured for UDMA/100
> and the same for ata2?

The controller maximum is set to UDMA/100.



> But taking in parallel top with refresh 1s in another window, during the
> 80
> seconds elapsed above, I had two freezes in top session: one of 20sec and
> another
> of 15 sec: about the half of the time of the total I/O operation!
> During this time there was one cpu used at about 30%, no other cpu constraints.
> I repeated the operation with similar behaviour. Sometimes also 50 contiguos
> secs
> of freeze, until I/O operation finished.
> The freeze is not about all system itself, but only certian things.
> For example I tried also a vmstat session in another window with 3secs of
> delay
> and it had no problems while top was blocked:

Make sure you have the latest BIOS update for your system, and latest 
BIOS update for your card.

	Jeff


