Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266094AbUFWDlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266094AbUFWDlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 23:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUFWDlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 23:41:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41915 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266101AbUFWDkJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 23:40:09 -0400
Message-ID: <40D8FB8A.8040109@pobox.com>
Date: Tue, 22 Jun 2004 23:39:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jakma <paul@clubi.ie>
CC: linux-ide@vger.kernel.org, Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix sata_sil quirk
References: <40D89509.6010502@pobox.com> <Pine.LNX.4.60.0406230421220.2702@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.60.0406230421220.2702@fogarty.jakma.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:
> # cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: WDC WD1600JD-00G Rev: 02.0
>   Type:   Direct-Access                    ANSI SCSI revision: 05
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: WDC WD1600JD-00G Rev: 02.0
>   Type:   Direct-Access                    ANSI SCSI revision: 05
> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: WDC WD1600JD-00G Rev: 02.0
>   Type:   Direct-Access                    ANSI SCSI revision: 05

> And am not having (touch wood) any stability problems using these disks 
> with linux md RAID1 and RAID5. Though, they're in a K6-II 350, so 
> performance is slow anyway. (i get about 25MB/s absolute max reading 
> from a RAID-5 array).


Cool.  Yeah, non-Seagate should be full speed and unaffected...

	Jeff


