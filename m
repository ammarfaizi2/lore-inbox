Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTIOXVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTIOXVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:21:25 -0400
Received: from [141.154.95.10] ([141.154.95.10]:34015 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S261722AbTIOXVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:21:17 -0400
Message-ID: <3F664941.6000206@ximian.com>
Date: Mon, 15 Sep 2003 19:20:33 -0400
From: Kevin Breit <mrproper@ximian.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Meadors <clubneon@hereintown.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Need fixing of a rebooting system
References: <1063496544.3164.2.camel@localhost.localdomain>	 <Pine.LNX.4.53.0309131945130.3274@montezuma.fsmlabs.com>	 <3F6450D7.7020906@ximian.com>	 <Pine.LNX.4.53.0309140904060.22897@montezuma.fsmlabs.com>	 <1063561687.10874.0.camel@localhost.localdomain>	 <Pine.LNX.4.53.0309141741050.5140@montezuma.fsmlabs.com>	 <3F64FEAF.1070601@ximian.com>	 <Pine.LNX.4.53.0309142055560.5140@montezuma.fsmlabs.com>	 <1063650478.1516.0.camel@localhost.localdomain>	 <1063653132.224.32.camel@clubneon.priv.hereintown.net>	 <3F66249A.3020308@ximian.com> <1063664654.19299.10.camel@clubneon.clubneon.com>
In-Reply-To: <1063664654.19299.10.camel@clubneon.clubneon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Meadors wrote:

>On Mon, 2003-09-15 at 16:44, Kevin Breit wrote:
>
>  
>
>>/proc/cpuinfo says:
>>
>>model name:   Celeron (Coppermine)
>>
>>So my configuration for the first 5 main menu items that are enabled in 
>>makeconfig are:
>>
>>* Prompt for developer and/or incomplete code/drivers
>>  * Select only drivers expected to compile cleanly
>>  * Select only drivers that don't need compile-time external firmware
>>
>>* Support for paging of anonymous memory
>>   * System V IPC
>>   * BSD Process Accounting
>>   * Sysctl support
>>* Subarchitecture Type (PC-compatible)
>>* Processor family (Pentium-II/Celeron(pre-Coppermine))
>>    
>>
>
>You can pick the Pentium-III here, since you have a Coppermine core
>Celeron.  But this will almost surely not be any part of the solution to
>the problem.
>  
>
I didn't think it would make a difference.

>>* Preemptible Kernel
>>* Machine Check Exception
>>* /dev/cpu/microcode
>>* /dev/cpu/*/msr
>>* /dev/cpu/*/cpuid
>>* BIOS Enhanced Disk Drive calls determine boot disk
>>    
>>
>
>I'd turn this off, just to see if it makes any change.  It says it is
>"believed to be safe", but it is experimental, and your controller BIOS
>almost surely does not support it.
>  
>
I turned this off.  I'll report my findings shortly.

>>* Power Management support
>>   *Full ACPI Support (minus the ASUS Laptop Extras and Toshiba Laptop 
>>Extras)
>>
>>Do you see anything in that list which I should look into ditching first?
>>    
>>
>
>Other than the EDD setting, I see nothing.  What do you have in the next
>choice after ACPI, the APM stuff?
>  
>
I have all the ACPI stuff enabled and no APM enabled.  I do not have 
ACPI debuggging statements enabled.

>Also, can you see anything on the screen before it reboots?  There is
>nothing after "Uncompressing kernel..."?  Just boom, it reboots?
>  
>
It says Uncompressing kernel....................gives the message saying 
the uncompression is done and then reboots.  The time between finishing 
the uncompression and rebooting is about .1 sec.

>There isn't much that can trigger a reboot that early on.
>  
>
I figured that, which is why I am asking for help about where to disable 
things?

Thanks

Kevin Breit

