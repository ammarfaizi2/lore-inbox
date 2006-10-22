Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751801AbWJVSAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWJVSAY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 14:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWJVSAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 14:00:24 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:62801 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1751804AbWJVSAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 14:00:22 -0400
Message-ID: <453BB1B0.7040500@qumranet.com>
Date: Sun, 22 Oct 2006 20:00:16 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Avi Kivity <avi@qumranet.com>,
       Arnd Bergmann <arnd@arndb.de>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <200610221723.48646.arnd@arndb.de> <453B99D7.1050004@qumranet.com> <200610221851.06530.arnd@arndb.de> <453BA3E9.4050907@qumranet.com> <20061022175609.GA28152@infradead.org>
In-Reply-To: <20061022175609.GA28152@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2006 18:00:21.0642 (UTC) FILETIME=[F1115EA0:01C6F603]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Oct 22, 2006 at 07:01:29PM +0200, Avi Kivity wrote:
>   
>>> What is the point of 32 bit hosts anyway? Isn't this only available
>>> on x86_64 type CPUs in the first place?
>>>  
>>>       
>> No, 32-bit hosts are fully supported (except a 32-bit host can't run a 
>> 32-bit guest).
>>     
>
> Again, what's the point?  All cpus shipped by Intel and AMD that have
> hardware virtualization extensions also support the 64bit mode.  Given
> that I don't see any point for supporting a 32bit host.
>   

Existing installations?

Dropping 32-bit host support would certainly kill a lot of #ifdefs and 
reduce the amount of testing needed.  It would also force me to upgrade 
my home machine.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

