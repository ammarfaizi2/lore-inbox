Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVKWQcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVKWQcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVKWQct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:32:49 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:1748 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751212AbVKWQct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:32:49 -0500
Message-ID: <438493DF.5000501@tmr.com>
Date: Wed, 23 Nov 2005 11:07:59 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>	 <20051122204918.GA5299@kroah.com>	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>	 <1132694935.10574.2.camel@localhost>	 <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com> <1132702614.20233.91.camel@localhost.localdomain>
In-Reply-To: <1132702614.20233.91.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2005-11-22 at 16:41 -0500, Jon Smirl wrote:
> 
>>An example of this is that the serial driver is hard coded to report
>>four legacy serial ports when my system physically only has two. I
>>have to change a #define and recompile the kernel to change this.
> 
> 
> It does an autodetect sequence to find the ports. If it reports ttyS0-S3
> your system probably has them, they may just not be wired to external
> ports and that is kinda tricky to autodetect
> 
> 
>>looks for everything again anyway. In a more friendly system X would
>>use the info the kernel provides and automatically configure itself
>>for the devices present or hotplugged. You could get rid of your
>>xorg.cong file in this model.
> 
> 
> 
> Not really as half of xorg.conf is preferences
> 
I think what he wants is that you could have preferences, but that 
something functional if not optimal would be selected. What would 
actually be useful is if the kernel would provide a small report of the 
video hardware in some useful format, such that (example) 
/proc/somthing/video_config could be included in the xorg.conf.

Yes, a number of distributions build the xorg.conf at install time, 
although it's sometimes wrong and can't readily be made right after the 
fact. And really should come from kernel info found at boot time, I believe.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

