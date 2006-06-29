Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWF2S5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWF2S5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWF2S5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:57:01 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:22939 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751267AbWF2S5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:57:00 -0400
Message-ID: <44A42276.8070108@us.ibm.com>
Date: Thu, 29 Jun 2006 11:56:54 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Greg KH <gregkh@suse.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: 2.6.17-git14 compile failure & fix
References: <44A40874.20202@us.ibm.com>	<20060629172016.GA23736@suse.de> <20060629112952.c7231034.akpm@osdl.org>
In-Reply-To: <20060629112952.c7231034.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 29 Jun 2006 10:20:16 -0700
> Greg KH <gregkh@suse.de> wrote:
>
>   
>> On Thu, Jun 29, 2006 at 10:05:56AM -0700, Badari Pulavarty wrote:
>>     
>>> Hi,
>>>
>>> I get "unknown definition" compile failure while compiling 2.6.17-git14
>>> with CONFIG_MEMORY_HOTPLUG. (kernel/resource.c line: 243) -
>>> due to recent changes to it.
>>>
>>> Here is the patch to fix it. I can't take credit for the patch, since its
>>> part of GregKH resource_t  patches :)
>>>       
>> Ick, yeah, that's a fix,
>>     
>
> Oh crap, sorry, patch skew.  That never turned up in my cross-compiling :(
>
> (It's *really hard* to turn on CONFIG_MEMORY_HOTPLUG.  Even ia64
> allmodconfig won't do it).
>   
Don't feel sorry. I happen to find it by accident :)

Thanks,
Badari

