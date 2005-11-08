Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbVKHMgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVKHMgV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbVKHMgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:36:21 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:8835 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964931AbVKHMgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:36:20 -0500
Subject: Re: 2.6.14-mm1 libata pata_via
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sander@humilis.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051108121318.GB23549@favonius>
References: <6397E994-0BC3-445F-BF2B-CD3D0ADB0E02@bootc.net>
	 <20051108121318.GB23549@favonius>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Nov 2005 13:06:53 +0000
Message-Id: <1131455213.25192.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-08 at 13:13 +0100, Sander wrote:
> The two pata disks are master and slave. I might try them on separate
> channels later (especially if you want me to :-)

Would be interesting. It shouldn't change the behaviour but more info is
good.

> [42949377.130000]  sdf:<3>ata5: command error, drv_stat 0x51 host_stat 0x64
> [42949377.210000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
> [42949377.210000] ata5: status=0x51 { DriveReady SeekComplete Error }

Thats the important bit. It looks as if I got the timing clock loading
wrong for this chip. (My EPIA works nicely but all the info I need is in
your report).

Thanks

Alan

