Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266053AbUBKS32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266055AbUBKS32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:29:28 -0500
Received: from s383.jpl.nasa.gov ([137.79.94.127]:17584 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP id S266053AbUBKS3Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:29:25 -0500
Message-ID: <402A747C.8020100@jpl.nasa.gov>
Date: Wed, 11 Feb 2004 10:29:16 -0800
From: Bryan Whitehead <driver@jpl.nasa.gov>
Organization: Jet Propulsion Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh-sg, zh-tw, ja
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
CC: linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: reiserfs for bkbits.net?
References: <200402111523.i1BFNnOq020225@work.bitmover.com> <20040211161358.GA11564@favonius> <yw1xisidino2.fsf@kth.se>
In-Reply-To: <yw1xisidino2.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> Sander <sander@humilis.net> writes:
> 
> 
>>Larry McVoy wrote (ao):
>>
>>>We're moving openlogging back to our offices and I'm experimenting
>>>with filesystems to see what gives the best performance for BK usage.
>>>Reiserfs looks pretty good and I'm wondering if anyone knows any
>>>reasons that we shouldn't use it for bkbits.net. Also, would it help
>>>if the journal was on a different disk? Most of the bkbits traffic is
>>>read so I doubt it.
>>>
>>>Please cc me, I'm not on the list.
>>
>>I've cc'ed the Reiserfs mailinglist.
>>
>>IME Reiserfs is a fast and stable fs. If you have the time to benchmark
>>ext3, reiserfs, jfs and xfs (and ..) with bk then you would know first
>>hand which fs is best for you. It might be worth the time.
> 
> 
> If someone does any tests, I'd be interested to hear about the
> results.
> 

http://pcbunn.cacr.caltech.edu/gae/3ware_raid_tests.htm

They needed 200MByte/sec disk transfer speed. this is how they got it.

-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry and Large Optical Systems
Phone: 818 354 2903
driver@jpl.nasa.gov

