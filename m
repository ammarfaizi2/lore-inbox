Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTD1RYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 13:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbTD1RYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 13:24:34 -0400
Received: from imap.gmx.net ([213.165.64.20]:26912 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261216AbTD1RX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 13:23:59 -0400
Message-ID: <3EAD6688.7060809@gmx.net>
Date: Mon, 28 Apr 2003 19:36:08 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andi Kleen <ak@suse.de>, Henti Smith <bain@tcsn.co.za>,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       Riley Williams <Riley@Williams.Name>
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD5AC1.7090003@us.ibm.com> <3EAD5D90.7010101@gmx.net> <3EAD61FB.30907@us.ibm.com>
In-Reply-To: <3EAD61FB.30907@us.ibm.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> Carl-Daniel Hailfinger wrote:
> 
>>Cool. Sorry to be pestering about the 64-bit limits, but can we really
>>use 2^64 bytes of memory on ia64/ppc64/x86-64 etc.? (AFAIK, 64-bit
>>arches don't suffer from a small ZONE_LOWMEM.)
> 
> [...]
> Don't forget that highmem starts to be needed before the 4G boundary.
> The kernel has only 1GB of virtual space (look for PAGE_OFFSET, which
> defines it), which means that you start needing to pull all of the
> highmem trickery before you get to the actual limits.

It seems I misunderstood the concept of highmem. I thought highmem was
not needed on 64-bit arches. Thanks for pointing that out to me.
> 
> Nobody knows how far it will go.  It's fairly safe to say that, at this
> rate, Linux will keep up with whatever hardware anyone produces.

That is the answer the original poster was looking for.

> Unless, of course, someone gets even more perverse than PAE. :)

hehe ;-) Can you say PAE in userspace?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

