Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbUCSV7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 16:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbUCSV7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 16:59:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51162 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262490AbUCSV67
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 16:58:59 -0500
Message-ID: <405B6D15.9030600@pobox.com>
Date: Fri, 19 Mar 2004 16:58:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: FYI: SATA on x86-64
References: <405B6B6B.70200@pobox.com> <405B6C6B.4050202@stesmi.com>
In-Reply-To: <405B6C6B.4050202@stesmi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski wrote:
> Jeff Garzik wrote:
> 
>>
>> There appear to be a variety of platform problems that lead to trouble 
>> with libata (and also with the IDE driver to some extent), with the 
>> default x86-64 kernel + some buggy BIOSes + some iommu weirdness.
>>
>> Here are some boot options to mix and match:
>>     nomce, iommu=off, noapic, acpi=off
>>
>> And also try using an SMP kernel (CONFIG_SMP) rather than a 
>> uniprocessor one.
> 
> 
> You have any special place where one or several options might be useful?
> 
> I stressed the promise sata on my ASUS K8V with a Maxtor disk yesterday
> and it worked just fine. Under 2.4 that is. And yes, running an x86_64
> kernel.

If you don't need any of those options, then no worries.  You are fine 
as-is.

	Jeff



