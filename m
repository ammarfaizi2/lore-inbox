Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUBKSzu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266162AbUBKSzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:55:50 -0500
Received: from ti200710a080-3502.bb.online.no ([80.213.45.174]:50927 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S266139AbUBKSzs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:55:48 -0500
To: Bryan Whitehead <driver@jpl.nasa.gov>
Cc: linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: reiserfs for bkbits.net?
References: <200402111523.i1BFNnOq020225@work.bitmover.com>
	<20040211161358.GA11564@favonius> <yw1xisidino2.fsf@kth.se>
	<402A747C.8020100@jpl.nasa.gov>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 11 Feb 2004 19:55:24 +0100
In-Reply-To: <402A747C.8020100@jpl.nasa.gov> (Bryan Whitehead's message of
 "Wed, 11 Feb 2004 10:29:16 -0800")
Message-ID: <yw1xd68lxx7n.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Whitehead <driver@jpl.nasa.gov> writes:

> Måns Rullgård wrote:
>> Sander <sander@humilis.net> writes:
>>
>>>Larry McVoy wrote (ao):
>>>
>>>>We're moving openlogging back to our offices and I'm experimenting
>>>>with filesystems to see what gives the best performance for BK usage.
>>>>Reiserfs looks pretty good and I'm wondering if anyone knows any
>>>>reasons that we shouldn't use it for bkbits.net. Also, would it help
>>>>if the journal was on a different disk? Most of the bkbits traffic is
>>>>read so I doubt it.
>>>>
>>>>Please cc me, I'm not on the list.
>>>
>>>I've cc'ed the Reiserfs mailinglist.
>>>
>>>IME Reiserfs is a fast and stable fs. If you have the time to benchmark
>>>ext3, reiserfs, jfs and xfs (and ..) with bk then you would know first
>>>hand which fs is best for you. It might be worth the time.
>> If someone does any tests, I'd be interested to hear about the
>> results.
>>
>
> http://pcbunn.cacr.caltech.edu/gae/3ware_raid_tests.htm
>
> They needed 200MByte/sec disk transfer speed. this is how they got it.

I was thinking of typical BK workloads on less extreme hardware, in my
case software RAID 0+1 on normal IDE disks.

-- 
Måns Rullgård
mru@kth.se
