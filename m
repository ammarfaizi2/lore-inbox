Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262095AbSI3N61>; Mon, 30 Sep 2002 09:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262082AbSI3NzV>; Mon, 30 Sep 2002 09:55:21 -0400
Received: from [203.117.131.12] ([203.117.131.12]:17108 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S262095AbSI3Nob>; Mon, 30 Sep 2002 09:44:31 -0400
Message-ID: <3D98567E.5010502@metaparadigm.com>
Date: Mon, 30 Sep 2002 21:49:50 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Kevin Corry <corryk@us.ibm.com>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: v2.6 vs v3.0
References: <200209290114.15994.jdickens@ameritech.net> <20020929214652.GF12928@merlin.emma.line.org> <3D97F7AE.5070304@metaparadigm.com> <02093008055700.15956@boiler>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/02 21:05, Kevin Corry wrote:
> On Monday 30 September 2002 02:05, Michael Clark wrote:
> 
>>On 09/30/02 05:46, Matthias Andree wrote:
>>
>>>Is not EVMS ready for the show? Is Linux >=2.6 going to have LVM2 and
>>>EVMS? Or just LVM2? I'm not aware of the current status, but I do recall
>>>having seen EVMS stable announcements (but not sure about 2.5 status).
>>
>> From reading the EVMS list, it was working with 2.5.36 a couple weeks
>>ago but needs some small bio and gendisk changes to work in 2.5.39.
>>
>>http://sourceforge.net/mailarchive/forum.php?thread_id=1105826&forum_id=2003
>>
>>CVS version may be up-to-date quite soon from reading the thread.
>>It seems to be further along in 2.5 support than LVM2 - also including
>>the fact that EVMS supports LVM1 metadata (which the 2.5 version of LVM2
>>may not do so quite so soon from mentions on the lvm list).
>>
>>I haven't tried EVMS but certainly from looking at the feature set,
>>it looks more comprehensive and modular than LVM (with its support
>>for multiple metadata personalities).
>>
>>I too have LVM on quite a few of my machines, including my desktop,
>>and if I wanted to test 2.5 right now - i'd probably have to do it
>>using EVMS.
> 
> 
> EVMS is now up-to-date and running on 2.5.39. You can get the latest kernel 
> code from CVS (http://sourceforge.net/cvs/?group_id=25076) or Bitkeepr 
> (http://evms.bkbits.net/). There will be a new, full release (1.2) coming out 
> this week.

Yes, i just booted up with EVMS CVS on 2.5.39. Detected all my LVM LV's fine.
After cautious tests with them mounted ro, i then preceded to mount them rw
and continued boot up. Working fine so far. Great work.

All i needed to do was change my vgscan to evms_vgscan and adjust my mount
points to the new style ( /dev/evms/lvm/<vg></<lv> ).

~mc

