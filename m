Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269841AbVBESF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269841AbVBESF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 13:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269768AbVBESF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 13:05:26 -0500
Received: from host81-154-129-7.range81-154.btcentralplus.com ([81.154.129.7]:442
	"EHLO worthy.swandive.local") by vger.kernel.org with ESMTP
	id S273651AbVBESDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 13:03:50 -0500
Date: Sat, 5 Feb 2005 18:03:45 +0000
From: Grant Wilson <gww@btinternet.com>
To: linux-kernel@vger.kernel.org
Subject: Oops on 2.6.11-rc3-mm1
Message-ID: <20050205180345.GA3335@tlg.swandive.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I hit the following oops on 2.6.11-rc3-mm1.  I was previously running
-rc2-mm2 with no problems.

Rgds,
Grant Wilson


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oops

Feb  5 02:43:21 tlg kernel: Unable to handle kernel paging request at 00002aaaae16f000 RIP: 
Feb  5 02:43:21 tlg kernel: <ffffffff802b8172>{copy_user_generic_c+8}
Feb  5 02:43:21 tlg kernel: PGD 2f092067 PUD 2f091067 PMD 2ef96067 PTE 0
Feb  5 02:43:21 tlg kernel: Oops: 0002 [1] PREEMPT 
Feb  5 02:43:21 tlg kernel: CPU 0 
Feb  5 02:43:21 tlg kernel: Modules linked in: ipv6 snd_via82xx snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore mousedev evdev usbhid ehci_hcd uhci_hcd e100 w83627hf eeprom i2c_sensor i2c_isa i2c_viapro unix
Feb  5 02:43:21 tlg kernel: Pid: 5794, comm: gkrellm Not tainted 2.6.11-rc3-mm1
Feb  5 02:43:21 tlg kernel: RIP: 0010:[copy_user_generic_c+8/38] <ffffffff802b8172>{copy_user_generic_c+8}
Feb  5 02:43:21 tlg kernel: RSP: 0018:ffff81002f107eb0  EFLAGS: 00010206
Feb  5 02:43:21 tlg kernel: RAX: ffff81002f106000 RBX: 000000000000001b RCX: 0000000000000003
Feb  5 02:43:21 tlg kernel: RDX: 0000000000000003 RSI: ffff81000ee52000 RDI: 00002aaaae16f000
Feb  5 02:43:21 tlg kernel: RBP: ffff81000ee52000 R08: ffff81002f107ed4 R09: 000000000000001b
Feb  5 02:43:21 tlg kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000400
Feb  5 02:43:21 tlg kernel: R13: 0000000000001000 R14: 0000000000000400 R15: ffff81002f107f50
Feb  5 02:43:21 tlg kernel: FS:  00002aaaad58acb0(0000) GS:ffffffff8061a800(0000) knlGS:0000000000000000
Feb  5 02:43:21 tlg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Feb  5 02:43:21 tlg kernel: CR2: 00002aaaae16f000 CR3: 000000002f12d000 CR4: 00000000000006e0
Feb  5 02:43:21 tlg kernel: Process gkrellm (pid: 5794, threadinfo ffff81002f106000, task ffff810031918170)
Feb  5 02:43:21 tlg kernel: Stack: ffffffff801b05db ffff81003ffd6bc0 0000000000000000 00002aaaae16f000 
Feb  5 02:43:21 tlg kernel:        000000018012cfac ffff81000ee52000 0000000000000400 ffff81001d205880 
Feb  5 02:43:21 tlg kernel:        00002aaaae16f000 0000000000000000 
Feb  5 02:43:21 tlg kernel: Call Trace:<ffffffff801b05db>{proc_file_read+507} <ffffffff801760e4>{vfs_read+196} 
Feb  5 02:43:21 tlg kernel:        <ffffffff80176423>{sys_read+83} <ffffffff8010d3a6>{system_call+126} 
Feb  5 02:43:21 tlg kernel:        
Feb  5 02:43:21 tlg kernel: 
Feb  5 02:43:21 tlg kernel: Code: f3 48 a5 89 d1 f3 a4 89 c8 c3 48 8d 04 ca c3 90 90 90 90 90 
Feb  5 02:43:21 tlg kernel: RIP <ffffffff802b8172>{copy_user_generic_c+8} RSP <ffff81002f107eb0>
Feb  5 02:43:21 tlg kernel: CR2: 00002aaaae16f000
 
Feb  5 09:46:43 tlg kernel:  <1>Unable to handle kernel paging request at 00002aaaaab22000 RIP: 
Feb  5 09:46:43 tlg kernel: <ffffffff8015551b>{file_read_actor+59}
Feb  5 09:46:43 tlg kernel: PGD 36c81067 PUD 36c82067 PMD 36c83067 PTE 0
Feb  5 09:46:43 tlg kernel: Oops: 0002 [2] PREEMPT 
Feb  5 09:46:43 tlg kernel: CPU 0 
Feb  5 09:46:43 tlg kernel: Modules linked in: ipv6 snd_via82xx snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore mousedev evdev usbhid ehci_hcd uhci_hcd e100 w83627hf eeprom i2c_sensor i2c_isa i2c_viapro unix
Feb  5 09:46:43 tlg kernel: Pid: 25190, comm: pan Not tainted 2.6.11-rc3-mm1
Feb  5 09:46:43 tlg kernel: RIP: 0010:[file_read_actor+59/336] <ffffffff8015551b>{file_read_actor+59}
Feb  5 09:46:43 tlg kernel: RSP: 0018:ffff81000a6c7c58  EFLAGS: 00010246
Feb  5 09:46:43 tlg kernel: RAX: 00000000000000f9 RBX: ffff810001d6ae88 RCX: 0000000000000000
Feb  5 09:46:43 tlg kernel: RDX: 0000000000000000 RSI: ffff810001d6ae88 RDI: 00002aaaaab22000
Feb  5 09:46:43 tlg kernel: RBP: 00000000000000f9 R08: 00000000fffffffa R09: 0000000000000000
Feb  5 09:46:43 tlg kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffff81000a6c7d98
Feb  5 09:46:43 tlg kernel: R13: 0000000000001000 R14: 0000000000000000 R15: 00000000000000f9
Feb  5 09:46:43 tlg kernel: FS:  00000000437ff970(005b) GS:ffffffff8061a800(0000) knlGS:0000000000000000
Feb  5 09:46:43 tlg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Feb  5 09:46:43 tlg kernel: CR2: 00002aaaaab22000 CR3: 000000002d642000 CR4: 00000000000006e0
Feb  5 09:46:43 tlg kernel: Process pan (pid: 25190, threadinfo ffff81000a6c6000, task ffff81002aed81b0)
Feb  5 09:46:43 tlg kernel: Stack: 0000000000000001 ffff810001d6ae88 ffff81000f274250 0000000000000000 
Feb  5 09:46:43 tlg kernel:        ffff81001e7775e8 ffffffff801550f9 0000000000000000 0000000000000000 
Feb  5 09:46:43 tlg kernel:        00000000000000f8 0000000000000000 
Feb  5 09:46:43 tlg kernel: Call Trace:<ffffffff801550f9>{do_generic_mapping_read+473} <ffffffff801554e0>{file_read_actor+0} 
Feb  5 09:46:43 tlg kernel:        <ffffffff80157706>{__generic_file_aio_read+422} <ffffffff80157911>{generic_file_aio_read+49} 
Feb  5 09:46:43 tlg kernel:        <ffffffff80175fed>{do_sync_read+173} <ffffffff80167d0d>{vma_merge+301} 
Feb  5 09:46:43 tlg kernel:        <ffffffff8012d318>{finish_task_switch+56} <ffffffff80446e0a>{thread_return+118} 
Feb  5 09:46:43 tlg kernel:        <ffffffff80148540>{autoremove_wake_function+0} <ffffffff8012cfc4>{try_to_wake_up+276} 
Feb  5 09:46:43 tlg kernel:        <ffffffff801760e4>{vfs_read+196} <ffffffff80176423>{sys_read+83} 
Feb  5 09:46:43 tlg kernel:        <ffffffff8010d3a6>{system_call+126} 
Feb  5 09:46:43 tlg kernel: 
Feb  5 09:46:43 tlg kernel: Code: c6 07 00 85 c9 75 62 48 98 48 89 fa 48 8d 34 38 48 81 e2 00 
Feb  5 09:46:43 tlg kernel: RIP <ffffffff8015551b>{file_read_actor+59} RSP <ffff81000a6c7c58>
Feb  5 09:46:43 tlg kernel: CR2: 00002aaaaab22000
Feb  5 09:46:43 tlg kernel:  <4>eth0: excessive work at interrupt.
Feb  5 09:50:00 tlg smartd[4291]: Device: /dev/hda, SMART Usage Attribute: 194 Temperature_Celsius changed from 104 to 100 
Feb  5 09:50:02 tlg snmpd[4295]: Connection from 192.168.1.15 
Feb  5 09:55:01 tlg snmpd[4295]: Connection from 192.168.1.15 
Feb  5 10:00:01 tlg snmpd[4295]: Connection from 192.168.1.15 
Feb  5 10:05:01 tlg snmpd[4295]: Connection from 192.168.1.15 
Feb  5 10:07:07 tlg kernel: Unable to handle kernel paging request at 00002aaaaf43800f RIP: 
Feb  5 10:07:07 tlg kernel: <ffffffff80155541>{file_read_actor+97}
Feb  5 10:07:07 tlg kernel: PGD 272b4067 PUD 1b409067 PMD 25bcd067 PTE 0
Feb  5 10:07:07 tlg kernel: Oops: 0002 [3] PREEMPT 
Feb  5 10:07:07 tlg kernel: CPU 0 
Feb  5 10:07:07 tlg kernel: Modules linked in: ipv6 snd_via82xx snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore mousedev evdev usbhid ehci_hcd uhci_hcd e100 w83627hf eeprom i2c_sensor i2c_isa i2c_viapro unix
Feb  5 10:07:07 tlg kernel: Pid: 26546, comm: pan Not tainted 2.6.11-rc3-mm1
Feb  5 10:07:07 tlg kernel: RIP: 0010:[file_read_actor+97/336] <ffffffff80155541>{file_read_actor+97}
Feb  5 10:07:07 tlg kernel: RSP: 0018:ffff810027365bc8  EFLAGS: 00010287
Feb  5 10:07:07 tlg kernel: RAX: 00002aaaaf438000 RBX: ffff8100013a9d28 RCX: 0000000000000000
Feb  5 10:07:07 tlg kernel: RDX: 00002aaaaf437000 RSI: 00002aaaaf438010 RDI: 00002aaaaf437010
Feb  5 10:07:07 tlg kernel: RBP: 0000000000001000 R08: 00000000fffffffa R09: 0000000000000000
Feb  5 10:07:07 tlg kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffff810027365d08
Feb  5 10:07:07 tlg kernel: R13: 0000000000022ec6 R14: 0000000000000000 R15: 0000000000001000
Feb  5 10:07:07 tlg kernel: FS:  00000000417ff970(005b) GS:ffffffff8061a800(0000) knlGS:0000000000000000
Feb  5 10:07:07 tlg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Feb  5 10:07:07 tlg kernel: CR2: 00002aaaaf43800f CR3: 0000000025d63000 CR4: 00000000000006e0
Feb  5 10:07:07 tlg kernel: Process pan (pid: 26546, threadinfo ffff810027364000, task ffff81002c8b90b0)
Feb  5 10:07:07 tlg kernel: Stack: 0000000000000001 ffff8100013a9d28 ffff81001a013388 0000000000000000 
Feb  5 10:07:07 tlg kernel:        ffff81000d5fa6e8 ffffffff801550f9 ffff810027365e80 0000000000000000 
Feb  5 10:07:07 tlg kernel:        0000000000022ec5 0000000000000000 
Feb  5 10:07:07 tlg kernel: Call Trace:<ffffffff801550f9>{do_generic_mapping_read+473} <ffffffff801554e0>{file_read_actor+0} 
Feb  5 10:07:07 tlg kernel:        <ffffffff80157706>{__generic_file_aio_read+422} <ffffffff802a1c33>{xfs_read+547} 
Feb  5 10:07:07 tlg kernel:        <ffffffff8029e676>{linvfs_aio_read+102} <ffffffff8012cfac>{try_to_wake_up+252} 
Feb  5 10:07:07 tlg kernel:        <ffffffff80175fed>{do_sync_read+173} <ffffffff8011d8fc>{do_page_fault+1116} 
Feb  5 10:07:07 tlg kernel:        <ffffffff80148540>{autoremove_wake_function+0} <ffffffff8012cfac>{try_to_wake_up+252} 
Feb  5 10:07:07 tlg kernel:        <ffffffff801760e4>{vfs_read+196} <ffffffff80176423>{sys_read+83} 
Feb  5 10:07:07 tlg kernel:        <ffffffff8010d3a6>{system_call+126} 
Feb  5 10:07:07 tlg kernel: 
Feb  5 10:07:07 tlg kernel: Code: c6 46 ff 00 85 c9 75 3b 48 89 de 48 2b 35 05 e7 47 00 48 b8 
Feb  5 10:07:07 tlg kernel: RIP <ffffffff80155541>{file_read_actor+97} RSP <ffff810027365bc8>
Feb  5 10:07:07 tlg kernel: CR2: 00002aaaaf43800f
Feb  5 10:07:54 tlg udev[27671]: removing device node '/dev/vcs7'
Feb  5 10:07:54 tlg udev[27672]: removing device node '/dev/vcsa7'
Feb  5 10:07:54 tlg shutdown[27668]: shutting down for system reboot
--IJpNTDwzlM2Ie8A6--
