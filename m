Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282213AbRLOKOq>; Sat, 15 Dec 2001 05:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282242AbRLOKOg>; Sat, 15 Dec 2001 05:14:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20228 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282213AbRLOKOV>;
	Sat, 15 Dec 2001 05:14:21 -0500
Date: Sat, 15 Dec 2001 11:13:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Carl Ritson <critson@perlfu.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: OOPS: 2.5.1-pre8 - cdrecord + ide_scsi
Message-ID: <20011215101357.GB4587@suse.de>
In-Reply-To: <20011209153820.GE28729@suse.de> <Pine.LNX.4.10.10112141604430.10899-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10112141604430.10899-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14 2001, Andre Hedrick wrote:
> 
> Sorry Jens, you are mis-informed.
> SCSI is only the packbuilder, but it is excuted by the ATA PacketCommand.

What on earth are you talking about, this is completely unrelated to
what this message is about. ide-scsi didn't set the right vec count for
the submitted bio, so dma transfers barfed on irq timeout.

-- 
Jens Axboe

