Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbUCIULe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 15:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUCIUJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 15:09:54 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:61058 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262132AbUCIUIt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 15:08:49 -0500
Message-ID: <404E258E.1030600@tmr.com>
Date: Tue, 09 Mar 2004 15:14:06 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hyper-threaded pickle
References: <1wfBD-6GI-9@gated-at.bofh.it> <1whjQ-8sH-25@gated-at.bofh.it> <1wMeo-Sr-3@gated-at.bofh.it> <1xlbI-6Rl-5@gated-at.bofh.it>
In-Reply-To: <1xlbI-6Rl-5@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
>>>Re: old systems -- we use dmi_scan to disable ACPI on systems by default
>>>on systems older than 1/1/2001.
>>
>>What happens for the no-DMI case?
> 
> 
> When DMI is not present, dmi_scan is a no-op -- so ACPI will run in
> whatever default the system is set to -- eg. "off" for FC1, and "on" for
> FC2-test1.
> 
> We've found in practice that dmi_scan has been pretty effective at
> identifying the set of systems new enough to have an ACPI enabled BIOS
> but old enough that the ACPI implementation is hopeless.  Though we've
> had many reports of 1/1/2001 being a bit *too* conservative -- disabling
> ACPI on systems where ACPI works fine.  Indeed, there is a bugzilla
> requesting a "white-list" to enable exceptions to this date.  I'm not
> enthusiastic about that plan, however.  I figure there are more 3-year
> old boxes that have been running Linux w/o ACPI than there are those
> which have; and I'd rather spend my ergs on the current and upcoming
> boxes where vendors are more willing to update a broken BIOS...

Even though I have some boxes which are hurt by this, I have to agree, 
although I wouldn't be unhappy if there were a few more options to 
enable just parts of ACPI. There are more important things, however, and 
since I can live with ACPI=force or no acpi at all it's an annoyance 
rather than an issue.

I have a few machines which are never going to 2.6 because their ACPI is 
totally broken and 2.6 APC no longer functions to turn the machine off. 
Since I expect 2.4 to be viable longer than the machines, I have no 
issues with that, either. If I don't have time to look at it why should 
I ask anyone else?
