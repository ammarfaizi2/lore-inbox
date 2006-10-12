Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWJLXqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWJLXqJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 19:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWJLXqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 19:46:09 -0400
Received: from mga07.intel.com ([143.182.124.22]:34321 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751323AbWJLXqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 19:46:06 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,301,1157353200"; 
   d="scan'208"; a="130346812:sNHT28949543"
Message-ID: <452ED33A.6000106@foo-projects.org>
Date: Thu, 12 Oct 2006 16:43:54 -0700
From: Auke Kok <sofar@foo-projects.org>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Aleksey Gorelov <dared1st@yahoo.com>
CC: xhejtman@mail.muni.cz, linux-kernel@vger.kernel.org, magnus.damm@gmail.com,
       pavel@suse.cz
Subject: Re: Machine reboot
References: <20061012232456.69718.qmail@web83115.mail.mud.yahoo.com>
In-Reply-To: <20061012232456.69718.qmail@web83115.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksey Gorelov wrote:
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org 
>> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Lukas 
>> Hejtmanek
>> Sent: Thursday, October 05, 2006 3:53 AM
>> To: linux-kernel@vger.kernel.org
>> Subject: Machine reboot
>>
>> Hello,
>>
>> I'm facing troubles with machine restart. While sysrq-b 
>> restarts machine, reboot
>> command does not. Using printk I found that kernel does not 
>> hang and issues
>> reset properly but BIOS does not initiate boot sequence. Is 
>> there something
>> I could do?
> 
>   I have similar issue on Intel DG965WH board. Did you try to shutdown network interface and
> 'rmmod e1000' right before reboot ? In my case machine reboots fine after that.
> 
> Aleks.

interesting, do you do that because it specifically fixes a problem you have? if so, I'd 
like to know about it :)

Auke
