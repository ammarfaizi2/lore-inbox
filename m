Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267795AbUKAQSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267795AbUKAQSR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 11:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275075AbUKAQSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 11:18:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:9860 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268708AbUKAQR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 11:17:58 -0500
Message-ID: <41865F22.4010203@osdl.org>
Date: Mon, 01 Nov 2004 08:06:58 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: Christoph Hellwig <hch@infradead.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: Disambiguation for panic_timeout's sysctl
References: <Pine.LNX.4.53.0410311721470.20529@yvahk01.tjqt.qr> <20041101120227.GA24626@suse.de> <20041101120411.GA26958@infradead.org> <20041101120704.GB24626@suse.de>
In-Reply-To: <20041101120704.GB24626@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
>  On Mon, Nov 01, Christoph Hellwig wrote:
> 
> 
>>On Mon, Nov 01, 2004 at 01:02:27PM +0100, Olaf Hering wrote:
>>
>>> On Sun, Oct 31, Jan Engelhardt wrote:
>>>
>>>
>>>>
>>>>The /proc/sys/kernel/panic file looked to me like it was something like
>>>>/proc/sysrq-trigger -- until I looked into the kernel sources which reveal that
>>>>it sets the variable "panic_timeout" in kernel/sched.c.
>>>
>>>This will probably break applications that expect the filename 'panic'.
>>
>>And why should applications care for the panic timeout?  Especially only
>>a few days after it's been added to the kernel?
> 
> 
> /proc/sys/kernel/panic exists since at least 2.6.5.
> Its used to override the silly default '0' on i386, but one should be
> able to boot with panic=$bignum

It's not new.  It's in 2.4.26.
And it's documented in Documentation/kernel-parameters.txt,
so any patch that changes it should also change that .txt file.



-- 
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
