Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWCTNdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWCTNdU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWCTNdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:33:20 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:60575 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S964772AbWCTNdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:33:20 -0500
Date: Mon, 20 Mar 2006 14:33:18 +0100
From: Sander <sander@humilis.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com,
       lkml@rtr.ca
Subject: Some sata_mv error messages  (was: Re: 2.6.16-rc6-mm2)
Message-ID: <20060320133318.GB32762@favonius>
Reply-To: sander@humilis.net
References: <20060318044056.350a2931.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318044056.350a2931.akpm@osdl.org>
X-Uptime: 13:39:17 up 17 days, 17:49, 33 users,  load average: 3.23, 3.41, 3.67
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While sata_mv in 2.6.16-rc6-mm2 seems stable (yah!) compared to
2.6.16-rc6 (no crashes, no data corruption), I still get these messages:

[ 3962.139906] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 3962.139959] ata5: status=0xd0 { Busy }

[ 6105.948045] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 6105.948097] ata6: status=0xd0 { Busy }

[ 7981.164936] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 7981.164991] ata5: status=0xd0 { Busy }

[ 8273.951019] ata7: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 8273.951072] ata7: status=0xd0 { Busy }

[ 9903.032350] ata8: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 9903.032402] ata8: status=0xd0 { Busy }


I'm not entirely sure this is only happens on sata_mv (Marvell
MV88SX6081) as out of eight disks only one is connected to the onboard
sata_nv (nVidia) and the error doesn't happen very often. But I'll keep
an eye on it.

Are these messages somehow dangerous or otherwise indicating a
potentional serious problem? A google search came up with a few links,
but none of them helped me understand the messages.

Thanks!

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
