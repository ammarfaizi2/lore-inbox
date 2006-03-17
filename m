Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbWCQN7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbWCQN7N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWCQN7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:59:13 -0500
Received: from paris.swi.hu ([195.70.32.254]:56232 "EHLO paris.swi.hu")
	by vger.kernel.org with ESMTP id S932711AbWCQN7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:59:12 -0500
Message-ID: <441AC0A5.7000007@swi.co.hu>
Date: Fri, 17 Mar 2006 14:59:01 +0100
From: Ivancso Krisztian <ivan@swi.co.hu>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: random freeze
References: <440DCAF1.2020102@swi.co.hu>	 <9a8748490603071223k128ca34lc0fd9c416e4bca36@mail.gmail.com> <9a8748490603071225mae1861ap3d1ef9e7e0040875@mail.gmail.com>
In-Reply-To: <9a8748490603071225mae1861ap3d1ef9e7e0040875@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------090908050805010208000501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090908050805010208000501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jesper Juhl wrote:
> On 3/7/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>   
>> On 3/7/06, Ivancso Krisztian <ivan@swi.co.hu> wrote:
>>     
>>> Hi!
>>>
>>> I have an IBM xSeries 235, which randomly freeze. I tried many kernels.
>>>
>>>       
>> [snip]
>>
>> If this is reproducible could you please try 2.6.16-rc5-git10 and/or
>> 2.6.16-rc5-mm2 and send the Oops report from those kernels please?
>>
>>     
>
> Sorry, make that 2.6.16-rc5-git10 and/or 2.6.16-rc5-mm3.
>
>   
Thanks for your quick answer.

I attached a kernel trace.

kernel: 2.6.16-rc5-git10 (with this kernel the machine seem to stable)

I think this symptom is not related to the previous one. I can reproduce 
this (with earlier kernels also).
I used IBM's ipssend: after "ipssend GETBST 1" system freezed.


Thx,
ivan



--------------090908050805010208000501
Content-Type: text/plain;
 name="db_netcons.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="db_netcons.log"

XFS mounting filesystem sda6
XFS mounting filesystem sda7
XFS mounting filesystem sda8
skge eth1: enabling interface
skge eth1: Link is up at 1000 Mbps, full duplex, flow control tx and rx
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
printk: 3 messages suppressed.
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
printk: 2 messages suppressed.
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
printk: 1 messages suppressed.
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
printk: 7 messages suppressed.
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
printk: 7 messages suppressed.
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
printk: 5 messages suppressed.
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
sg_write: data in/out 4304/4304 bytes for SCSI command 0xd--guessing data in;
   program ipssend not setting count and/or reply_len properly
------------[ cut here ]------------
kernel BUG at block/ll_rw_blk.c:3344!
invalid opcode: 0000 [#1]
SMP 
Modules linked in: dm_mod nfs lockd nfs_acl sunrpc netconsole skge tg3
CPU:    0
EIP:    0060:[<c0248a3b>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16-rc5-git10-ibm-xeon-deltha #1) 
EIP is at blk_complete_request+0x49/0x53
eax: f7b13bb0   ebx: c22566a4   ecx: 00000000   edx: f0d94200
esi: f7309b74   edi: c2256400   ebp: f79adb90   esp: c03e1ec8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03e0000 task=c0392100)
Stack: <0>c22566a4 c22566d4 c02cd553 f7309b74 c03e1edc 000c910b c22566a4 00000000 
       c22566a4 c22566d4 c2256400 00000000 c02cbcfd c22566a4 f79adb90 c01283d6 
       00002400 f7a586c0 c22566a4 c02d0493 c22566a4 f7a586c0 00000000 c03e1f80 
Call Trace:
 [<c02cd553>] ipsintr_done+0xce/0x31b
 [<c02cbcfd>] ips_intr_morpheus+0x75/0xc3
 [<c01283d6>] do_timer+0x39/0x420
 [<c02d0493>] do_ipsintr+0x4b/0x7f
 [<c013f308>] handle_IRQ_event+0x39/0x69
 [<c013f3b9>] __do_IRQ+0x81/0xe8
 [<c01050f9>] do_IRQ+0x19/0x24
 [<c01036a2>] common_interrupt+0x1a/0x20
 [<c0101a69>] default_idle+0x0/0x55
 [<c0101a95>] default_idle+0x2c/0x55
 [<c0101b1e>] cpu_idle+0x60/0x75
 [<c03e24cf>] start_kernel+0x2de/0x357
 [<c03e2548>] unknown_bootoption+0x0/0x278
Code: e0 8b 40 10 03 14 85 20 31 41 c0 8d 46 08 8b 4a 04 89 42 04 89 56 08 89 48 04 89 01 b8 04 00 00 00 e8 c3 c1 ed ff 53 9d 5b 5e c3 <0f> 0b 10 0d 26 7e 36 c0 eb bd 8b 54 24 04 8b 82 f8 00 00 00 b9 
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 
--------------090908050805010208000501--
