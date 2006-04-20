Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWDTQfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWDTQfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWDTQfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:35:36 -0400
Received: from fmr19.intel.com ([134.134.136.18]:20864 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751081AbWDTQff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:35:35 -0400
Message-ID: <4447B850.7090108@linux.intel.com>
Date: Thu, 20 Apr 2006 20:35:28 +0400
From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <20060420161546.GB30021@srcf.ucam.org> <4447B692.3000704@linux.intel.com> <20060420163222.GA30197@srcf.ucam.org>
In-Reply-To: <20060420163222.GA30197@srcf.ucam.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Thu, Apr 20, 2006 at 08:28:02PM +0400, Alexey Starikovskiy wrote:
> 
>> I don't quite understand your point... You want all buttons/switches in a 
>> computer to send events to input layer, regardless if this make sense or 
>> not, just to be consistent? May be you should go other way around and  if 
>> keyboard has some strange key, send it on its strange way? 
> 
> There's a reason that KEY_POWER and KEY_SLEEP are already present in 
> /usr/include/linux/input.h. It makes sense to expose keys that are on my 
> keyboard in the same way as other keys on my keyboard. Just think of the 
> ACPI events interface as a bus that a small keyboard with not many keys 
> sits on.
> 
>>From the userspace point of view, it's *far* easier to deal with this 
> stuff if the keys generate keycodes.
Lid is a _switch_ with state, how many keys on keyboard have same behavior? Do you want to introduce special case just for that?
 
