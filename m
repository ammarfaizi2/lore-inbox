Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbUK3QNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbUK3QNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUK3QNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:13:38 -0500
Received: from alog0096.analogic.com ([208.224.220.111]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262153AbUK3QLj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:11:39 -0500
Date: Tue, 30 Nov 2004 11:10:42 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: P@draigBrady.com
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Walking all the physical memory in an x86 system
In-Reply-To: <41AC9972.2070305@draigBrady.com>
Message-ID: <Pine.LNX.4.61.0411301108350.9545@chaos.analogic.com>
References: <C863B68032DED14E8EBA9F71EB8FE4C2057CA887@azsmsx406>
 <Pine.LNX.4.53.0411301654360.20450@yvahk01.tjqt.qr> <41AC9972.2070305@draigBrady.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004 P@draigBrady.com wrote:

> Jan Engelhardt wrote:
>>> 	I've written a 2.4 kernel module where I'm trying to walk and
>>> record all of the physical memory contents in an x86 system. I have the
>>> following code fragment that does it but I suspect I'm missing a portion
>>> of the memory:
>>> 
>>> Is there a better way to record all of the contents of physical memory
>>> since what I have above doesn't seem to get everything?
>> 
>> 
>> Maybe something userspace based?
>> 
>> dd_rescue /dev/mem copyofmem
>
> Doesn't equate to a power of 2
> (nor does `grep MemTotal /proc/meminfo`)
>
> Pdraig.
> -


Kernel variable "num_physpages" tells how many pages the kernel
knows about.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
