Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265945AbSKFSbQ>; Wed, 6 Nov 2002 13:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265953AbSKFSbQ>; Wed, 6 Nov 2002 13:31:16 -0500
Received: from f156.law11.hotmail.com ([64.4.17.156]:16904 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S265945AbSKFSbN>;
	Wed, 6 Nov 2002 13:31:13 -0500
X-Originating-IP: [144.92.164.196]
From: "Tom Reinhart" <rhino_tom@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
Date: Wed, 06 Nov 2002 10:37:46 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F156TOqVPo2HJS3F7il00005647@hotmail.com>
X-OriginalArrivalTime: 06 Nov 2002 18:37:47.0093 (UTC) FILETIME=[9A238050:01C285C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would think the default should be a lot more conservative than that, 
probably closer to 30 seconds.  Much better to default to safety, and allow 
knowledgable users to tradeoff for performance if they can live with the 
risks.

Tom


>>There is also a longer PhD thesis by her. 10 minutes is about as much
>>work as I personally am willing to lose and try to remember. Avoiding
>>75% of writes instead of 20% is a substantial performance gain worth
>>paying a cost for. Unfortunately it is not easy to say if it is worth
>>that much cost, but I suspect it is. An approach we are exploring is
>>for blocks to reach disk earlier than that if the device is not
>>congested, on the grounds that if not much IO is occuring, then
>performance is not important.
>
>Assuming your 10 minutes are just a default and tunable by sysctl I
>hardly can see any problems at all. Paranoid people can set it to
>make any tradeoff between performance and speed they'd like including
>setting it to 0, no?




_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

