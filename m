Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbUBZDvv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbUBZDvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:51:50 -0500
Received: from smtp-1.vancouver.ipapp.com ([216.152.192.207]:59402 "EHLO
	axion.net") by vger.kernel.org with ESMTP id S262669AbUBZDvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:51:15 -0500
Message-ID: <403D6D30.3090808@axion.net>
Date: Wed, 25 Feb 2004 19:51:12 -0800
From: Patrick Richard <patr@axion.net>
User-Agent: Mozilla Thunderbird 0.5 (Macintosh/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org, "Feldman, Scott" <scott.feldman@intel.com>
Subject: Re: e1000 only works in 2.6.3 with UP kernel ?
References: <403CE4E4.9010608@axion.net> <403D2A7E.7030504@pobox.com>
In-Reply-To: <403D2A7E.7030504@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Country: CA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Patrick Richard wrote:
> 
>> Hi,
>>
>> I have been struggling to get the e1000 driver working _at all_ in 
>> 2.6.3. It works fine under 2.4.xx (same machine). This is all on an 
>> ASUS P4C800-E deluxe, using onboard e1000 and P4 with HT enabled.
> 
> Does 2.6.3-bk7 change things?
> 
>     Jeff
> 

Yes,

with ACPI turned on etc. now it no longer hangs on ifconfig (or at first 
use), and I am succesfully linked up and transferring files. I havn't 
done any huge tests but so far so good. This is with HT, SMP, ACPI, 
apic, all enabled. Incidentally now /proc/interrupts is showing better:

 > 18:    5    0  IO-APIC-level  libata, eth0
 > 23:    0    0  IO-APIC-level  libata

(of course, this is just after reboot)

-Pat
