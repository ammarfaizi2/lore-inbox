Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbTI3TTO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 15:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTI3TTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 15:19:02 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:37829 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261673AbTI3TS4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 15:18:56 -0400
Message-ID: <3F79D71F.2020901@namesys.com>
Date: Tue, 30 Sep 2003 23:18:55 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vitaly Fertman <vitaly@namesys.com>
CC: Zan Lynx <zlynx@acm.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, nikita@namesys.com
Subject: Re: 2.6.0-test6 crash while reading files in /proc/fs/reiserfs/sda1
References: <1064936688.4222.14.camel@localhost.localdomain> <200309302006.32584.vitaly@namesys.com>
In-Reply-To: <200309302006.32584.vitaly@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Fertman wrote:

>Hi
>
>On Tuesday 30 September 2003 19:44, Zan Lynx wrote:
>  
>
>>I was interested in the contents of the files in /proc/fs/reiserfs/sda1,
>>so I did these commands:
>>
>>cd /proc/fs/reiserfs/sda1
>>grep . *
>>
>>(I like using the grep . * because it labels the contents of each file
>>with the filename.)
>>
>>I did this as a regular user and also as root.  Both times the system
>>crashed and immediately rebooted.  I tried it again as root and the
>>system froze instead.
>>    
>>
>
>which kernel do you use? some patches? could you look into syslog and
>send us all relevant information.
>
>would you also run cat on all files there separately to detect the fault one.
>
>  
>
>>The system is basically RedHat 9.  The kernel was compiled with GCC
>>3.2.2.  I attached a compressed lsmod and kernel configuration to this
>>message.
>>    
>>
>
>no you do not.
>
>  
>
>>The CPU is an Athlon XP 2000+, the SCSI adapter is a LSI Logic 53c1010
>>Ultra3 64 bit adapter running on a 32 bit bus.  (lspci output is also
>>attached.)  The SCSI drive is a Seagate X15.3.
>>
>>Thanks for looking at this.
>>    
>>
>
>  
>
nikita, if vitaly doesn't solve it before you get in, it is yours to solve.

Vitaly, what configuration did you fail to replicate it using (I hope 
you attempted it on your machine before asking the user all this)?

-- 
Hans


