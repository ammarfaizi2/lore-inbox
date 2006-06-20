Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbWFTMRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWFTMRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 08:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWFTMRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 08:17:55 -0400
Received: from lucidpixels.com ([66.45.37.187]:26793 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932618AbWFTMRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 08:17:50 -0400
Date: Tue, 20 Jun 2006 08:17:49 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, Mark Lord <lkml@rtr.ca>
Subject: LibPATA/ATA Errors Continue - Will there be a fix for this?
Message-ID: <Pine.LNX.4.64.0606200808250.5851@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

I've done many RSYNCs to this disk (writing is what makes these errors 
seem to occur) and I have MD5's the files on both sides, they are OK on 
each side.

Should someone comment this code out that produces the printk()'s as these 
are useless information as there is no problem with the disk?

Jun 20 03:14:20 p34 kernel: [4339456.678000] ata3: status=0x51 { 
DriveReady SeekComplete Error }
Jun 20 03:14:20 p34 kernel: [4339456.678000] ata3: error=0x04 { 
DriveStatusError }
Jun 20 03:20:27 p34 kernel: [4339823.900000] ata3: status=0x51 { 
DriveReady SeekComplete Error }
Jun 20 03:20:27 p34 kernel: [4339823.900000] ata3: error=0x04 { 
DriveStatusError }
Jun 20 03:36:44 p34 kernel: [4340801.772000] ata3: no sense translation 
for status: 0x51
Jun 20 03:36:44 p34 kernel: [4340801.772000] ata3: status=0x51 { 
DriveReady SeekComplete Error }
Jun 20 03:41:04 p34 kernel: [4341061.844000] ata3: no sense translation 
for status: 0x51
Jun 20 03:41:04 p34 kernel: [4341061.844000] ata3: status=0x51 { 
DriveReady SeekComplete Error }
Jun 20 03:46:27 p34 kernel: [4341384.974000] ata3: no sense translation 
for status: 0x51
Jun 20 03:46:27 p34 kernel: [4341384.974000] ata3: status=0x51 { 
DriveReady SeekComplete Error }

Justin.
