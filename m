Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVEIRkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVEIRkD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 13:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVEIRkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 13:40:03 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:17820 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261451AbVEIRjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 13:39:37 -0400
Message-ID: <427FA061.2090103@tmr.com>
Date: Mon, 09 May 2005 13:39:45 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: James Dingwall <james.dingwall@cramer.com>, linux-kernel@vger.kernel.org,
       Andries.Brouwer@cwi.nl, Chris Wright <chrisw@osdl.org>
Subject: Re: Bug: 2.6.11.8 msdos.c
References: <427B782E.6040309@tmr.com><3E116F19B784CD47A7CE7F923A436499014C8E39@s2.cramer.co.uk> <Pine.LNX.4.61.0505061007480.6588@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0505061007480.6588@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Fri, 6 May 2005, Bill Davidsen wrote:
> 
>> James Dingwall wrote:

>>> Andries' hint about changing the partition types to !0 is a fix for the
>>> problem.
>>
>>
>> What is the reason for the patch in the first place? Obviously it's
>> intended to do something, or not do something bad, but what's wrong with
>> a reserved partition?
>>
>> I looked at the rest of msdos.c and it wasn't blindingly clear what the
>> original intent was. A partition type of zero is unusual, but it's not
>> illegal, is it? (as in violates some standard)
> 
> 
> Can't the problem be fixed by just using Linux fdisk to put in the
> correct ID?  Unlike MS-DOS fdisk, the Linux fdisk can modify things
> without destroying everything else on the drive.

Yes, that works. My question was why a zero was considered a bad value 
instead of "reserved." Not that I disagree, I just don't see the reason.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
