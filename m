Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUHDGq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUHDGq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 02:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267302AbUHDGq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 02:46:29 -0400
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:36500 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267285AbUHDGqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 02:46:04 -0400
References: <34840234.20040804074326@dns.toxicfilms.tv>
Message-ID: <cone.1091601947.196990.9775.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduler policies for staircase
Date: Wed, 04 Aug 2004 16:45:47 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak writes:

> Con,
> 
> I have been using SCHED_BATCH on two machines now with expected
> results. So this you might consider this as another success report :-)

Great. Thanks for the report. I too use them all day every day on each 
machine I have with distributed computing clients so they're pretty well 
tested.

> Do you think that these schedulers could come into the mainline
> soon? Would you submit them to Linus without the staircase scheduler
> or would you rather wait for the whole bunch of changes to get
> rock-stable ?

It could easily be modified to suit the current scheduler. Obviously I want 
my scheduler to be considered for mainline at some stage in the future but 
there needs to be a good reason for that to occur, and the 12 other 
schedulers out there need to also be tested (we better hurry up or it could 
be twice that soon :P). At this stage I'll hold onto these patches and see 
what happens. I'd rather not have to rewrite it to suit the current 
scheduler and go through all the bugtesting again since there isn't a 
burning need for this scheduler policy in mainline at the moment. The 
lack of a large amount of feedback about staircase shows that most people 
aren't really interested in the cpu scheduler at the moment anyway.

Cheers,
Con

