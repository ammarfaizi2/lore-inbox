Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSERIpO>; Sat, 18 May 2002 04:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313122AbSERIpN>; Sat, 18 May 2002 04:45:13 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:30850 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S313114AbSERIpM>; Sat, 18 May 2002 04:45:12 -0400
Message-ID: <3CE61651.3020006@notnowlewis.co.uk>
Date: Sat, 18 May 2002 09:52:33 +0100
From: mikeH <mikeH@notnowlewis.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <Pine.LNX.4.33.0205180051100.3170-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Whats the state of ext3 in this release? I seem to remember reading 
there were some corruption issues.

Thanks,

mikeH

Linus Torvalds wrote:

>[ Testing the shortlog format, full changelogs on the kernel site ]
>
>Well, I dunno if the short changelog format is wonderfully readable, but 
>at least it's small enough that I don't feel bad about mailbombing the 
>kernel list with it.
>
>USB and architecture updates, IDE driver updates etc. The one that kept me
>personally somewhat busy was the interesting Intel SMP-P4 TLB corruption
>bug, which ends up being due to some very funky asynchronous speculative
>TLB fill logic, which made the page table invalidation "exciting".
>
>The TLB invalidate rewrite will likely have broken all other architectures 
>(at least performance-wise, if not in any other way), so architecture 
>maintainers look out!
>
>		Linus
>  
>


