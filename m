Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316825AbSGZEvp>; Fri, 26 Jul 2002 00:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316794AbSGZEue>; Fri, 26 Jul 2002 00:50:34 -0400
Received: from [195.63.194.11] ([195.63.194.11]:61957 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316795AbSGZEuT>; Fri, 26 Jul 2002 00:50:19 -0400
Message-ID: <3D409F7E.5080307@evision.ag>
Date: Fri, 26 Jul 2002 03:01:50 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Cort Dougan <cort@fsmlabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
References: <20020725110033.G2276@host110.fsmlabs.com> <20020725181126.A17859@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Jul 25, 2002 at 11:00:33AM -0600, Cort Dougan wrote:
> 
>>This is from the -atp (Aunt Tillie and Penelope) tree.
>>
>>This patch adds a small function that looks up symbol names that correspond
>>to given addresses by digging through the already existent ksyms table.
>>It's invaluable for debugging on embedded systems - especially when testing
>>modules - since ksymoops is a hassle to deal with in cross-build
>>environments.  We already have this info in the kernel so we might as well
>>use it.
>>
>>This patch adds use of the function for PPC and i386.
> 
> 
> Wow! very usefull patch.  O want it for 2.4 and 2.5, please.

Cool indeed! I wan't it too. Even if it doesn't give me the
precise information about where the stuff hung, it's allmost
always sufficient for me to see where it crashed around...
And far more convenient then RS232 console ore whatever in esp.
since it's sufficent in 90% of the cases I tend to trigger during
"experiments".



