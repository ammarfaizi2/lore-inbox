Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbUDDWag (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 18:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbUDDWag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 18:30:36 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:47318 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261388AbUDDWac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 18:30:32 -0400
Message-ID: <40708CE2.3030105@blueyonder.co.uk>
Date: Sun, 04 Apr 2004 23:32:02 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.5 x86_64 still broken - was Re: 2.6.5-rc3-mm4
References: <406CD984.2010200@blueyonder.co.uk> <406E9B1D.7070201@blueyonder.co.uk>
In-Reply-To: <406E9B1D.7070201@blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2004 22:30:32.0304 (UTC) FILETIME=[70CAD700:01C41A94]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SysRq-P (it should have said below)  gives similar output on 2.6.5, 
definitely looks like something that was changed in 2.6.5-rc3.
Regards
Sid.

Sid Boyce wrote:

> Sid Boyce wrote:
>
>> My x86_64 Acer 1501LCe laptop problem persists, it freezes at the 
>> same point with the HD light on solid. Boot proceeds normally up to 
>> "found reiserfs format "3.6" with standard journal".
>> Regards
>> Sid.
>>
> Tried using netconsole, but no network traffic, suppose because the 
> network is not yet up, so I can't get a call trace captured with ...
> netconsole=6665@192.168.10.5/eth0,6666@192.168.10.1/00:40:95:30:db:5b
>
> From SysRq-B
> ============
> Uniform CD-ROM driver Revision: 3.20
> mice: PS/2 mouse device common for all mice
> input: PC Speaker
> i8042.c: Detected active multiplexing controller, rev 1.1.
> serio: i8042 AUX0 port at 0x60,0x64 irq 12
> serio: i8042 AUX1 port at 0x60,0x64 irq 12
> serio: i8042 AUX2 port at 0x60,0x64 irq 12
> serio: i8042 AUX3 port at 0x60,0x64 irq 12
> Synaptics Touchpad, model: 1
> Firmware: 5.8
> 180 degree mounted touchpad
> Sensor: 18
> new absolute packet format
> Touchpad has extended capability bits
> -> 4 multi-buttons, i.e besides standard buttons
> -> multifinger detection
> -> palm detection
> input: SynPS/2 Synaptics TouchPad on isa0060/serio4
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: AT Translated Set 2 keyboard on isa0060/serio0
> NET: Registered protocol family 2
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 32768)
> Net: Registered protocol family 1
> ACPI: (supports S0 S3 S4 S5)
> found reiserfs format "3.6" with standard journal
> SysRq: Show Regs
>
> Pid: 0, comm: swapper Not tainted 2.6.5-rc3-mm4
> RIP: 0010:[<ffffffff8010e660>] <ffffffff80103660>{default_idle+32}
> RSP: 0000:ffffffff8050ffc8  EFLAGS: 00000246
> RAX: 0000000000000000 RBX: ffffffff8010e640 RCX: ffffffff8040ca40
> RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 000001001fe86040
> RBP: 0000000000000000 R08: ffffffff8050e000 R09: 00000000ffffffff
> R10: 0000000000000000 R11: 00000000ad55ad55 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff80507800(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
>
> Call Trace:<ffffffff8010f5da>{cpu_idle+26} 
> <ffffffff805117ad>{start_kernel+509}
>       <ffffffff805110e5>{__init_begin+229}
> Regards
> Sid.
>


-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

