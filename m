Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUB1HDa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 02:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbUB1HDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 02:03:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47591 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261832AbUB1HD3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 02:03:29 -0500
Message-ID: <40403D33.8050106@pobox.com>
Date: Sat, 28 Feb 2004 02:03:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Glamm <glamm@a-s-i.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Adaptec 1210SA SATA Controller Performance
References: <403B5B47.2030907@petermair.at> <403DAB74.1000504@pobox.com> <20040228042723.GA22033@romulus.a-s-i.com>
In-Reply-To: <20040228042723.GA22033@romulus.a-s-i.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Glamm wrote:
>>>Yesterday I've setup a server with Adaptec's 1210SA SATA Controller and 
>>>2 SATA disks. According to the kernel changelog the controller is 
>>>supported since 2.6.2
>>>
>>>I've installed Debian on an IDE disk, built a 2.6.3 kernel with 
>>>CONFIG_SCSI_SATA_SIL, rebooted and the kernel detected the controller 
>>>plus both SATA disks (sda, sdb). As the next step I wanted to create a 
>>>software raid 1 with the 2 SATA disks. Because it took mdadm forever to 
>>>finish, I checked /proc/mdstat and saw a progress bar with a rate of 
>>>12MB/s!
> 
> 
> More to the point, why didn't you just install a 2.4.18 kernel
> and use the Adaptec-supplied driver and the RAID-1 capabilities
> built into the card's firmware?  (Note, I'm not trying to disparage
> Jeff's work on libata here.)
> 
> I have this setup and it works flawlessly with a pair of 160GB
> SATA drives.

There are no RAID-1 capabilities built into the card's firmware :)

It's all software RAID.

	Jeff




