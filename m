Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288919AbSBRXWf>; Mon, 18 Feb 2002 18:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288921AbSBRXWZ>; Mon, 18 Feb 2002 18:22:25 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:41089 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S288919AbSBRXWR>;
	Mon, 18 Feb 2002 18:22:17 -0500
Message-ID: <3C718C99.9030909@tmsusa.com>
Date: Mon, 18 Feb 2002 15:22:01 -0800
From: J Sloan <joe@tmsusa.com>
Organization: J S Concepts
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Oliver Hillmann <oh@novaville.de>, linux-kernel@vger.kernel.org
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <Pine.LNX.4.33.0202182305390.10354-100000@gans.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many will be grateful if this finally allows
the correct uptime to be generated after
497 days - my busy mail/dns servers now
have 611 days uptime, but to outsiders it
appears they only have 114 days uptime,
and there are bizarre items in the process
table, e.g. programs that were apparently
started in the year 2003...

Joe

Tim Schmielau wrote:

>On Mon, 18 Feb 2002, Oliver Hillmann wrote:
>
>>Hello,
>>
>>yes, I know this is defenitely no new issue (maybe its none to you
>>anyway), since I found posts about this dating from 1998: the
>>jiffies counter rolls over after approx. 497 days uptime, which
>>causes the uptime to roll over as well, and seems to cause some
>>other irretation in the system itself (my pc speaker starting
>>beeping constantely...)
>>
>
>See 
>http://www.lib.uaa.alaska.edu/linux-kernel/archive/2001-Week-47/0736.html
>for a patch.
>I intend to submit this for 2.4.19pre after some more testing and 
>feedback.
>
>Also note that several patches for jiffies rollover bugs have gone into 
>2.4.18pre, maybe one of them fixes the speaker driver.
>
>Tim
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


