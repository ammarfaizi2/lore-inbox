Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272949AbTG3QAj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272951AbTG3QAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:00:39 -0400
Received: from remt27.cluster1.charter.net ([209.225.8.37]:56505 "EHLO
	remt27.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S272949AbTG3QAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:00:33 -0400
Message-ID: <3F27EBB5.6040608@mrs.umn.edu>
Date: Wed, 30 Jul 2003 11:00:53 -0500
From: Grant Miner <mine0057@mrs.umn.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Zio! compactflash doesn't work
References: <3F26F009.4090608@mrs.umn.edu> <20030730063536.GL13611@Synopsys.COM>
In-Reply-To: <20030730063536.GL13611@Synopsys.COM>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:
> Grant Miner, Wed, Jul 30, 2003 00:07:05 +0200:
> 
>>I have a Microtech CompactFlash ZiO! USB
> 
> ...
> 
>>but it does not show up in /dev; this is in 2.6.0-pre1.  (It never 
>>worked in 2.4 either.)  config is attached.  Any ideas?
> 
> 
> It does not have to show up anywere. You have to modprobe sd-mod and
> usb_storage first. Than access /dev/sd<something>:
> 
> $ mount -t vfat /dev/sda1 /mnt/cf
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Yes, I have both of those compiled in, yet no scsi disks appear.

