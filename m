Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWC3U2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWC3U2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWC3U2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:28:11 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:2072 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750871AbWC3U1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:27:49 -0500
Message-ID: <442AE0CD.1090707@tmr.com>
Date: Wed, 29 Mar 2006 14:32:29 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
CC: Jeff Garzik <jeff@garzik.org>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: e2label suggestions
References: <4429AF42.1090101@soleranetworks.com> <20060328232927.GB32385@thunk.org> <4429D3E4.3060305@wolfmountaingroup.com> <4429D11F.6040000@garzik.org> <4429E050.7080008@soleranetworks.com> <20060329014048.GA29971@thunk.org> <4429F247.90209@soleranetworks.com>
In-Reply-To: <4429F247.90209@soleranetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> Theodore Ts'o wrote:
> 
>> On Tue, Mar 28, 2006 at 06:18:08PM -0700, Jeff V. Merkey wrote:
>>  
>>
>>> Thanks for verifying it is passed through the kernel to initrd, 
>>> another kernel component.    It's also stored as EXT meta data
>>> (also in the kernel).  and retrieved from there.  And its not 
>>> accessible from normal user space applications (except in raw mode).
>>>   
>>
>> No, the contents of initrd/initramfs is not shipped as part of a
>> standard kernel.org kernel.  It is the responsibility of each
>> distribution to set up their initrd or initramfs initial boot scripts
>> themselves.  One could argue that it would be better if there were a
>> standard set of initrd scripts (and udev binaries) paired with
>> specific kernel.org kernels and used by all distro's, but that's not
>> where we are right now.
>>
>>  
>>
> ????????
> 
>> The data is most certainly accessible from normal userspace
>> applications.  All they have to do is link against blkid library;  
>>
> All you need is a degree from MIT in advanced Fusion mechanics. :-)
> 
>> indeed the kernel doesn't do any LABEL= or UUID= searching at all.  By
>> design, it all supposed to be done in userspace.
>>  
>>
> ?????????
> 
> Ted,
> 
> I give up on this one. I also agree a standardized initrd with built in 
> init is a great idea.

It's a great idea until you ask which init script will be used and 
forced on all the other vendors. Or all the vendors, let's standardize 
on my script, or your script, or Linus' script.

Better yet, let's leave it alone, because even if there were a script 
with the kernel, it would not be a standard ir would only be a default. 
All the vendors do their own thing because they feel it's best, and 
that's not going to change (not probably should it).

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

