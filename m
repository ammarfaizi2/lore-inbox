Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278735AbRJZQN0>; Fri, 26 Oct 2001 12:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278723AbRJZQNR>; Fri, 26 Oct 2001 12:13:17 -0400
Received: from [207.8.4.6] ([207.8.4.6]:12647 "EHLO one.interactivesi.com")
	by vger.kernel.org with ESMTP id <S278735AbRJZQNK>;
	Fri, 26 Oct 2001 12:13:10 -0400
Message-ID: <3BD98BAC.9060503@interactivesi.com>
Date: Fri, 26 Oct 2001 11:13:32 -0500
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Allocating more than 890MB in the kernel?
In-Reply-To: <200110250404.f9P44KM162546@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:

> 1. reserve a 3 GB chunk of memory at boot
> 2. create a regular user process
> 3. have that process make a system call which will never return
> 4. in that system call, wipe out all memory mappings in the process
> 5. hand-craft a 3 GB memory mapping (0 GB virt --> 1 GB phys)
> 6. call your desired code, remembering to schedule by hand


Thanks, that's the most useful idea I've gotten.  It's crazy, but it just 
might work!

Too bad no one else on this list can think outside of the box like you just did.

