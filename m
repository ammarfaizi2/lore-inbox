Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUDNQnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUDNQnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:43:18 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:15493 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S263301AbUDNQnL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:43:11 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: walt <wa1ter@myrealbox.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.5-bk]  'modules_install' failed to install modules
Date: Wed, 14 Apr 2004 12:43:09 -0400
User-Agent: KMail/1.6
References: <407D5B7F.107@myrealbox.com> <20040414161827.GA2229@mars.ravnborg.org>
In-Reply-To: <20040414161827.GA2229@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141243.09740.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.62.48] at Wed, 14 Apr 2004 11:43:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 April 2004 12:18, Sam Ravnborg wrote:
>On Wed, Apr 14, 2004 at 08:40:47AM -0700, walt wrote:
>> I pulled the latest changesets just now and found this weird
>> behavior:
>>
>> 'make' and 'make install' worked as expected, but 'make
>> modules_install' just deleted all the old modules, ran depmod, and
>> then installed no new modules -- nothing.
>>
>> I finally found that doing another 'make' fixed whatever the
>> problem was and allowed modules_install to work properly the
>> second time.
>>
>> This happened on two different machines, so I'm fairly sure it
>> wasn't just me having a brainfart.
>
>This is my second report about this.
>But you gave some new info "work properly the second time".
>This was not the case for the other person.
>
>I will look into it tonight.
>
>	Sam

WRT 2.6.5-bk1:  So far everything I've checked seems to be working, 
including loading all the modules on the 1st build and reboot to it.

>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
