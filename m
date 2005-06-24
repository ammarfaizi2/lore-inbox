Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVFXVDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVFXVDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263265AbVFXU7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 16:59:48 -0400
Received: from lucidpixels.com ([66.45.37.187]:3749 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S263215AbVFXUz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 16:55:58 -0400
Date: Fri, 24 Jun 2005 16:55:57 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Promise ATA/133 Errors With 2.6.10+
Message-ID: <Pine.LNX.4.63.0506241653580.31140@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two different machines with the 7200.8 Seagate 8MB 400GB drives.

Both have ATA/133 controllers, the error is the same on both:

Jun 24 15:24:18 localhost kernel: hde: no DRQ after issuing MULTWRITE_EXT

I put the drive on an (older) Promise ATA/100 controller = works great!
I put the drive on the second box on the motherboard IDE interface = works 
great!

What happened > 2.6.10 to the promise driver?

??

Jun 24 15:24:18 localhost kernel: PDC202XX: Primary channel reset.
Jun 24 15:24:18 localhost kernel: hde: timeout waiting for DMA
Jun 24 15:24:18 localhost kernel: hde: status error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Jun 24 15:24:18 localhost kernel:
Jun 24 15:24:18 localhost kernel: ide: failed opcode was: unknown
Jun 24 15:24:18 localhost kernel: hde: drive not ready for command
Jun 24 15:24:18 localhost kernel: hde: status timeout: status=0xd0 { Busy 
}
Jun 24 15:24:18 localhost kernel:
Jun 24 15:24:18 localhost kernel: ide: failed opcode was: unknown
Jun 24 15:24:18 localhost kernel: PDC202XX: Primary channel reset.
Jun 24 15:24:18 localhost kernel: hde: no DRQ after issuing MULTWRITE_EXT
Jun 24 15:24:18 localhost kernel: ide2: reset: success

