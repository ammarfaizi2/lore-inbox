Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTLWP4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTLWP4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:56:37 -0500
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:37927 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S261193AbTLWP4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:56:35 -0500
Message-ID: <3FE865B9.3090502@planet.nl>
Date: Tue, 23 Dec 2003 16:56:41 +0100
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Muhammad Talha <talha@worldcall.net.pk>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0 compilation help
References: <008601c3c924$13555170$23c051cb@ns3.worldcall.net.pk>
In-Reply-To: <008601c3c924$13555170$23c051cb@ns3.worldcall.net.pk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Muhammad,

I think that you need to set this option

CONFIG_BLK_DEV_SD=m to Y and your problem should be solved. The kernel now doesn't know scsi disks (in menuconfig  SCSI disk support)

Best regards,

Stef


Muhammad Talha wrote:

>Dear all
>
>i have Red Hat 9 i am trying to install kernel 2.6.0 . kernel seems to
>compiled ok but does not boot
>give following error at boot all drive are detected before boot.
>
>module-init-tools 0.9.9 installed
>ext3 filesystem support was build in the kernel
>aslo /dev file system support buildin
>my root parttion is /dev/sda1 ( ext3)
>my .config
>
>http://mail.magic.net.pk/kernel/.config
>
>
>Error Message ##
>
>VFS: Cannot open root device "sda1" or unknown-block(0,0)
>Please append a correct "root="boot option
>Kernel Panic : VFS Uanble to mount root fs on unknown-block(0,0)
>
>i have following Hardware
>
>Intel Entry level Server motherboard
>Pentitum III 1266 MHz processor
>2 GB RAM
>3 SCSI hard drive
>no ide drive
>
>i have tried many time with different option but with no luck
>
>Thanks waiting for your reply
>
>Talha
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

