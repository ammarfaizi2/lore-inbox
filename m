Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281128AbRKENJP>; Mon, 5 Nov 2001 08:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281134AbRKENJF>; Mon, 5 Nov 2001 08:09:05 -0500
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:13709 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S281128AbRKENIz>;
	Mon, 5 Nov 2001 08:08:55 -0500
Message-ID: <3BE68F75.3010300@stesmi.com>
Date: Mon, 05 Nov 2001 14:09:09 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Zack Weinberg <zack@codesourcery.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.20a and gcc 3.0 ?
In-Reply-To: <20011104192024.H267@codesourcery.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>gcc-2.95.4 does not exist! The latest stable release is 2.95.3.
>>>>
>>>Ah, it does exist. You have to check it out from CVS from the GCC people.
>>>I've no doubt a release will be made soon.
>>>
>>That's what's called a not released product.
>>
>>2.95.4 might or might not be released shortly.
>>
>>It is not the final 2.95.4 that is in the CVS.
>>
>>Another word for it might be BETA...
>>
> 
> We're being extremely conservative about patches applied to the 2.95.x
> CVS branch.  It is intended always to be release-quality material.

I am aware of this.

> I'm not aware of any plans for an official 2.95.4 anytime soon.
> However, system integrators often track that CVS branch with their GCC
> packages.  For instance:
> 
> $ gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
> gcc version 2.95.4 20011006 (Debian prerelease)

I know how it's done, it's just that in my eyes a stable release is the 
one where you know there's only 1 .... A 2.95.4 package built on 
different days (from CVS) will differ. A 2.95.4 package built on 
different ways from a .tar.gz marked as 'release' will not differ.

For instance chasing a kernel bug is difficult when 1 person might use 1 
version of a compiler and another uses a different version when both 
says 2.95.4, no matter how miniscule the difference.

// Stefan


