Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVAJVfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVAJVfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVAJVeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:34:10 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:20359 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262677AbVAJVaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:30:07 -0500
Message-ID: <41E2F456.9030007@tmr.com>
Date: Mon, 10 Jan 2005 16:32:06 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       linux-kernel@vger.kernel.org, debian-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <1105096053.5444.11.camel@ulysse.olympe.o2t><1105096053.5444.11.camel@ulysse.olympe.o2t> <20050107111508.GA6667@infradead.org>
In-Reply-To: <20050107111508.GA6667@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Jan 07, 2005 at 12:07:33PM +0100, Nicolas Mailhot wrote:
> 
>>Hi all, 
>>
>>Since 2.6 is turning into a continuous release, how about just taking
>>the last 2.6 release every six months and backport security fixes to it
>>for the next half year ?
> 
> 
> Half a year is far too long because hardware is changing to fast for that.
> Three month sounds like a much better idea.
> 
> The real problem is that this is a really time-consuming issue, so
> there need to be people actually commited to doing this kind of thing.
> 
> Andres Salomon from the Debian Kernel maintaince team has been thinking
> about such a bugfix tree, but he's worried about having the time to
> actually get the work done - and we know what we're talking about as
> we're trying to keep a properly fixed 2.6.8 tree for Debian sarge.

Several of us have suggested that only security fixes and fixes for bugs 
which resulting in crashes, hangs, filesystem damage and the like be 
backported to the 2.6.N until 2.6.N+1 is released. No new drivers, 
schedulers (unless the old one breaks), just fixes. While this would 
work better with more frequent stable releases, the number of things in 
any given kernel which are actually broken is usually quite small, the 
bulk seem to be new features and "works better" patch sets.

I suspect that you are doing far more than bug fixes in your tree, which 
is admirable, but adds a LOT of work!

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
