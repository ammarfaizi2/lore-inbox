Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbTJXU7f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 16:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbTJXU7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 16:59:35 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:19115 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S262611AbTJXU73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 16:59:29 -0400
Message-ID: <3F997B35.9050500@blue-labs.org>
Date: Fri, 24 Oct 2003 15:19:17 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: suspend-to-ram problem, 2.6.0-test8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

two things.  kernel has a bit of a problem with the uhci stuff and the 
kernel has issues stopping artsd.  artsd gets into D-state and the 
machine has to be rebooted. (STR is the only suspend that works for me 
by the way).  if there are any questions, please ask.

PM: Preparing system for suspend
Stopping tasks: 
========================================================================|
hdb: start_power_step(step: 0)
hdb: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Entering state.
Back to C!
PM: Finishing up.
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1f.5 to 64
orinoco_lock() called with hw_unavailable (dev=dceca7f8)
orinoco_lock() called with hw_unavailable (dev=dceca7f8)
drivers/usb/host/uhci-hcd.c: bf80: host system error, PCI problems?
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
orinoco_lock() called with hw_unavailable (dev=dceca7f8)
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host system error, PCI problems?
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
orinoco_lock() called with hw_unavailable (dev=dceca7f8)
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
orinoco_lock() called with hw_unavailable (dev=dceca7f8)
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
orinoco_lock() called with hw_unavailable (dev=dceca7f8)
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
orinoco_lock() called with hw_unavailable (dev=dceca7f8)
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
orinoco_lock() called with hw_unavailable (dev=dceca7f8)
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
orinoco_lock() called with hw_unavailable (dev=dceca7f8)
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
orinoco_lock() called with hw_unavailable (dev=dceca7f8)
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
orinoco_lock() called with hw_unavailable (dev=dceca7f8)
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
orinoco_lock() called with hw_unavailable (dev=dceca7f8)
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
orinoco_lock() called with hw_unavailable (dev=dceca7f8)
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue df5b5bf8, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdb: Wakeup request inited, waiting for !BSY...
hdb: start_power_step(step: 1000)
hdb: completing PM request, resume
drivers/acpi/osl.c:734: spin_lock(drivers/acpi/osl.c:dffe0cb0) already 
locked by drivers/acpi/osl.c/734
drivers/acpi/osl.c:753: spin_unlock(drivers/acpi/osl.c:dffe0cb0) not locked
Restarting tasks...<3>drivers/usb/host/uhci-hcd.c: bf80: host controller 
halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
 done
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf80: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: bf20: host controller halted. very bad



david@powerix david $ ps aux|grep arts
david     3821  1.1  1.2 10520 6548 ?        D    Oct23  10:37 
//usr/kde/3.1/bin/artsd -F 12 -S 4096 -a alsa -d -b 16 -m artsmessage -l 
2 -f

david@powerix david $ ps -eo pid,args,wchan|grep 3821
 3821 //usr/kde/3.1/bi down

artsd         D D7D2E118     0  3821   3378          4917  3600 (NOTLB)
cad85ea8 00200082 df8d5960 d7d2e118 00000000 df315df8 00000000 d0e52960
       cad85ebc c0112035 d7d2e118 00000000 df8d5960 0000be02 d7d84ba0 
00000000
       d0e52960 df3ace24 00200246 cad84000 df3ace2c c0108155 df315df8 
0000000e
Call Trace:
 [<c0112035>] do_gettimeofday+0x19/0x86
 [<c0108155>] __down+0x133/0x32c
 [<c03c01e0>] snd_pcm_action_single+0x5f/0x61
 [<c01259bd>] default_wake_function+0x0/0x2e
 [<c03c5fcb>] snd_pcm_playback_ioctl+0x0/0x33
 [<c0108830>] __down_failed+0x8/0xc
 [<c03c6f0e>] .text.lock.pcm_native+0x2d/0xcb
 [<c03c55cb>] snd_pcm_playback_ioctl1+0x52/0x610
 [<c0113df9>] restore_i387+0x98/0x9a
 [<c013e75d>] sys_rt_sigaction+0x123/0x141
 [<c03c5fcb>] snd_pcm_playback_ioctl+0x0/0x33
 [<c01946bb>] sys_ioctl+0x214/0x405
 [<c0130b01>] sys_gettimeofday+0x67/0xd0
 [<c010a07b>] syscall_call+0x7/0xb

aplay         D D7EACCF1     0  3839   3527                     (NOTLB)
ce2f3e00 00200082 c1b50960 d7eaccf1 00000000 0000000e 0000910f 00000000
       c0539440 00200046 d7eaccf1 00000000 c1b50960 0000c416 d826e716 
00000000
       cb156960 df320ee0 00200246 ce2f2000 df320ee8 c0108155 c02ba36b 
c03a4552
Call Trace:
 [<c0108155>] __down+0x133/0x32c
 [<c02ba36b>] poke_blanked_console+0x5c/0x6f
 [<c03a4552>] snd_card_file_add+0x1e/0x290
 [<c03a4552>] snd_card_file_add+0x1e/0x290
 [<c015c0d4>] kmem_cache_alloc+0x168/0x203
 [<c01259bd>] default_wake_function+0x0/0x2e
 [<c03a4552>] snd_card_file_add+0x1e/0x290
 [<c0108830>] __down_failed+0x8/0xc
 [<c03c6f72>] .text.lock.pcm_native+0x91/0xcb
 [<c01259bd>] default_wake_function+0x0/0x2e
 [<c03a2e8f>] snd_open+0x119/0x20f
 [<c0188808>] chrdev_open+0x21e/0x612
 [<c012414c>] kernel_map_pages+0x28/0x58
 [<c017bb4b>] get_empty_filp+0x42/0xd4
 [<c015c04a>] kmem_cache_alloc+0xde/0x203
 [<c01e2208>] devfs_open+0x263/0x280
 [<c01796c3>] dentry_open+0x143/0x204
 [<c017957e>] filp_open+0x62/0x64
 [<c0179d67>] sys_open+0x5b/0x8b
 [<c010a07b>] syscall_call+0x7/0xb


powerix root # lspci -vvs 00:1f.5
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio 
Controller (rev 02)
        Subsystem: Cirrus Logic: Unknown device 5959
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort->SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at d800 [size=256]
        Region 1: I/O ports at dc80 [size=64]

powerix root # lspci
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
Bridge (rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
(rev 04)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)


