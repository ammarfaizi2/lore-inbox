Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUIJIwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUIJIwS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUIJIwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:52:18 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:28131 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S267319AbUIJIvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:51:41 -0400
Message-ID: <41416B1B.5060708@blueyonder.co.uk>
Date: Fri, 10 Sep 2004 09:51:39 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.9-rc1-bk16 Still cdrom/DVD oops
References: <4140F3A7.8040103@blueyonder.co.uk> <1094776333.1396.31.camel@krustophenia.net> <4140FC70.1070101@blueyonder.co.uk>
In-Reply-To: <4140FC70.1070101@blueyonder.co.uk>
Content-Type: multipart/mixed;
 boundary="------------000201040201080304080103"
X-OriginalArrivalTime: 10 Sep 2004 08:52:04.0769 (UTC) FILETIME=[7219E910:01C49713]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000201040201080304080103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sid Boyce wrote:

> Lee Revell wrote:
>
>> On Thu, 2004-09-09 at 20:21, Sid Boyce wrote:
>>  
>>
>>> Sep 10 01:15:11 barrabas kernel: Modules linked in: nvidia 
>>> parport_pc lp   
>>
>>
>> Your kernel is tainted.  Please reproduce with an untainted kernel and
>> report.
>>
>> Lee
>>
>>
>>
>>  
>>
> The only tainted module is "nvidia", the results are the same without 
> that module loaded in -bk15, i.e in runlevel 3. I've seen this problem 
> on all kernels from 2.6.8.1 including -mm?. It's fine with 
> 2.6.8-rc4-mm1, the earliest kernel I currently have around.
> Regards
> Sid.
>


-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====


--------------000201040201080304080103
Content-Type: text/plain;
 name="BK16_no_nv"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BK16_no_nv"

Sep 10 09:17:05 barrabas automount[10290]: attempting to mount entry /media/cdrom
Sep 10 09:17:06 barrabas kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Sep 10 09:17:06 barrabas kernel: ISO 9660 Extensions: RRIP_1991A
Sep 10 09:17:06 barrabas kernel: Unable to handle kernel paging request at virtual address c7674ef4
Sep 10 09:17:06 barrabas kernel:  printing eip:
Sep 10 09:17:06 barrabas kernel: c01459a1
Sep 10 09:17:06 barrabas kernel: *pde = 0001d067
Sep 10 09:17:06 barrabas kernel: *pte = 07674000
Sep 10 09:17:06 barrabas kernel: Oops: 0000 [#2]
Sep 10 09:17:06 barrabas kernel: PREEMPT DEBUG_PAGEALLOC
Sep 10 09:17:06 barrabas kernel: Modules linked in: nls_iso8859_1 parport_pc lp parport sg st sd_mod sr_mod scsi_mod thermal processor sk98lin usblp fan ub usbhid snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss eeprom button snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc ipv6 asb100 i2c_sensor gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ohci1394 ieee1394 ehci_hcd ohci_hcd nvidia_agp agpgart evdev usbcore forcedeth vfat fat dm_mod
Sep 10 09:17:06 barrabas kernel: CPU:    0
Sep 10 09:17:06 barrabas kernel: EIP:    0060:[cache_free_debugcheck+385/640]    Not tainted VLI
Sep 10 09:17:06 barrabas kernel: EIP:    0060:[<c01459a1>]    Not tainted VLI
Sep 10 09:17:06 barrabas kernel: EFLAGS: 00010002   (2.6.9-rc1-bk16) 
Sep 10 09:17:06 barrabas kernel: EIP is at cache_free_debugcheck+0x181/0x280
Sep 10 09:17:06 barrabas automount[11299]: mount(generic): failed to mount /dev/cdrom (type auto) on /media/cdrom
Sep 10 09:17:06 barrabas kernel: eax: c7674ef4   ebx: 80052c00   ecx: c01cd040   edx: c7674000
Sep 10 09:17:06 barrabas kernel: esi: dffef640   edi: c98e05f4   ebp: c7693d24   esp: c7693cfc
Sep 10 09:17:06 barrabas automount[10290]: attempting to mount entry /media/cdrom
Sep 10 09:17:06 barrabas kernel: ds: 007b   es: 007b   ss: 0068
Sep 10 09:17:07 barrabas kernel: Process mount (pid: 11300, threadinfo=c7692000 task=c765fab0)
Sep 10 09:17:07 barrabas kernel: Stack: 07672000 00000640 c14d9f78 c7674000 07674000 c01cd040 c7674000 dffef640 
Sep 10 09:17:07 barrabas kernel:        c14d9f78 c7674ef8 c7693d3c c014664a 00000282 c7674ef8 c7674fe5 00000000 
Sep 10 09:17:07 barrabas kernel:        c7693d90 c01cd040 c0377bcc 00000041 c015b2c0 c7674ef8 c76b0eb8 00000027 
Sep 10 09:17:07 barrabas kernel: Call Trace:
Sep 10 09:17:07 barrabas kernel:  [show_stack+166/176] show_stack+0xa6/0xb0
Sep 10 09:17:07 barrabas kernel:  [<c0106e06>] show_stack+0xa6/0xb0
Sep 10 09:17:07 barrabas kernel:  [show_registers+333/448] show_registers+0x14d/0x1c0
Sep 10 09:17:07 barrabas kernel:  [<c0106f7d>] show_registers+0x14d/0x1c0
Sep 10 09:17:07 barrabas kernel:  [die+240/384] die+0xf0/0x180
Sep 10 09:17:07 barrabas kernel:  [<c0107170>] die+0xf0/0x180
Sep 10 09:17:07 barrabas kernel:  [do_page_fault+1047/1467] do_page_fault+0x417/0x5bb
Sep 10 09:17:07 barrabas kernel:  [<c0118f47>] do_page_fault+0x417/0x5bb
Sep 10 09:17:07 barrabas kernel:  [error_code+45/56] error_code+0x2d/0x38
Sep 10 09:17:07 barrabas kernel:  [<c01069e5>] error_code+0x2d/0x38
Sep 10 09:17:07 barrabas kernel:  [kfree+74/144] kfree+0x4a/0x90
Sep 10 09:17:07 barrabas kernel:  [<c014664a>] kfree+0x4a/0x90
Sep 10 09:17:07 barrabas kernel:  [parse_rock_ridge_inode_internal+1424/1696] parse_rock_ridge_inode_internal+0x590/0x6a0
Sep 10 09:17:07 barrabas kernel:  [<c01cd040>] parse_rock_ridge_inode_internal+0x590/0x6a0
Sep 10 09:17:07 barrabas kernel:  [parse_rock_ridge_inode+24/80] parse_rock_ridge_inode+0x18/0x50
Sep 10 09:17:07 barrabas kernel:  [<c01cd318>] parse_rock_ridge_inode+0x18/0x50
Sep 10 09:17:07 barrabas kernel:  [isofs_read_inode+809/1072] isofs_read_inode+0x329/0x430
Sep 10 09:17:07 barrabas kernel:  [<c01cbd69>] isofs_read_inode+0x329/0x430
Sep 10 09:17:07 barrabas kernel:  [isofs_iget+86/112] isofs_iget+0x56/0x70
Sep 10 09:17:07 barrabas kernel:  [<c01cbf26>] isofs_iget+0x56/0x70
Sep 10 09:17:07 barrabas kernel:  [isofs_fill_super+1252/1632] isofs_fill_super+0x4e4/0x660
Sep 10 09:17:07 barrabas kernel:  [<c01cb284>] isofs_fill_super+0x4e4/0x660
Sep 10 09:17:07 barrabas kernel:  [get_sb_bdev+194/288] get_sb_bdev+0xc2/0x120
Sep 10 09:17:07 barrabas kernel:  [<c0160cf2>] get_sb_bdev+0xc2/0x120
Sep 10 09:17:07 barrabas kernel:  [isofs_get_sb+26/32] isofs_get_sb+0x1a/0x20
Sep 10 09:17:07 barrabas kernel:  [<c01cbf5a>] isofs_get_sb+0x1a/0x20
Sep 10 09:17:07 barrabas kernel:  [do_kern_mount+148/352] do_kern_mount+0x94/0x160
Sep 10 09:17:07 barrabas kernel:  [<c0160f64>] do_kern_mount+0x94/0x160
Sep 10 09:17:07 barrabas kernel:  [do_new_mount+100/176] do_new_mount+0x64/0xb0
Sep 10 09:17:07 barrabas kernel:  [<c01771a4>] do_new_mount+0x64/0xb0
Sep 10 09:17:07 barrabas kernel:  [do_mount+403/448] do_mount+0x193/0x1c0
Sep 10 09:17:07 barrabas kernel:  [<c0177913>] do_mount+0x193/0x1c0
Sep 10 09:17:07 barrabas kernel:  [sys_mount+136/272] sys_mount+0x88/0x110
Sep 10 09:17:07 barrabas kernel:  [<c0177cb8>] sys_mount+0x88/0x110
Sep 10 09:17:07 barrabas kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep 10 09:17:07 barrabas kernel:  [<c0105f89>] sysenter_past_esp+0x52/0x71
Sep 10 09:17:07 barrabas kernel: Code: 38 eb a1 8d b4 26 00 00 00 00 8b 55 f0 89 f0 e8 16 e5 ff ff 8b 55 ec 89 10 8b 5e 38 e9 57 ff ff ff 8b 55 f0 89 f0 e8 8f e4 ff ff <81> 38 a5 c2 0f 17 0f 84 8b 00 00 00 b9 14 f2 35 c0 89 f2 b8 27 

--------------000201040201080304080103--
