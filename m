Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUHRLrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUHRLrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 07:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUHRLrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 07:47:14 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:58276 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S265900AbUHRLrL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 07:47:11 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: lkml problem
Date: Wed, 18 Aug 2004 07:47:09 -0400
User-Agent: KMail/1.6.82
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
References: <200408172256.54881.vda@port.imtp.ilyichevsk.odessa.ua> <200408171709.59841.gene.heskett@verizon.net> <200408180848.47247.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408180848.47247.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408180747.10085.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.55.227] at Wed, 18 Aug 2004 06:47:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 August 2004 01:48, Denis Vlasenko wrote:
>> >Can you check why do my mails stopped appearing on
>> >lkml lately? My SMTP server reports them as accepted:
>> >
>> >info msg 192270: bytes 23472 from
>> > <vda@port.imtp.ilyichevsk.odessa.ua> qp 21977 uid 80 starting
>> > delivery 440: msg 192270 to remote arjanv@redhat.com starting
>> > delivery 441: msg 192270 to remote Jens.Maurer@gmx.net starting
>> > delivery 442: msg 192270 to remote linux-kernel@vger.kernel.org
>> > delivery 442: success:
>> > 12.107.209.244_accepted_message./Remote_host_said:_250_2.7.0_not
>> >hin g_apparently_wrong_i delivery 440: success:
>> > 66.187.233.31_accepted_message./Remote_host_said:_250_2.0.0_i7HH
>> >Vve 1030758_Message_acce delivery 441: success:
>> > 213.165.64.100_accepted_message./Remote_host_said:_250_2.6.0_{mx
>> >028 }_Message_accepted/
>> >
>> >My SMTP server's IP is 195.66.192.168
>> >--
>> >vda
>>
>> My filters caught the CC: line and stuffed it to lkml as usual
>> Denis.
>
>Yes. However, I sent a patch thrice (twice before and once after
>the message to Matti) and I don't see that patch posted.
>I checked www.lkml.org.

I noted that in a couple of reject messages the server has posted (and 
I don't recall if it came from you, normally they are from some 
obviously spammish src) that there is a list of attachement ".ext" 
specifiers that they will /dev/null.  There have been 2 of those just 
this morning, but they get the big red X treatment here (kmail) 
before they get lost in the other 10,000 plus messages of this list.

Does the reverse dns lookup work as expected?  I think thats another 
reason, but since the text msgs are coming ok, I drift off in the 
direction of the attachements extension as the reason.  This list 
seems to be in favor of inlining any patches which removes that 
aspect of the filtering done.

>--
>vda

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
