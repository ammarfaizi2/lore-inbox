Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263281AbREaXkc>; Thu, 31 May 2001 19:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263284AbREaXkV>; Thu, 31 May 2001 19:40:21 -0400
Received: from mail.digitalme.com ([193.97.97.75]:63920 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S263281AbREaXkN>;
	Thu, 31 May 2001 19:40:13 -0400
Message-ID: <3B16D684.5080101@digitalme.com>
Date: Thu, 31 May 2001 19:40:52 -0400
From: "Trever L. Adams" <vichu@digitalme.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9+) Gecko/20010529
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christopher Zimmerman <zim@av.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 VM
In-Reply-To: <3B16C9A8.7090402@digitalme.com> <3B16CCE9.64597F2E@av.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Zimmerman wrote:

> 
> I've found that with the latest kernel release (2.4.5) VM performance has
> been greatly improved.  kswapd and bdflush no longer use 200% of my cpu
> cycles when simply doing a dd bs=1024 count=8388608 if=/dev/zero
> of=test.file.  All of my test systems remain responsive with about 180% cpu
> available.  These systems are running software RAID and 3ware IDE raid with
> 2GB of memory and 4GB swap.  Have you tried 2.4.5?
> 
> -zim
> 
> Christopher Zimmerman
> AltaVista Company
> 


I have found that 2.4.5 is great, until it decides to stop freeing unused pages

(simple file cache).  Then it goes to hell in a handbasket at the speed of light.


Yes, I have tried it, that is what I wrote about.

Trever

