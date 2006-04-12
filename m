Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWDLO3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWDLO3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 10:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWDLO3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 10:29:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13706 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751171AbWDLO3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 10:29:20 -0400
Subject: Re: libata-pata works on ICH4-M
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr>
References: <443B9EBB.6010607@gmx.net>
	 <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr>
	 <1144832990.1952.20.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Apr 2006 15:38:22 +0100
Message-Id: <1144852703.1952.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-04-12 at 11:55 +0200, Jan Engelhardt wrote:
> That sounds nice, but does hdparm also work with it? The last time I 
> tried to hdparm a SCSI-style device (usb flash disk, /dev/sda), it did 
> not work, only sdparm did the job. Will this also be the case with libata?

Ask the hdparm maintainers. Its mostly obsoleted by blktool and the like
which are generic

> (BTW, did you mean LBA48?)

No I meant LBA28. An LBA48 command takes far longer to issue than LBA28

