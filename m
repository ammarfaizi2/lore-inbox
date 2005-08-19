Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVHSP7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVHSP7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVHSP7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:59:04 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:55044 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S1751147AbVHSP7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:59:01 -0400
Message-ID: <430601C5.5080505@pantasys.com>
Date: Fri, 19 Aug 2005 08:59:01 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Sean Bruno <sean.bruno@dsl-only.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-git10 test report [x86_64](WITHOUT NVIDIA MODULE)
References: <1124401950.14825.13.camel@home-lap.suse.lists.linux.kernel> <p73u0hmsy83.fsf@verdi.suse.de> <1124405533.14825.24.camel@home-lap> <20050818230349.GC22993@wotan.suse.de> <1124410753.14825.32.camel@home-lap> <4305FCF1.6020905@pantasys.com> <20050819154639.GL22993@wotan.suse.de> <4306002F.4000000@pantasys.com> <20050819155332.GM22993@wotan.suse.de>
In-Reply-To: <20050819155332.GM22993@wotan.suse.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2005 15:58:46.0984 (UTC) FILETIME=[E1E62480:01C5A4D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Fri, Aug 19, 2005 at 08:52:15AM -0700, Peter Buckingham wrote:
> 
>>Andi Kleen wrote:
>>
>>>At least his original error message can only happen when  CONFIG_GART_IOMMU
>>>is disabled.
>>>
>>>PCI-DMA:  More that 4GB of RAM and no IOMMU                                
>>>PCI-DMA:  32bit PCI IO may malfunction.<6>PCI-DMA:  Disabling IOMMU        
>>
>>Yeah, I agree. In the later dmesgs, though, it seems to be enabled.
> 
> 
> Those don't show any failure.

no they don't. basically it just says your bios hasn't configured enough 
IOMMU space, so the kernel is going to do it anyway. it's really just a 
warning or an fyi rather than an error. i may have chosen the word 
poorly ;-)

in short Sean, this isn't a big deal. you only really need to change 
this if you want to remove a warning from your dmesg output.

peter
