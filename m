Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbTLRSZP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 13:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbTLRSZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 13:25:15 -0500
Received: from crete.csd.uch.gr ([147.52.16.2]:40429 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S265269AbTLRSZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 13:25:05 -0500
Organization: 
Date: Thu, 18 Dec 2003 20:23:42 +0200 (EET)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: linux-kernel@vger.kernel.org
Subject: SONY DRU500-AX DVDRW problem with 4X DVD+R
Message-ID: <Pine.GSO.4.58.0312182017520.5395@oneiro.csd.uch.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever I try to write a 4X DVD+R with my SONY writer, kernel reports the
following message:

hdg: command error: status=0x51 { DriveReady SeekComplete Error }
hdg: command error: error=0x54
end_request: I/O error, dev hdg, sector 64
Buffer I/O error on device hdg, logical block 8
hdg: DMA timeout retry
PDC202XX: Secondary channel reset.
hdg: timeout waiting for DMA
hdg: status timeout: status=0xd0 { Busy }
hdg: status timeout: error=0xd0LastFailedSense 0x0d
hdg: drive not ready for command
hdg: ATAPI reset complete
cdrom_newpc_intr: 32768 residual after xfer

What does it mean? Problem with the media or with the Promise PDC20268
controller?

Also the DVD is closed almost 1 minute after starting writing, and so the
disc is unusable!

I have written successfully many DVD+R 2.4X and CDR 24X with DMA enabled.

Thanks for any feedback.

P.S.
I do not use scsi-emulation and the kernel is 2.6.0.

	Panagiotis Papadakos
