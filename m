Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293445AbSBYRji>; Mon, 25 Feb 2002 12:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293485AbSBYRje>; Mon, 25 Feb 2002 12:39:34 -0500
Received: from [195.63.194.11] ([195.63.194.11]:33541 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293445AbSBYRiM>; Mon, 25 Feb 2002 12:38:12 -0500
Message-ID: <3C7A763F.7060203@evision-ventures.com>
Date: Mon, 25 Feb 2002 18:37:03 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] Son of Unbork (1 of 3)
In-Reply-To: <Pine.GSO.4.21.0202251224150.3162-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sat, 23 Feb 2002, Daniel Phillips wrote:
> 
> 
>>This three patch set completes the removal of ext2-specific includes from 
>>fs.h.  When this is done, your kernel will compile a little faster, the Ext2 
>>source will be organized a little better, and then infamous fs.h super_block 
>>union will no longer hurt your eyes.  When every filesystem has been changed 
>>in a similar way, fs.h will finally be generic, in-memory super_blocks will be
>>somewhat smaller, and the kernel will compile quite a lot faster.  And peace
>>will come once more to Middle-Earth.  (I made that last part up.)
>>
>>Patch 1 adds alloc_super and destroy_super methods to struct file_system.  A 
>>
> 
> Vetoed.

Poczjemu? Why? It fits the concept of constructor and destructor - I'm 
just curious. I suppose some locking issues?

