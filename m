Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSBXTsk>; Sun, 24 Feb 2002 14:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290818AbSBXTsa>; Sun, 24 Feb 2002 14:48:30 -0500
Received: from [195.63.194.11] ([195.63.194.11]:17426 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S290797AbSBXTsV>; Sun, 24 Feb 2002 14:48:21 -0500
Message-ID: <3C79435E.8030208@evision-ventures.com>
Date: Sun, 24 Feb 2002 20:47:42 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [PATCH] IDE clean 12 3rd attempt
In-Reply-To: <UTC200202241352.g1ODqeb08003.aeb@apps.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>>Since this apparently didn't get through to the mailing list
>>I'm sending it again. This time compressed.
>>
> 
> Pity - noncompressed is better, now only people with too much time
> will look at it.
> 
> There is something else one might do.
> In ide-geometry.c there is the routine probe_cmos_for_drives().
> Long ago I already wrote "Eventually the entire routine below
> should be removed". I think this is the proper time to do this.
> 
> This probe is done only for the i386 architecture, and only
> for the first two IDE disks, and only influences their geometry.
> It has been a pain - for example, it gives the first two disks
> a different geometry from the others, which is inconvenient
> when one want a RAID of identical disks.
>
Basically I lend toward your arguments. I think too that a bios based
detection is already right and then we have now the ide-skip kernel
parameter which is allowing to exclude a drive from handling by the 
linux ide driver anyway. And I think that 2.4.x and above don't run on
i386's anymore anyway.



