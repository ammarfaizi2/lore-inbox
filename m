Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVBAPrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVBAPrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 10:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVBAPrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 10:47:14 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:46746 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262052AbVBAPqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 10:46:37 -0500
Message-ID: <41FFA52C.606@tmr.com>
Date: Tue, 01 Feb 2005 10:50:04 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Michael Buesch <mbuesch@freenet.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: My System doesn't use swap!
References: <41FE2814.9030503@tiscali.de><41FE2814.9030503@tiscali.de> <D25F0ABA-73C6-11D9-B5F9-000393ACC76E@mac.com>
In-Reply-To: <D25F0ABA-73C6-11D9-B5F9-000393ACC76E@mac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Jan 31, 2005, at 07:44, Matthias-Christian Ott wrote:
> 
>> Ok maybe I wasn't able to read the /free/ output correctly, but why is no
>> swap used (more than 60% ram are used)?
> 
> 
> Swap is orders of magnitude slower than RAM. Why put things there if you
> still have RAM left?  The kernel only puts things in swap when it has no
> more RAM _and_ has already deleted big chunks of its disk cache.

Unless he just booted, I would expect at least a little use of the swap, 
something like this, on a machine with 1GB RAM and not much happening. 
It's burning in with setiathome, and I played a few mp3s, and it seemed 
to feel the need for swap. I see similar on a box with 4GB, it never 
comes close to low memory, but still uses a few MB swap.

pixels:davidsen> free
              total       used       free     shared    buffers    cached
Mem:       1035228     996712      38516          0     175100    67932
-/+ buffers/cache:     553680     481548
Swap:      2048248      11292    2036956
pixels:davidsen> uname -rn
pixels.tmr.com 2.6.10-ac2


Not that this is a bad thing, but I'm surprised at no swap used at all.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
