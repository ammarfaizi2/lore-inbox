Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSIORjG>; Sun, 15 Sep 2002 13:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318141AbSIORjG>; Sun, 15 Sep 2002 13:39:06 -0400
Received: from franka.aracnet.com ([216.99.193.44]:22745 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S318139AbSIORjF>; Sun, 15 Sep 2002 13:39:05 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: "Andrew Morton" <akpm@digeo.com>, "Dave Hansen" <haveblue@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: RE: [PATCH] add vmalloc stats to meminfo
Date: Sun, 15 Sep 2002 10:44:12 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBMEAFFGAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020915172608.GJ3530@holomorphy.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd still like a backport to the (Red Hat 7.3) 2.4.18 kernel if it is
possible. I'm a big fan of statistics and logging them.

M. Edward (Ed) Borasky
mailto: znmeb@borasky-research.net
http://www.pdxneurosemantics.com
http://www.meta-trading-coach.com
http://www.borasky-research.net

Coaching: It's Not Just for Athletes and Executives Any More!

-----Original Message-----
From: William Lee Irwin III [mailto:wli@holomorphy.com]
Sent: Sunday, September 15, 2002 10:26 AM
To: M. Edward (Ed) Borasky
Cc: Andrew Morton; Dave Hansen; Martin J. Bligh;
linux-kernel@vger.kernel.org; linux-mm@kvack.org
Subject: Re: [PATCH] add vmalloc stats to meminfo

On Sun, 15 Sep 2002, William Lee Irwin III wrote:
>> Also, dynamic vmalloc allocations may very well be starved by boot-time
>> allocations on systems where much vmallocspace is required for IO memory.
>> The failure mode of such is effectively deadlock, since they block
>> indefinitely waiting for permanent boot-time allocations to be freed up.

On Sun, Sep 15, 2002 at 10:23:24AM -0700, M. Edward (Ed) Borasky wrote:
> Thank you!! How difficult would it be to back-port this to 2.4.18?

Note the follow-up to this saying that the above paragraph was incorrect.
It doesn't sleep except to allocate backing memmory.


Bill

