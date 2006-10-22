Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWJVSlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWJVSlN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 14:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWJVSlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 14:41:12 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:35738 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1750786AbWJVSlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 14:41:11 -0400
Message-ID: <453BBB41.4070905@qumranet.com>
Date: Sun, 22 Oct 2006 20:41:05 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Christoph Hellwig <hch@infradead.org>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <20061022175609.GA28152@infradead.org> <453BB1B0.7040500@qumranet.com> <200610222036.03455.arnd@arndb.de>
In-Reply-To: <200610222036.03455.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2006 18:41:10.0533 (UTC) FILETIME=[A4B87B50:01C6F609]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Sunday 22 October 2006 20:00, Avi Kivity wrote:
>   
>> Existing installations?
>>
>> Dropping 32-bit host support would certainly kill a lot of #ifdefs and
>> reduce the amount of testing needed.  It would also force me to upgrade
>> my home machine.
>>     
>
> Ok, but if you radically change the kernel<->user API, doesn't that mean
> you have to upgrade in the same way? 

No, why? I'd just upgrade the userspace.  Am I misunderstanding you?

> The 32 bit emulation mode in x86_64
> is actually pretty complete, so it probably boils down to a kernel upgrade
> for you, without having to touch any of the user space.
>   

For me personally, I don't mind.  I don't know about others.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

