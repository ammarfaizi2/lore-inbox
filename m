Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310468AbSDDTZp>; Thu, 4 Apr 2002 14:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310434AbSDDTZi>; Thu, 4 Apr 2002 14:25:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27141 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310435AbSDDTZX>;
	Thu, 4 Apr 2002 14:25:23 -0500
Message-ID: <3CACA8A9.2000701@mandrakesoft.com>
Date: Thu, 04 Apr 2002 14:25:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: flaniganr@intel.co.jp, linux-kernel@vger.kernel.org,
        dhinds@zen.stanford.edu, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] 2.5.8-pre1 wavelan_cs
In-Reply-To: <87vgb8x8bt.fsf@hazuki.jp.intel.com> <3CABFE55.9@mandrakesoft.com> <20020404094057.B26632@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> On Thu, Apr 04, 2002 at 02:18:45AM -0500, Jeff Garzik wrote:
> 
>>flaniganr@intel.co.jp wrote:
>>
>>>not sure if i did this right, so if you 
>>>have any suggestions/comments please tell me.
>>>
>>>Basically 2.5.8-pre1 fails to compile with:
>>>
>>>In file included from wavelan_cs.c:59:
>>>wavelan_cs.p.h:495:33: warning: extra tokens at end of #undef directive
>>>wavelan_cs.c: In function `wv_pcmcia_config':
>>>wavelan_cs.c:4480: structure has no member named `rmem_start'
>>>wavelan_cs.c:4482: structure has no member named `rmem_end'
>>>make[3]: *** [wavelan_cs.o] Error 1
>>>
>>not needed, just delete the unused references to rmem_{start,end}.
>>(see attached patch)
>>
>>	Jeff
>>
> 
> 	Correct. It was just information displayed by ifconfig.
> 	Jeff, will you take care of it or do you need an "official"
> patch (I would just resend your patch + the one of Robert).


I've already taken care of it, in fact :)

	Jeff





