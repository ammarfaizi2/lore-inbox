Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVEKTY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVEKTY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVEKTY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:24:27 -0400
Received: from p4.gsnoc.net ([209.51.147.210]:49850 "EHLO p4.gsnoc.net")
	by vger.kernel.org with ESMTP id S262027AbVEKTYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:24:07 -0400
Message-ID: <42825BF3.405@cachola.com.br>
Date: Wed, 11 May 2005 16:24:35 -0300
From: =?ISO-8859-1?Q?Andr=E9_Pereira_de_Almeida?= <andre@cachola.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Yu, Luming" <luming.yu@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: acpi poweroff
References: <427FC554.1070306@cachola.com.br> <20050511162950.GA5486@linux.sh.intel.com> <42825A33.2010102@cachola.com.br>
In-Reply-To: <42825A33.2010102@cachola.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - p4.gsnoc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - cachola.com.br
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

André Pereira de Almeida wrote:

> Yu, Luming wrote:
>
>> This is a clue to track down to the root.
>> What's your machine model and kernel version?
>> Thanks,
>> Luming
>> On 2005.05.09 17:17:24 -0300, André Pereira de Almeida wrote:
>>  
>>
>>> When I try to poweroff my computer, it reboots.
>>> The only way to turn it off is to change
>>>
>>> acpi_sleep_prepare(ACPI_STATE_S5);
>>>
>>> to
>>>
>>> acpi_sleep_prepare(ACPI_STATE_S4);
>>>
>>> in the function acpi_power_off in the file 
>>> drivers/acpi/sleep/poweroff.c.
>>> I think it's a buggy acpi controller.
>>> What's the side effect of this change?
>>>
>> /
>>  
>>
> It is a AMD Athlon XP 1700+ processor with a Asus A7S266 Motherboard. 
> If it is of any help, the header of de ACPI's FADT says:
> OEMID: ASUS OEM Table ID: A7S266VM
> OEM Revision: 1.0B
> Creator ID:  MSFT
> Creator Revision: 1011
> André.

Sory, I forgot the kernel version: 2.6.12-rc3-mm3, but It's also happens 
in 2.6.11.8, 2.6.12-rc3 and 2.6.12-rc4
André
