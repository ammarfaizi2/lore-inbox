Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422869AbWBNXNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422869AbWBNXNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422872AbWBNXNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:13:43 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:42712 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1422869AbWBNXNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:13:42 -0500
Date: Tue, 14 Feb 2006 17:13:40 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Compaq X1050 multiple suspend problems (ACPI, PS2)
In-reply-to: <3ACA40606221794F80A5670F0AF15F840AEE20B9@pdsmsx403>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43F26424.8040708@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <3ACA40606221794F80A5670F0AF15F840AEE20B9@pdsmsx403>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No difference there either.. The contents of 
/proc/acpi/embedded_controller/C0EA/info both before and after suspend are:

gpe bit:                 0x1c
ports:                   0x66, 0x62
use global lock:         no

I'll open a Bugzilla report.

Yu, Luming wrote:
>> I have not seen any ACPI errors other than during suspend/resume.
>>
>> Tried ec_intr=0 option on the command line, same problem.
>>
>> ACPI_EC_DELAY=100 patch did not help either, same or at least similar 
>> problem. Output attached.
>>
> 
> Please try boot with lapic. I'm NOT sure if it is irq related resume
> issue.
> After resume, please try cat /proc/acpi/embedded_controller/*/info.
> Please test if it do the trick.
> 
> If still not, please file a bug in ACPI category on bugzilla.kernel.org.
> 
> 
> Thanks,
> Luming
> 
