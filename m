Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTJQSrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 14:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTJQSrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 14:47:17 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:24497 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S263586AbTJQSrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 14:47:13 -0400
Message-ID: <3F903768.7060803@rackable.com>
Date: Fri, 17 Oct 2003 11:39:36 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Software RAID5 with 2.6.0-test
References: <1065690658.10389.19.camel@slurv> <Pine.LNX.3.96.1031017125544.24004C-100000@gatekeeper.tmr.com> <yw1xu167kbcw.fsf@users.sourceforge.net>
In-Reply-To: <yw1xu167kbcw.fsf@users.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Oct 2003 18:47:12.0611 (UTC) FILETIME=[13BA7330:01C394DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> Bill Davidsen <davidsen@tmr.com> writes:
> 
> 
>>>However, I wouln't count on superior performance from software based
>>>RAID 5 (ata/fakeraid or otherwise), that is whats real raid controllers
>>>are for.
>>
>>While an overloaded system may benefit from offloaded the CPU
>>requirements of RAID, unless you go to a very expensive external unit
>>the kernel RAID will usually outperform the inexpensive RAID embedded on
>>a controller. The kernel simply knows more about the data needs and can
>>can do things a controller can't.
> 
> 
> What about the RAID controllers in the $400 category?  Surely, they
> must be doing something better than the $50 fakeraid controllers.
> 

   Yes, but follow this logic.

1)You are willing to devote 10% of 2Ghz xeon to software raid.
2)A $500+ controller has a 100Mhz proccessor.

   Thus just from this you could guess that software raid has x2 as many 
clock cycles availble to it.  It's even worse when you realize the 2Ghz 
xeon is a better proccessor in many more ways than just clock cycles.


   The reasons to use that 500-1000 raid controller are due the features 
the controller gives you.  Things like gracefull recovery from bad 
sectors, and SAF-TE support.


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

