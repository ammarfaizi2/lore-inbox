Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313183AbSDQIsm>; Wed, 17 Apr 2002 04:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313238AbSDQIsl>; Wed, 17 Apr 2002 04:48:41 -0400
Received: from [195.63.194.11] ([195.63.194.11]:13331 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313183AbSDQIsk>; Wed, 17 Apr 2002 04:48:40 -0400
Message-ID: <3CBD2847.6010003@evision-ventures.com>
Date: Wed, 17 Apr 2002 09:46:15 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: "David S. Miller" <davem@redhat.com>, david.lang@digitalinsight.com,
        vojtech@suse.cz, rgooch@ras.ucalgary.ca, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <20020416.100610.115916272.davem@redhat.com> <20020416174022.25545@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>  I could be wrong, it's a 2.1.x kernel that they started with. I thought
>>  that was around the time the fix went in.
>>  
>>Again, I did the fix 6 years ago, thats pre-2.0.x days
>>
>>EXT2 has been little-endian only with proper byte-swapping support
>>across all architectures, since that time.
> 
> 
> My understanding it that Tivo behaves like some Amiga's here
> and has broken swapping of the IDE bus itself, not the ext2
> filesystem.
> 
> On PPC, we still have some historical horrible macros redefinitions
> in asm/ide.h to let APUS (PPC Amiga) deal with these.
> 
> Now, the problem of dealing with DMA along with the swapping is
> something scary. I beleive the sanest solution that won't please
> affected people is to _not_ support DMA on these broken HW ;)

No: the sane sollution would be to not support swapping disks between
those systems and other systems.

