Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbVKITEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbVKITEH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbVKITEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:04:06 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:26596 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030284AbVKITEF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:04:05 -0500
Message-ID: <4372487C.7070800@tmr.com>
Date: Wed, 09 Nov 2005 14:05:32 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marado@isp.novis.pt
CC: Linux-kernel@vger.kernel.org, fawadlateef@gmail.com, s0348365@sms.ed.ac.uk,
       hostmaster@ed-soft.at, jerome.lacoste@gmail.com, carlsj@yahoo.com
Subject: Re: New Linux Development Model
References: <1131500868.2413.63.camel@localhost> <1131534496.8930.15.camel@noori.ip.pt>
In-Reply-To: <1131534496.8930.15.camel@noori.ip.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcos Marado wrote:
> On Wed, 2005-11-09 at 02:47 +0100, Ian Kumlien wrote:
> 
> 
>>Anyways, I was also miffed that the kernel folks merged a 'ancient'
>>version of ipw2200 and ieee802.11, if they had merged something more
>>current everything would have worked out of the box and all the cleanups
>>would have been easier to cope with. Ie, the intel ppl could release
>>straight patches to the in kernel version. I dunno if they have changed
>>the way their driver works now.
>>
>>Atm, the 'ancient' ieee802.11 is what breaks the ipw2200 build. So,
>>basically all testing of cutting edge kernels gets very tedious due to
>>the ieee802.11 package removing the offending .h file and making
>>reversing -gitX and applying -gitY a real PITA.
> 
> 
> Those are no "ancient" versions, they are the "stable" versions of
> ieee80211, ipw2100 and ipw2200. ipw* folks think, and I have to agree,
> that for the stable kernel (Linux tree) it makes sense to add the stable
> versions of their projects.

To what end? The current drivers compile and load, but they don't 
function for wireless communication! What's the point of having code 
which is essentially a no-op, why have it if it doesn't provide any 
functionality?

With the current firmware and driver a "scan" shows 14 connectible 
points outside an apartment building (only one secured in any way ;-) 
whic is just what Windows shows. With the stock kernel zero are found. 
That's not stable that's moribund.

> 
> For more about their versioning, make sure you read
> http://ipw2100.sourceforge.net/#downloads .
> 

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
