Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTE3J71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 05:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTE3J71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 05:59:27 -0400
Received: from catv-50622120.szolcatv.broadband.hu ([80.98.33.32]:40065 "EHLO
	catv-50622120.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S263535AbTE3J70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 05:59:26 -0400
Message-ID: <3ED72E97.7060008@freemail.hu>
Date: Fri, 30 May 2003 12:12:39 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm2
References: <3ED70B9A.5050104@freemail.hu> <20030530012710.57cca756.akpm@digeo.com> <3ED728DF.8030203@freemail.hu>
In-Reply-To: <3ED728DF.8030203@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boszormenyi Zoltan wrote:

> Andrew Morton wrote:
>
>> Boszormenyi Zoltan <zboszor@freemail.hu> wrote:
>>  
>>
>>> Hi,
>>>
>>> I am testing it now with your two extra patches.
>>> I started vmware but I don't notice it now. Everything is snappy.
>>> The system is a RH9 with upgrades. The latest errata kernel still
>>> stops for seconds sometimes and vmware (and rsync between two drives
>>> for that matter) makes a noticable performance impact. With .70-mm2,
>>> I can still work on other things and not wait for other things to
>>> finish first.
>>>   
>>
>>
>> OK, thanks. 
>

I am running it now, it seems rock solid.
Two rsync and one "cp -ar" a 2.4 GB directory between the same two drives
are finishing faster than with RH9 kernel-smp-2.4.20-13.9. :-)

> OK. :-) However, "modprobe capability" is still not automatic.
> What is the alias line for capability? I can't figure it out myself.
> Perhaps it's not supported configuring capability
> (aka CONFIG_SECURITY_CAPABILITIES) as a module?
> It's definitely allowed...


OK, compiled as built-in, not too many problems left.
I will still have to fiddle with alias lines for USB to not complain on 
boot.
I don't have any USB devices though.

Best regards,
Zoltán Böszörményi


