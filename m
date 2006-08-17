Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWHQHvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWHQHvd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWHQHvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:51:33 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:15786 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932218AbWHQHvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:51:32 -0400
Date: Thu, 17 Aug 2006 09:50:37 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Dirk <noisyb@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
In-Reply-To: <20060816152509.166ce663.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0608170950220.16217@yvahk01.tjqt.qr>
References: <44E3552A.6010705@gmx.net> <20060816152509.166ce663.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have changed a message that didn't clearly tell the user what was goin
>> on...
>> 
>> Please have a look!
>> 
>> Thank you,
>> Dirk
>> 
>>
>> --- drivers/cdrom/cdrom.c.old	2006-08-16 19:04:11.000000000 +0200
>> +++ drivers/cdrom/cdrom.c	2006-08-16 19:04:51.000000000 +0200
>> @@ -2455,7 +2455,7 @@
>>  		if (tracks.data > 0) return CDS_DATA_1;
>>  		/* Policy mode off */
>>  
>> -		cdinfo(CD_WARNING,"This disc doesn't have any tracks I recognize!\n");
>> +		cdinfo(CD_WARNING,"I'm a stupid fuck that will repeat this interesting message while endlessly trying to access the media you just inserted until your CD/DVD burning task is eventually fucked\n");
>>  		return CDS_NO_INFO;
>>  		}
>
>Please keep the code formatted to fit in an 80-column xterm.  See
>Documentation/CodingStyle.  Thanks.
>
>(And you forget the Signed-off-by: line)

Before any of this gets ANY chance to get in:

NAK.



Jan Engelhardt
-- 
