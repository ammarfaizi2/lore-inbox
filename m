Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUCKALy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbUCKALy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:11:54 -0500
Received: from pop.gmx.de ([213.165.64.20]:20653 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262719AbUCKALt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:11:49 -0500
X-Authenticated: #4512188
Message-ID: <404FAECF.6080105@gmx.de>
Date: Thu, 11 Mar 2004 01:11:59 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: walt <wa1ter@myrealbox.com>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
References: <fa.fkf6pbs.vk4328@ifi.uio.no> <fa.aj3o3v7.pgqn9l@ifi.uio.no> <404F9E5F.2010001@myrealbox.com>
In-Reply-To: <404F9E5F.2010001@myrealbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt wrote:
> Prakash K. Cheemplavam wrote:
> 
>> walt wrote:
>>
>>> Prakash K. Cheemplavam wrote:
>>>
>>>> When I insert a zip the /dev for the partition doesn't get created 
>>>> (ie hdd4, fdisk shows it though).
>>>
>>>
>>>
>>>
>>> My Zips always show up as /dev/sda4 (scsi disks).
>>
>>
>>
>> Do you have SCSI support compiled in? For me it doesn't (I have no 
>> SCSI support in, as well.) Are you using a USB ZIP? I have a ATAPI 
>> ZIP, so it makes no sense appearing as a SCSI device.
> 
> 
> Yes, I have SCSI support compiled into the kernel, and SCSI-disk as well.
> If you have SCSI/SCSI-disk support compiled as modules they should be 
> loaded
> automatically.
> 
> As far as I know all Zip drives are SCSI devices disguised as parallel/USB/
> IDE devices, but all required SCSI-disk support because that is what they
> really are underneath the disguise.
> 
> Try it and see what happens.

Nope, I don't think so, because before udev with the evil devfs 
/dev/hdd4 appeared...

So, unless you have a ATAPI ZIp on your own, I won't bother trying SCSI.

bye,

Prakash
