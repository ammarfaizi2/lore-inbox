Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265255AbUGMQPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUGMQPO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 12:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUGMQPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 12:15:14 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:34326 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265255AbUGMQPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 12:15:09 -0400
Message-ID: <40F40628.80303@smallworld.cx>
Date: Tue, 13 Jul 2004 16:56:24 +0100
From: Ian Leonard <ian@smallworld.cx>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040519)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27-rc3 sata ICH5R
References: <40F3BCD1.2090209@smallworld.cx> <40F3F482.7020105@pobox.com>
In-Reply-To: <40F3F482.7020105@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Ian Leonard wrote:
> 
>> Hi,
>>
>> I have an motherboard with an Intel 82801EB. The documentation claims 
>> it has an Intel ICH5R sata interface.
>>
>> With the previous kernel version I tried, it locked up when probing 
>> the disks on boot. 2.4.27-rc3 boots but gives many errors on /dev/hdg. 
>> These look something like:
>>
>> hdg: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
>>
>> According to what I have read, this should be supported and should be 
>> using /dev/hd? rather than /dev/sd?. Is this correct?
> 
> 
> Incorrect, SATA is /dev/sd?.

Thanks Jeff,

Clearly there is something wrong. I can't access the device using 
/dev/sda .. /dev/sdh. I have scsi support as modules (sd_mod, scsi_mod) 
and have enabled CONFIG_SCSI_SATA. /proc/scsi/scsi reports no adaptors 
present.

Also why do I get the mass of errors on /dev/hdg at boot time?

Thanks.

-- 
Ian Leonard

Please ignore spelling and punctuation - I did.
