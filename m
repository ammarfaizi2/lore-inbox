Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUFCOSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUFCOSY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUFCOSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:18:21 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:28801 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S264358AbUFCOSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:18:04 -0400
Message-ID: <40BF3329.9040700@tmr.com>
Date: Thu, 03 Jun 2004 10:18:17 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: why swap at all? 
References: Your message of "Wed, 02 Jun 2004 07:38:41 +0200."             <1086154721.2275.2.camel@localhost.localdomain> <200406021759.i52Hx00N022255@turing-police.cc.vt.edu>
In-Reply-To: <200406021759.i52Hx00N022255@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 02 Jun 2004 07:38:41 +0200, FabF said:
> 
> 
>>>Yes but: your wm is so  often used/activated it will not get swaped  out. 
>>>But if your mouse passes over mozilla and tries to focus it, then you will
>>>feel the pain of a swapped-out x program.
>>>
>>
>>Exactly !
>>Does autoregulated VM swap. patch could help here ?
> 
> 
> Con's auto-adjusting swappiness patch did in fact help that quite a bit,
> especially for the case of heavy file I/O causing process images to be swapped
> out.  I need to do some comparisons of that to Nick's MM work...

I haven't had a chance to try Con's stuff, the Nick patch is working 
VERY well for me, small memory and slow system, lots of memory pressure. 
Hopefully you can report a comparison.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
