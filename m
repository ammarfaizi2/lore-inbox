Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVARIwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVARIwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 03:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVARIwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 03:52:24 -0500
Received: from penta.pentaserver.com ([216.74.97.66]:9954 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S261196AbVARIv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 03:51:56 -0500
Message-ID: <41ECCE0F.3040908@kromtek.com>
Date: Tue, 18 Jan 2005 12:51:27 +0400
From: Manu Abraham <manu@kromtek.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: omes@omes.org, linux-kernel@vger.kernel.org
Subject: Re: Mysterious Lag With SATA Maxtor 250GB 7200RPM 16MB Cache Under
 Linux using NFSv3 UDP
References: <Pine.LNX.4.61.0501171459150.1821@p500> <200501172209.00325.kernel@omes.org> <41EC2F7E.8030806@kromtek.com> <200501180005.59716.omes@omes.org>
In-Reply-To: <200501180005.59716.omes@omes.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

omes wrote:
> I suddenly couldn't send to the mailinglist any longer.. I'm going back to 
> 2.4.28 for now. My 4GB of RAM support was already turned off.. Good luck 
> further. Here is my mail:
> 
> On Monday 17 January 2005 22:34, you wrote:
> 
>>omes wrote:
>>
>>>I have the same problem as you. At least our problems are much alike. I
>>>got two Western digital hard disks. One 120GB 7200RPM 2MB Cache IDE, and
>>>one 80GB 7200 2MB Cache IDE. I get high loads when reading large files
>>>for some time, as well as when copying from one partition to another. All
>>>my partitions are in ext3, and i'm running 2.6.10.
>>
>>I have a similar problem. I am running 2.6.9 on FC3 not the stock
>>kernel, but a vanilla kernel.
>>I have 3 NFS shares mounted on this 2.6.9 machine (ASUS P4C800 ICH5
>>motherboard with 1024 MB RAM and sk98lin gigabit LOM (non-functional
>>since thesk98lin driver broke apart) so i use an additional 3Com 3C59x
>>100 Mbps adapter, with a nvidia VGA adapter, but no nvidia modules but
>>only VESAFB at 1024x768.
> 
> This is the same series as i got P4C800/P4P800.. 
> 
> Gabriel worte this in an earlier post:
> "The performance issues (below) where due to a strange bug in the kernel
> VM triggered by the motherboard BIOS. This affects Asus P4P800
> motherboards(-MX and -VM tested) with more that 1 GB RAM. The built-in
I have exactly 1GB.

> VGA can use 1-32 MB RAM for display but configured with less than 16 MB
> of video RAM the board will behave EXTREMELY poor in linux (2.6.9 also
> tested to behave like this).
> 
I don't have 4GB support, nor do i have shared VGA. I have a nvidia(64M 
onboard, not shared) card using vesafb.
No X either.

> There are several ways around this problem, I've just configured the
> board with 16 MB of video RAM. Disabling support for 4 GB of RAM works
> too but more memory is lost this way. Running FreeBSD is also an option
> but we don't like that, don't we ? Memtest86 (1.11) doesn't seems
> affected either - but it detects the memory as "single channel" while
> memory is installed in dual channel configuration (also confirmed by BIOS).
> 
> If anybody knows what's going on please let me know. Loosing 15 MB of
> RAM is not a big deal but I like linux bug-free, fast and stable.
> 
> I'm available to give more details or run some tests if anyone cares.
> 
> Regards,
> 
> Gabriel" (adapted)
> 
> As for the LOM, use this driver comes with the kernel: Device Drivers -> 
> Networking support -> Ethernet (1000 Mbit) -> Marvell Yukon Chipset / 
> SysKonnect SK-98xx Support
> 
It was broken when i tried it out on 2.6.7 i think, and i stumbled upon 
the a post stating about incorrect VPD entries.. So i thought i would 
wait for things to cool down a bit.

Manu
