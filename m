Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbUKDPOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUKDPOW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbUKDPOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:14:22 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:52364 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262253AbUKDPOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:14:14 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Thu, 4 Nov 2004 10:14:12 -0500
User-Agent: KMail/1.7
Cc: tlaurent@linagora.com,
       "gene.heskett@verizon.net" <gene.heskett@verizon.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Doug McNaught <doug@mcnaught.org>, Jan Knutar <jk-lkml@sci.fi>,
       Tom Felker <tfelker2@uiuc.edu>
References: <200411030751.39578.gene.heskett@verizon.net> <200411040911.51923.gene.heskett@verizon.net> <1099579352.418a3fd82b569@intranet.linagora.com>
In-Reply-To: <1099579352.418a3fd82b569@intranet.linagora.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411041014.12749.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.42.194] at Thu, 4 Nov 2004 09:14:13 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 09:42, tlaurent@linagora.com wrote:
>Selon Gene Heskett <gene.heskett@verizon.net>:
>> On Thursday 04 November 2004 08:10, Doug McNaught wrote:
>> >Gene Heskett <gene.heskett@verizon.net> writes:
>> >> [root@coyote linux-2.6.10-rc1-bk13]# grep SYSRQ .config
>> >> CONFIG_MAGIC_SYSRQ=y
>> >
>> >Did you also enable it in /proc?
>> >
>> >-Doug
>>
>> I just now discovered it defaults to a 0, so I put an
>> echo 1 >proc/sys/kermel/sysrq
>> in rc.local just now.
>
>You might also want to have a look at /etc/sysctl.conf. Some distros
> put a kernel.sysrq=0 in it...

And I just put a comment in front of that puppy!

>Cheers,
>Thibaut
>
>> Thanks for the heads up.
>>
>> --
>> Cheers, Gene
>> "There are four boxes to be used in defense of liberty:
>>  soap, ballot, jury, and ammo. Please use in that order."
>> -Ed Howdershelt (Author)
>> 99.28% setiathome rank, not too shabby for a WV hillbilly
>> Yahoo.com attorneys please note, additions to this message
>> by Gene Heskett are:
>> Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
