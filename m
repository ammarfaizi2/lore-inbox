Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTILPny (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbTILPny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:43:54 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:62366 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S261732AbTILPnw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 11:43:52 -0400
Message-ID: <3F61E821.6070209@rackable.com>
Date: Fri, 12 Sep 2003 08:37:05 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Rose <krose+linux-kernel@krose.org>
CC: Maciej Soltysiak <solt@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
Subject: Re: NVIDIA proprietary driver problem
References: <87u17if7eu.fsf@nausicaa.krose.org>	<Pine.LNX.4.51.0309121553500.14124@dns.toxicfilms.tv> <87r82mf6j9.fsf@nausicaa.krose.org>
In-Reply-To: <87r82mf6j9.fsf@nausicaa.krose.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2003 15:43:52.0289 (UTC) FILETIME=[AA914510:01C37944]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Rose wrote:
> Maciej Soltysiak <solt@dns.toxicfilms.tv> writes:
> 
> 
>>>Sep 11 23:37:57 nausicaa kernel: 0: nvidia: Can't find an IRQ for your NVIDIA card!
>>>Sep 11 23:37:57 nausicaa kernel: 0: nvidia: Please check your BIOS settings.
>>>Sep 11 23:37:57 nausicaa kernel: 0: nvidia: [Plug & Play OS   ] should be set to NO
>>
>>I wonder why pnp os should be off?
>>Linux does support pnp, and is a pnp os. Isn't it?
>>
>>Have you tried disabling apic? Maybe it's an apic or irq routing bug?
> 
> 
> SMP without APIC doesn't make sense, but I suppose I could try running
> a non-SMP kernel to see if the problem goes away.  Still, APIC is
> active in test4 and the driver works there.


    Try without ACPI support.  At boot do acpi=off.

> 
> 
>>What motherboard is it?
> 
> 
> Tyan Tiger MP, dual Athlon MP 1800's.
> 
> Cheers,
> Kyle
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

