Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUHBUlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUHBUlL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 16:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUHBUlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 16:41:11 -0400
Received: from mail.tmr.com ([216.238.38.203]:264 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263100AbUHBUlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 16:41:06 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: ide-cd problems
Date: Mon, 02 Aug 2004 16:44:18 -0400
Organization: TMR Associates, Inc
Message-ID: <cem8ic$hoj$1@gatekeeper.tmr.com>
References: <axboe@suse.de> <200408020320.i723KG9E007500@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1091478924 18195 192.168.12.100 (2 Aug 2004 20:35:24 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <200408020320.i723KG9E007500@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Jens Axboe <axboe@suse.de> said:
> 
>>On Sun, Aug 01 2004, Alexander E. Patrakov wrote:
> 
> 
> [...]
> 
> 
>>>Remember that it is still possible to write CDs through ide-cd in 2.4.x 
>>>using some pre-alpha code in cdrecord:
>>>
>>>cdrecord dev=ATAPI:1,1,0 image.iso
> 
> 
> [...]
> 
> 
>>Don't ever use that interface, period.
> 
> 
> Great! So I won't be able to use any of the CD burners I have now.
> 
> 
>>                                       It's not just the cdrecord code
>>that may be alpha (I doubt it matters, it's easy to use), the interface
>>it uses is not worth the lines of code it occupies.
> 
> 
> What do you suggest then? ide-scsi is gone, so AFAIK this is the only way
> to burn CDs right now on 2.6.x

Actually ide-scsi isn't gone, and what you want is ATA: not ATAPI: here. 
But if ATAPI: works for you, it's slow and grotty, but I think it does 
work. I've been using ide-scsi on 2.4 and don't plan to stop while it 
works, but ATAPI: is the one of choice for 2.6, particularly for burning 
audio.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
