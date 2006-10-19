Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946148AbWJSQJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946148AbWJSQJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946155AbWJSQJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:09:46 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:58224 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1946148AbWJSQJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:09:45 -0400
Message-ID: <4537A343.1050008@qumranet.com>
Date: Thu, 19 Oct 2006 18:09:39 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <p73lkncb8b4.fsf@verdi.suse.de>
In-Reply-To: <p73lkncb8b4.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 16:09:44.0134 (UTC) FILETIME=[FD90C660:01C6F398]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Avi Kivity <avi@qumranet.com> writes:
>
>   
>> The following patchset adds a driver for Intel's hardware virtualization
>> extensions to the x86 architecture.  The driver adds a character device
>> (/dev/kvm) that exposes the virtualization capabilities to userspace.  Using
>> this driver, a process can run a virtual machine (a "guest") in a fully
>> virtualized PC containing its own virtual hard disks, network adapters, and
>> display.
>>
>> Using this driver, one can start multiple virtual machines on a host.  Each
>> virtual machine is a process on the host; a virtual cpu is a thread in that
>> process.  kill(1), nice(1), top(1) work as expected.
>>     
>
> Where is the user space for this? Is it free? 
>   

I have to go through the motions of creating a sourceforge project for 
this and uploading it.  And yes, it is free.

> I suppose you need a device model. Do you use qemu's?
>   

Yes.  I can't imagine anyone doing that work from scratch (Xen also uses 
qemu).

-- 
error compiling committee.c: too many arguments to function

