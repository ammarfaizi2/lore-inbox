Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284849AbRLLBT5>; Tue, 11 Dec 2001 20:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284944AbRLLBTj>; Tue, 11 Dec 2001 20:19:39 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:59622
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S284933AbRLLBT1>; Tue, 11 Dec 2001 20:19:27 -0500
Date: Tue, 11 Dec 2001 20:15:12 -0500
From: Chris Mason <mason@suse.com>
To: Johan Ekenberg <johan@ekenberg.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: SV: Lockups with 2.4.14 and 2.4.16
Message-ID: <2545860000.1008119712@tiny>
In-Reply-To: <001001c182a8$8624a670$050010ac@FUTURE>
In-Reply-To: <001001c182a8$8624a670$050010ac@FUTURE>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, December 12, 2001 02:01:25 AM +0100 Johan Ekenberg
<johan@ekenberg.se> wrote:

>> >## Kernel:
>> >  - 2.4.14 and 2.4.16
>> >  - Patched for reiserfs-quota with patches found at
>> >    ftp://ftp.suse.com/pub/people/mason/patches/reiserfs/quota-2.4/
>> >      ( * 50_quota-patch
>> >        * dquota_deadlock
>> >        * nesting
>> >        * reiserfs-quota )
>> 
>> For the 2.4.16 kernel, you used the quota patches from my 2.4.16 dir?
> 
> Yes.
> 
>> The fastest way to rule out filesystem deadlocks is to hook up a serial
>> console and send me the decoded output of sysrq-t.
> 
> I'll look into this. A bit of a problem since there are 10 servers and you
> never know which one is going to lockup next time. Do I really need 10 PC's
> to monitor them simultaneously or could it be done more efficiently? I'm no
> kernel hacker, any pointers as to what tools to use etc would be most
> welcome.

For this case, it is enough to configure each kernel to allow a serial
console, wait for a machine to lockup, plugin the serial cable to that one
machine, and then do the sysrq-t.

But, test that method first ;-)  You can hit sysrq-t at any time without
breaking things.

-chris

