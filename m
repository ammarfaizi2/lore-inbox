Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269500AbUI3Uq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269500AbUI3Uq4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269471AbUI3Uoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:44:30 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:15523 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S269181AbUI3Ulf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:41:35 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc3
Date: Thu, 30 Sep 2004 16:41:29 -0400
User-Agent: KMail/1.7
Cc: Marcel Holtmann <marcel@holtmann.org>, Tom Duffy <Tom.Duffy@sun.com>
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org> <200409300120.05524.gene.heskett@verizon.net> <1096521895.5181.5.camel@pegasus>
In-Reply-To: <1096521895.5181.5.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409301641.29662.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.8.60] at Thu, 30 Sep 2004 15:41:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 01:24, Marcel Holtmann wrote:
>Hi Gene,
>
>> >> Ok, this 2.6.9 cycle is getting too long, but here's a -rc3 and
>> >> hopefully we're getting there now.
>> >
>> >   CC [M]  drivers/isdn/capi/capi.o
>> >/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c: In
>> > function `handle_minor_send':
>> >/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:538:
>> >warning: cast from pointer to integer of different size
>> >/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c: In
>> > function `capi_recv_message':
>> >/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
>> >error: `tty' undeclared (first use in this function)
>> >/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
>> >error: (Each undeclared identifier is reported only once
>> >/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
>> >error: for each function it appears in.)
>> >make[4]: *** [drivers/isdn/capi/capi.o] Error 1
>> >make[3]: *** [drivers/isdn/capi] Error 2
>> >make[2]: *** [drivers/isdn] Error 2
>> >make[1]: *** [drivers] Error 2
>> >make: *** [_all] Error 2
>> >-
>>
>> Please start from the 2.6.8.tar.gz tarball, Tom.  This looks like
>> you may started from the 2.6.8.1.tar.gz.
>
>no. It is a problem of the TTY locking fixes from Alan.
>
>Regards
>
>Marcel
>
Odd, here I'm using both seriel ports, ah, wait a min.

Could a fubar'd amdump run have occured if there was traffic on the 
seriel port the ups is attached to, like a quick message that there 
had been a power failure, shutdown was eminent, but it came back in 
about 2 seconds?  There was nothing in the logs.  Humm, lemme fire up 
the bulldog and see if that screws things up.

That didn't seem to, and everything I looked at looked nominal, 
including its own log.

The other seriel port is being used for my X10 stuff, but that would 
also be logged and there is nothing there either.

How does this TTY locking thing manifest itself?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
