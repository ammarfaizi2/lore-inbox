Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUCADro (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 22:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbUCADro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 22:47:44 -0500
Received: from alt.aurema.com ([203.217.18.57]:1706 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262235AbUCADrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 22:47:21 -0500
Message-ID: <4042B238.9050703@aurema.com>
Date: Mon, 01 Mar 2004 14:47:04 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
CC: johnl@aurema.com, linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <1077766232.10393.992.camel@cube> <403D8FE6.2010905@aurema.com>	<1077818221.2255.3.camel@cube> <403E8035.9020606@aurema.com>
In-Reply-To: <403E8035.9020606@aurema.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Albert Cahalan wrote:
<snip>
>> Nothing can rely on it existing at all, so a name change would
>> solve the problem of apps getting confused.
>>
>> BTW, permill is not per-million, it is per-thousand.
>> Per-million or per-billion would be fine as long as
>> it doesn't overflow.
> 
> 
> OK.  Since SleepAVG does not seem to be entrenched in people's 
> expectations and because of the fact that the value calculated from our 
> usage rates are not really valid (see above), I propose that we change 
> this field's name to CPUrate and report the CPU usage rate directly in 
> permill (unless there are violent objections).

I've analysed the arithmetic and think that we can safely go to 6 
decimal places so I'll make this Per-million.  The change should appear 
in the patches to the 2.6.4 kernel when it is available.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

