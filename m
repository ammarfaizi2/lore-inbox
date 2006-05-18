Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWERFTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWERFTN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 01:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWERFTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 01:19:13 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:5024 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751161AbWERFTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 01:19:12 -0400
Message-ID: <446C03F4.20508@sbcglobal.net>
Date: Thu, 18 May 2006 00:19:48 -0500
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: Kumar Gala <galak@kernel.crashing.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH 1/6] kconfigurable resources core changes
References: <20060505172847.GC6450@in.ibm.com> <2C184B1B-9F70-4175-B90B-A1CC5741A6DE@kernel.crashing.org> <20060509200301.GA15891@in.ibm.com>
In-Reply-To: <20060509200301.GA15891@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:
> On Tue, May 09, 2006 at 02:33:48PM -0500, Kumar Gala wrote:
>> On May 5, 2006, at 12:28 PM, Vivek Goyal wrote:
>>
>>>
>>> o Core changes for Kconfigurable memory and IO resources. By  
>>> default resources
>>>  are 64bit until chosen to be 32bit.
>>>
>>> o Last time I posted the patches for 64bit memory resources but it  
>>> raised
>>>  the concerns regarding code bloat on 32bit systems who use 32 bit
>>>  resources.
>>>
>>> o This patch-set allows resources to be kconfigurable.
>>>
>>> o I have done cross compilation on i386, x86_64, ppc, powerpc,  
>>> sparc, sparc64
>>>  ia64 and alpha.
>>>
>>> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
>>> ---
>> [snip]
>>
>> I didn't think the bloat was a big issue based on the numbers you  
>> reported.  I'd still prefer to see us just move to a 64-bit resource  
>> on all systems.
> 
> I had also thought that bloat was not a big issue but Andrew thinks
> otherwise. Here is the link to the thread.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114626907106986&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114635425606186&w=2
> 
> In the latest patches, 64bit resources are default but one can force
> these to be 32bit.
> 

This may sound like a dumb question, but aside from code bloat, what are 
the performance issues involved in running 64-bit resources on 32-bit 
systems?  AKA, does it kill us x86 users to not have this switch, and by 
what kind of margin?  You can point if it's been said and I just haven't 
found it; I didn't see performance discussion in the last submission.

Thanks!
Matt

> Thanks
> Vivek
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

