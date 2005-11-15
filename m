Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVKOEWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVKOEWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 23:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVKOEWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 23:22:20 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:24960 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S932365AbVKOEWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 23:22:20 -0500
Message-ID: <43795C55.9080305@wolfmountaingroup.com>
Date: Mon, 14 Nov 2005 20:56:05 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <58XuN-29u-17@gated-at.bofh.it> <58XuN-29u-19@gated-at.bofh.it> <58XuN-29u-21@gated-at.bofh.it> <58XuN-29u-23@gated-at.bofh.it> <58XuN-29u-25@gated-at.bofh.it> <58XuN-29u-15@gated-at.bofh.it> <58YAt-3Fs-5@gated-at.bofh.it> <58ZGo-5ba-13@gated-at.bofh.it> <5909m-5JB-5@gated-at.bofh.it> <43795F35.3050904@shaw.ca>
In-Reply-To: <43795F35.3050904@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:

> Jeff V. Merkey wrote:
>
>> Why does the kernel need to be limited to 4K? for kernel preemption?
>
>
> No, because it makes a whole lot of things simpler and more reliable 
> if the kernel stack is only one page.
>
>>
>> Someone needs to fix this. It's busted. It makes porting code between 
>> Windows and Linux and other OS's difficult to support.
>
>
> Ease of porting drivers written for other OSes to Linux is clearly not 
> a high priority for the kernel community..


What?  There's more kernel apps than just ndis network drivers that get 
ported.  ndiswrapper is busted (which is used for a lot of laptops)
without 4K stacks.  My laptop is a Compaq and there isn't a Linux driver 
for the wireless.  I also discovered Fedora Core 4 won't install
on a Compaq Presario with SATA (stacks crashes). 

What are you saying?   People with wireless and laptops who run Linux 
can't because ndiswrapper is busted without 8K stacks?

Should be a configurable option 4-16K -- set at RUN TIME on the COMMAND 
LINE of the BOOT LOADER.   Peopl can set
profile=? why not kernel default stack size.   That way Fedora, ES, AS, 
and Suse can run out of the box on laptops like Windows,
or is M$ going to keep owning the desktop?
 
Jeff

