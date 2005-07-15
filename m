Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVGOMgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVGOMgk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 08:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbVGOMgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 08:36:40 -0400
Received: from mail.tmr.com ([64.65.253.246]:26042 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261920AbVGOMgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 08:36:39 -0400
Message-ID: <42D7AF3D.4030706@tmr.com>
Date: Fri, 15 Jul 2005 08:42:37 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <d120d50005071312322b5d4bff@mail.gmail.com>	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>	 <20050713211650.GA12127@taniwha.stupidest.org>	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>	 <20050714005106.GA16085@taniwha.stupidest.org>	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>	 <1121304825.4435.126.camel@mindpipe>	 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>	 <1121326938.3967.12.camel@laptopd505.fenrus.org>	 <20050714121340.GA1072@ucw.cz>	 <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>	 <1121383050.4535.73.camel@mindpipe>	 <Pine.LNX.4.58.0507141623490.19183@g5.osdl.org>	 <1121384499.4535.82.camel@mindpipe>	 <Pine.LNX.4.58.0507141648070.19183@g5.osdl.org> <1121385185.4535.89.camel@mindpipe>
In-Reply-To: <1121385185.4535.89.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Thu, 2005-07-14 at 16:49 -0700, Linus Torvalds wrote:
>  
>
>>YOUR argument is "nobody else matters, only I do".
>>
>>MY argument is that this is a case of give and take. 
>>    
>>
>
>I wouldn't say that.  I do agree with you that HZ=1000 for everyone is
>problematic, I just feel that a reasonable compromise is CONFIG_HZ with
>the default left at 1000.
>

I would just say that changing something like this now is probably not a 
great idea, while allowing a config option for 100/250/1000 and maybe 
even 2000 won't make everyone happy, but seems to allow everyone to make 
themselves happy.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

