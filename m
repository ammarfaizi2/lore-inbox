Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWJVITn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWJVITn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 04:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWJVITm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 04:19:42 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:49300 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S964829AbWJVITm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 04:19:42 -0400
Message-ID: <453B2997.5040809@qumranet.com>
Date: Sun, 22 Oct 2006 10:19:35 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <Pine.LNX.4.61.0610192212590.8142@yvahk01.tjqt.qr> <453877DB.4050704@qumranet.com> <200610211750.02559.arnd@arndb.de>
In-Reply-To: <200610211750.02559.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2006 08:19:41.0750 (UTC) FILETIME=[D2DFBD60:01C6F5B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Friday 20 October 2006 09:16, Avi Kivity wrote:
>   
>> Jan Engelhardt wrote:
>>     
>>>> +#ifndef __user
>>>> +#define __user
>>>> +#endif
>>>>    
>>>>         
>>> SHRUG. You should include <linux/compiler.h> instead of doing that. (And
>>> on top, it may happen that compiler.h is automatically slurped in like
>>> config.h, someone else could answer that)
>>>  
>>>       
>> This is for userspace.  If there's a better solution I'll happily
>> incorporate it.
>>     
>
> It should just work without this, when you do 'make headers_install'.
> See the top of scripts/Makefile.headersinst.
>
> 	Arnd <><
>   

I'll remove it.  Thanks.

-- 
error compiling committee.c: too many arguments to function

