Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290543AbSAYFEG>; Fri, 25 Jan 2002 00:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290557AbSAYFD4>; Fri, 25 Jan 2002 00:03:56 -0500
Received: from host113.south.iit.edu ([216.47.130.113]:30592 "EHLO
	lostlogicx.com") by vger.kernel.org with ESMTP id <S290543AbSAYFDp>;
	Fri, 25 Jan 2002 00:03:45 -0500
Message-ID: <3C50E72F.6070909@lostlogicx.com>
Date: Thu, 24 Jan 2002 23:03:43 -0600
From: Lost Logic <lostlogic@lostlogicx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Corruption under 2.4.18-pre6-O1J5 [+2.4.17]
In-Reply-To: <3C50D104.2050608@lostlogicx.com> <3C50E480.6B5F7591@cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had let mine go too long (due to server problems) and therefore had to 
reiserfsck --rebuild-tree inorder to fix the stuff up.

Richard Kinder wrote:

>I have experienced corruption under 2.4.17 similar to this, not massive, but
>enough corruption to severely restrict operation - files in /etc were
>corrupted, mtab couldn't be created on boot thus no other drives were mounted.
>Machine was shut down properly prior to this, no oopses or other strange
>behaviour (other than my inability to get a Sycard PCMCIA adapter working)
>
>I was still able to log in as root and force a check of / on next reboot,
>which fixed the problem up (about 3 files were cleared, including mtab, IIRC).
>
>Config file/system details available if anyone is interested.
>
>Regards,
>    Richard
>
>Lost Logic wrote:
>
>>I use Reiserfs for all of my partitions, and soon after upgrading to
>>linux-2.4.18-pre6-O1J5 I started getting massive data corruption in my
>>/etc directory, strangely enough ONLY in that directory.  I've attached
>>the .config I used for that kernel, unfortunately I have been unable to
>>do further testing, because at the same time I had problems on my
>>production box, and had to use my toy box to fix it (so I couldn't
>>afford to have my toy box down any more).
>>
>>Hope this is helpful/interesting!
>>
>>--Brandon
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



