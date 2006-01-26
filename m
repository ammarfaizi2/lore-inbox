Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWAZOus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWAZOus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWAZOus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:50:48 -0500
Received: from mail.cs.tut.fi ([130.230.4.42]:52196 "EHLO mail.cs.tut.fi")
	by vger.kernel.org with ESMTP id S932348AbWAZOur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:50:47 -0500
Date: Thu, 26 Jan 2006 16:50:45 +0200
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sata_sil: combined irq + LBT DMA patch for testing
Message-ID: <20060126145045.GR17268@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5hAIO-6cQ-59@gated-at.bofh.it>
User-Agent: Mutt/1.5.9i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think I know what's going on with the 'SG size underflow' thingy, 
> give me a few days to come up with a fix.

As a said issue, I'm running 2.6.15-rc7 and SiL 3114 with 3 drives 
attached on AMD64. I might like to test your patches, but I have small 
issues even without the patch (happens every now and then, but not every 
day):

ata2: no sense translation for status: 0x51
ata2: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata2: status=0x51 { DriveReady SeekComplete Error }

How do I find out which sd disk in the system does that ata2 refer to? I 
have: hda, hdc and sd[abc]. All sd disks are on SiL 3114.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
