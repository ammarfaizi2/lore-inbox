Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVCPFbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVCPFbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 00:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVCPFbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 00:31:13 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:57789 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262525AbVCPF2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 00:28:48 -0500
Message-ID: <4237C40C.6090903@sbcglobal.net>
Date: Wed, 16 Mar 2005 00:28:44 -0500
From: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041223
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 USB broken on VIA computer (not just ACPI)
References: <4237A5C1.5030709@sbcglobal.net> <20050315203914.223771b2.akpm@osdl.org>
In-Reply-To: <20050315203914.223771b2.akpm@osdl.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I never actually saw it work until I added the noapic option to the 
2.6.11.2 boot.  Now I can usually my USB mouse!  Of course the downside 
to specifying noapic is only one CPU is servicing interrupts on my SMP 
system.

It certainly doesn't work under 2.4.28, but I haven't tried specifying 
noapic to that kernel.  Would that be useful information?

Andrew Morton wrote:
> "Robert W. Fuller" <orangemagicbus@sbcglobal.net> wrote:
> 
>>This isn't limited to the ACPI case.  My BIOS is old enough that ACPI is 
>> not supported because the kernel can't find RSDP.  I found that the USB 
>> works if I boot with "noapic."  This is probably sub-optimal on an SMP 
>> machine.  If don't boot with "noapic" I get the following errors:
> 
> 
> Did it work OK under previous kernels?  If so, which versions?
> 
