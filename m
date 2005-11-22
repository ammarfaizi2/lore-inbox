Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbVKVPcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbVKVPcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 10:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVKVPcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 10:32:15 -0500
Received: from mailhost.u-strasbg.fr ([130.79.200.152]:19149 "EHLO
	mailhost.u-strasbg.fr") by vger.kernel.org with ESMTP
	id S964955AbVKVPcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 10:32:15 -0500
Message-ID: <4383398C.8040509@crc.u-strasbg.fr>
Date: Tue, 22 Nov 2005 16:30:20 +0100
From: Philippe Pegon <Philippe.Pegon@crc.u-strasbg.fr>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051016)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14.2 detects only one processor (out of 2)
References: <5bpni-8r0-5@gated-at.bofh.it> <5bsEh-4Sc-51@gated-at.bofh.it> <43826414.4060701@shaw.ca> <Pine.LNX.4.61.0511212236440.20538@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0511212236440.20538@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (mailhost.u-strasbg.fr [IPv6:2001:660:2402::152]); Tue, 22 Nov 2005 16:32:05 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Mon, 21 Nov 2005, Robert Hancock wrote:
> 
> 
>>Philippe Pegon wrote:
>>
>>>Hi,
>>>
>>>try with acpi enabled, it works for me. It's seem that recent kernel (since
>>>2.6.12) need acpi for SMP.
>>
>>It should not - if it does this is a bug, as SMP motherboards that do not
>>support ACPI will not work.
> 
> 
> Looks like we got rid of CONFIG_ACPI_BOOT, his particular system has an 
> incomplete mptable and requires ACPI for proper processor enumeration.

yes, CONFIG_ACPI_BOOT is with 2.6.12.x, not with 2.6.14.x, I edited the 
wrong file...

--
Philippe Pegon
