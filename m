Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267376AbTBLRan>; Wed, 12 Feb 2003 12:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267386AbTBLRan>; Wed, 12 Feb 2003 12:30:43 -0500
Received: from sccmmhc02.mchsi.com ([204.127.203.184]:31484 "EHLO
	sccmmhc02.mchsi.com") by vger.kernel.org with ESMTP
	id <S267376AbTBLRal> convert rfc822-to-8bit; Wed, 12 Feb 2003 12:30:41 -0500
From: Steve Brueggeman <xioborg@mchsi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: fibre channel driver
Date: Wed, 12 Feb 2003 11:40:25 -0600
Message-ID: <vk1l4vo2aer0bdlkd3ub7i5djvv26e242o@4ax.com>
References: <20030131222954.18430.qmail@web40005.mail.yahoo.com> <Pine.LNX.4.51.0302020032440.6018@skuld.mtroyal.ab.ca>
In-Reply-To: <Pine.LNX.4.51.0302020032440.6018@skuld.mtroyal.ab.ca>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you been able to get both the qla2200 and qla2300 to run at the same
time???  I've got a system with both cards installed, and am having problems. 
Another problem (I think) is that the failover is in the driver, so I probably
will not be able to failover from the qla2300 card to the qla2200, correct?

Steve Brueggeman

On Sun, 2 Feb 2003 00:35:42 -0700 (MST), you wrote:

>On Fri, 31 Jan 2003, Venkat Raghu wrote:
>
>> Hi,
>> 
>> I want to know if there is any fibrechannel driver 
>> in linux kernel. If yes please point me to the source
>> and any links to it. What about qlogic fibre channel
>> driver. Is it part of linux community also, if so 
>> where can I get it.
>
>I'm unsure about community drivers but...
>
>qlogic does have driver source available on their site for the qla2200 and
>qla2300 which does include fail over code.  The 6.03 is
>also supported under Red Hat AS2.1 and Suse 7.? or 8 by EMC, perhaps
>even using RH 7.? at sometime in the near future.
>
>I have tried it and it does work very well, although the timeout for
>failover is hard coded and there may be an issue with tape drives if
>failover is enabled...  I'll know more about that later this coming week.
>
>REgards
>James Bourne
>> 
>> 
>> Please mail me at venkatraghu2002@yahoo.com.
>> Regards
>> Raghu
>> 
>> 
>> __________________________________________________
>> Do you Yahoo!?
>> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
>> http://mailplus.yahoo.com
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>> 

