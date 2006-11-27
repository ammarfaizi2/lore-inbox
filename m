Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758239AbWK0OQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758239AbWK0OQx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 09:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758238AbWK0OQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 09:16:52 -0500
Received: from SMT02002.global-sp.net ([193.168.50.254]:33480 "EHLO
	SMT02002.global-sp.net") by vger.kernel.org with ESMTP
	id S1758235AbWK0OQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 09:16:51 -0500
Message-ID: <456AF37C.8090304@privacy.net>
Date: Mon, 27 Nov 2006 15:17:32 +0100
From: John <me@privacy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050905
X-Accept-Language: en, fr
MIME-Version: 1.0
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
CC: auke-jan.h.kok@intel.com, jesse.brandeburg@gmail.com, bunk@stusta.de,
       jgarzik@pobox.com, saw@saw.sw.com.sg
Subject: Re: Intel 82559 NIC corrupted EEPROM
References: <454B7C3A.3000308@privacy.net> <454BF0F1.5050700@zytor.com> <45506C9A.5010009@privacy.net> <4551B7B8.8080601@privacy.net> <4807377b0611080926x21bd6326xc5e7683100d20948@mail.gmail.com> <45533801.7000809@privacy.net> <4807377b0611091619v6bfe17f4tbcbb64db0ab8ea9@mail.gmail.com> <45546A93.6070905@privacy.net> <455AD123.4080804@privacy.net>
In-Reply-To: <455AD123.4080804@privacy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2006 14:19:28.0791 (UTC) FILETIME=[0C9FCA70:01C7122F]
X-global-asp-net-MailScanner: Found to be clean
X-global-asp-net-MailScanner-SpamCheck: 
X-MailScanner-From: me@privacy.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John wrote:

>> 00000000-0009ffff : System RAM
>> 000a0000-000bffff : Video RAM area
>> 000f0000-000fffff : System ROM
>> 00100000-0ffeffff : System RAM
>>   00100000-00296a1a : Kernel code
>>   00296a1b-0031bbe7 : Kernel data
>> 0fff0000-0fff2fff : ACPI Non-volatile Storage
>> 0fff3000-0fffffff : ACPI Tables
>> 20000000-200fffff : 0000:00:08.0
>> 20100000-201fffff : 0000:00:09.0
>> 20200000-202fffff : 0000:00:0a.0
>> e0000000-e3ffffff : 0000:00:00.0
>> e5000000-e50fffff : 0000:00:08.0
>> e5100000-e51fffff : 0000:00:09.0
>> e5200000-e52fffff : 0000:00:0a.0
>> e5300000-e5300fff : 0000:00:08.0
>> e5301000-e5301fff : 0000:00:0a.0
>> e5302000-e5302fff : 0000:00:09.0
>> ffff0000-ffffffff : reserved
>>
>> I've also attached:
>>
>> o config-2.6.18.1-adlink used to compile this kernel
>> o dmesg output after the machine boots
> 
> I suppose the information I've sent is not enough to locate the
> root of the problem. Is there more I can provide?

Here is some context for those who have been added to the CC list:
http://groups.google.com/group/linux.kernel/browse_frm/thread/bdc8fd08fb601c26

As far as I understand, some consider the eepro100 driver to be 
obsolete, and it has been considered for removal.

What is the current status?

Unfortunately, e100 does not work out-of-the-box on this system.

Is there something I can do to improve the situation?

-- 
Regards,

John

[ E-mail address is a bit-bucket. I *do* monitor the mailing lists. ]

