Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284134AbRLGRVs>; Fri, 7 Dec 2001 12:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284138AbRLGRVj>; Fri, 7 Dec 2001 12:21:39 -0500
Received: from jedi.destru.com ([12.3.0.13]:38643 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id <S284134AbRLGRVb>;
	Fri, 7 Dec 2001 12:21:31 -0500
Message-ID: <3C10F9E0.7010906@optonline.net>
Date: Fri, 07 Dec 2001 12:18:24 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andris Pavenis <pavenis@lanet.lv>
CC: linux-kernel@vger.kernel.org, dledford@redhat.com
Subject: Re: [PATCH] i810_audio fix for version 0.11
In-Reply-To: <3C10E85F.7040009@lanet.lv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andris Pavenis wrote:

>  > With this patch, it seems to work fine. Without, it hangs on write.
> 
> I met case when dmabuf->count==0 when __start_dac() is called. As result
> I still got system freezing even if PCM_ENABLE_INPUT or 
> PCM_ENABLE_OUTPUT were set accordingly (I used different patch, see 
> another patch I sent today).
> 
> My latest revision of patch "survives" without problems already some 
> hours (normally I'm not listening radio through internet all time, but 
> this time I do ...)
> 
> Andris
> 
> 
> 
> 
> 
> 

i knew i shoula been a little less lazy with that one...

haven't looked at your revision yet but we should just clean up and make 
update_lvi self-contained so that it always does *something* appropriate 
regardless of state. maybe that's what you did. ;-)

(fyi, i'm not subscribed to linux-kernel, too much volume for the few 
specific interests i have, i don't see some of this stuff until, and if, 
i go digging thru archives)

