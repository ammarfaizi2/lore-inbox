Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284814AbRLLBMR>; Tue, 11 Dec 2001 20:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284823AbRLLBMH>; Tue, 11 Dec 2001 20:12:07 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:18188 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284814AbRLLBMC>; Tue, 11 Dec 2001 20:12:02 -0500
Message-ID: <3C16AE9B.5070204@namesys.com>
Date: Wed, 12 Dec 2001 04:10:51 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Johan Ekenberg <johan@ekenberg.se>
CC: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: SV: Lockups with 2.4.14 and 2.4.16
In-Reply-To: <001001c182a8$8624a670$050010ac@FUTURE>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Ekenberg wrote:

>>>## Kernel:
>>> - 2.4.14 and 2.4.16
>>> - Patched for reiserfs-quota with patches found at
>>>   ftp://ftp.suse.com/pub/people/mason/patches/reiserfs/quota-2.4/
>>>     ( * 50_quota-patch
>>>       * dquota_deadlock
>>>       * nesting
>>>       * reiserfs-quota )
>>>
>>For the 2.4.16 kernel, you used the quota patches from my 2.4.16 dir?
>>
>
>Yes.
>
>>The fastest way to rule out filesystem deadlocks is to hook up a serial
>>console and send me the decoded output of sysrq-t.
>>
>
>I'll look into this. A bit of a problem since there are 10 servers and you
>never know which one is going to lockup next time. Do I really need 10 PC's
>to monitor them simultaneously or could it be done more efficiently? I'm no
>kernel hacker, any pointers as to what tools to use etc would be most
>welcome.
>
>Thanks,
>/Johan Ekenberg
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
You need ten serial ports.  Actually, a lot of machine rooms have all 
their servers connected via serial lines to one machine (or at least 
this was true years ago when I was a sysadmin).  It makes it a lot 
easier to administer them by remote access from home in the middle of 
the night.

Hans


