Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946396AbWJST3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946396AbWJST3C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423230AbWJST3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:29:01 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:2269 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1423225AbWJST3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:29:00 -0400
Message-ID: <4537D1FA.9090502@us.ibm.com>
Date: Thu, 19 Oct 2006 14:28:58 -0500
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <p73lkncb8b4.fsf@verdi.suse.de> <4537A343.1050008@qumranet.com> <4537CBB2.2080701@us.ibm.com> <4537CEAB.4030809@qumranet.com>
In-Reply-To: <4537CEAB.4030809@qumranet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Anthony Liguori wrote:
>>>
>>> I have to go through the motions of creating a sourceforge project 
>>> for this and uploading it.  And yes, it is free.
>>
>> Don't even bother creating a project.  Just submit the patches back 
>> to QEMU.  There's been a lot of discussion about this functionality 
>> within QEMU.  There's no reason to fork QEMU yet again (Xen has given 
>> up and is now maintaining a patch queue).  In this case, there's no 
>> reason why you would even need a patch queue.
>
> We don't plan to fork qemu, too much good stuff is being added there.  
> However I want to submit the patch for inclusion only after (if?) the 
> driver is merged into the mainline kernel.  The patch is also not very 
> pretty at the moment.

I would recommend the opposite approach.  Something can go in QEMU more 
quickly than in the kernel and you'll get people actually testing it.  
If it gets in the kernel and there's no major userspace presence you 
won't have nearly the same amount of testers...

Regards,

Anthony Liguori

> I'll post it as a patch and probably a binary rpm for the lazy.
>
>

