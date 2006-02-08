Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965220AbWBHWmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbWBHWmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWBHWmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:42:40 -0500
Received: from 10.121.9.213.dsl.getacom.de ([213.9.121.10]:52657 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id S965220AbWBHWmk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:42:40 -0500
Message-ID: <43EA73C9.7010101@l4x.org>
Date: Wed, 08 Feb 2006 23:42:17 +0100
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051017 Thunderbird/1.0.7 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, dev@sw.ru,
       jblunck@suse.de
References: <43E90573.8040305@l4x.org> <20060207162335.5304ae61.akpm@osdl.org>	 <43E9A260.6000202@l4x.org> <661de9470602081006p2a3132e8x2436de89e9395748@mail.gmail.com>
In-Reply-To: <661de9470602081006p2a3132e8x2436de89e9395748@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.2.134
X-SA-Exim-Mail-From: jdi@l4x.org
Subject: Re: VFS: Busy inodes after unmount. Self-destruct in 5 seconds. Have
 a nice day...
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on ds666.starfleet)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
>>>>$ umount /mnt/data
>>>>Segmentation Fault
>>>>
>>>>dmesg:
>>>>
>>>>VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
>>>>Unable to handle kernel NULL pointer dereference at virtual address 00000034
>>>
>>>
> 
> There were a couple of fixes suggested for the busy inodes afer
> unmount problem. Please see
> 
> http://lkml.org/lkml/2006/1/25/17
> 
> and
> 
> http://lkml.org/lkml/2006/1/30/108
> You could see if any one of them fixes your problem. There is also
> Kirill's fix which was in mm (not sure about it now)

Thanks for the suggestion, but I couldn't reproduce it with a simple
mount/umount and the partition in question is gone for good now. And I
don't feel like risiking 450gb of data, even if I had a backup of the
data...

Jan
