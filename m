Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266984AbSK2I7N>; Fri, 29 Nov 2002 03:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbSK2I7N>; Fri, 29 Nov 2002 03:59:13 -0500
Received: from pilt.cultus.no ([194.248.142.50]:20751 "EHLO pilt.cultus.no")
	by vger.kernel.org with ESMTP id <S266984AbSK2I7M>;
	Fri, 29 Nov 2002 03:59:12 -0500
Message-ID: <3DE72E22.2030405@cultus.no>
Date: Fri, 29 Nov 2002 10:06:42 +0100
From: Jens-Christian Skibakk <jens@cultus.no>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Radeon DRM oops in 2.4.20-rc4-ac1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now I can start the X-Window system, and glxinfo report direct redering 
as enabled.

But when I test the glxgears I get Illegal instruction, the same error 
also happens for tuxracer.
If I turn the DRI of in the XF86Config-4 file, glxgears runs fine, but 
without HW redering.



---
Jens-Christian Skibakk



Alex Riesen wrote:


>>On Fri, Nov 29, 2002 at 09:15:17AM +0100, Jens-Christian Skibakk wrote:
>>  
>>
>  
>
>>>>Nov 29 08:54:37 debian kernel: Call Trace:    [radeon_cp_init+120/164] 
>>>>[radeon_ioctl+216/228] [sys_ioctl+605/628] [system_call+51/56]
>>>>Nov 29 08:54:37 debian kernel:
>>>>Nov 29 08:54:37 debian kernel: Code: 89 10 57 e8 3c f0 ff ff 57 56 e8 89 
>>>>f4 ff ff c7 47 44 00 00
>>>>
>>>>
>>>>The Oops happens when i start the X-Window system with DRI enabled.
>>>>    
>>>>
>>    
>>
>>
>>could you try the link below?
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=103839583129724&w=2
>>  
>>
>  
>


