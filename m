Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbUCKACt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbUCKACt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:02:49 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:45684 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262889AbUCKACr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:02:47 -0500
Message-ID: <404F9E5F.2010001@myrealbox.com>
Date: Wed, 10 Mar 2004 15:01:51 -0800
From: walt <wa1ter@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; NetBSD i386; en-US; rv:1.6) Gecko/20040310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
References: <fa.fkf6pbs.vk4328@ifi.uio.no> <fa.aj3o3v7.pgqn9l@ifi.uio.no>
In-Reply-To: <fa.aj3o3v7.pgqn9l@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> walt wrote:
> 
>> Prakash K. Cheemplavam wrote:
>>
>>> When I insert a zip the /dev for the partition doesn't get created 
>>> (ie hdd4, fdisk shows it though).
>>
>>
>>
>> My Zips always show up as /dev/sda4 (scsi disks).
> 
> 
> Do you have SCSI support compiled in? For me it doesn't (I have no SCSI 
> support in, as well.) Are you using a USB ZIP? I have a ATAPI ZIP, so it 
> makes no sense appearing as a SCSI device.

Yes, I have SCSI support compiled into the kernel, and SCSI-disk as well.
If you have SCSI/SCSI-disk support compiled as modules they should be loaded
automatically.

As far as I know all Zip drives are SCSI devices disguised as parallel/USB/
IDE devices, but all required SCSI-disk support because that is what they
really are underneath the disguise.

Try it and see what happens.
