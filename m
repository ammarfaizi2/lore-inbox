Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267808AbUJLVEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbUJLVEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUJLVEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:04:45 -0400
Received: from mail4.utc.com ([192.249.46.193]:467 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S267779AbUJLVEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:04:08 -0400
Message-ID: <416C452E.4080006@cybsft.com>
Date: Tue, 12 Oct 2004 15:57:18 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T8
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
In-Reply-To: <20041012195424.GA3961@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050903090504070806010501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050903090504070806010501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i've uploaded the -T8 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T8
> 
> lots of stabilization of CONFIG_PREEMPT_REALTIME. It's still in
> experimental status but general stability is improving.
> 

Booted part way this time but then soft locked. Mouse was still working 
but not KB. Any idea why the KB is not working with these? I am 
rebuilding with all of the pwr managment off because I am still getting 
acpi messages in the boot :-/ I have attached the log from the boot.

kr

--------------050903090504070806010501
Content-Type: text/plain;
 name="rtpreT8.dump"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="rtpreT8.dump"

Oct 12 15:33:34 swdev14 syslogd 1.4.1: restart.
Oct 12 15:33:34 swdev14 syslog: syslogd startup succeeded
Oct 12 15:33:34 swdev14 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct 12 15:33:34 swdev14 syslog: klogd startup succeeded
Oct 12 15:33:34 swdev14 kernel: Linux version 2.6.9-rc4-mm1-VP-T8 (aaektkf@swdev14.rkd.snds.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #11 SMP Tue Oct 12 15:25:18 CDT 2004
Oct 12 15:33:34 swdev14 kernel: BIOS-provided physical RAM map:
Oct 12 15:33:34 swdev14 kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Oct 12 15:33:34 swdev14 kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Oct 12 15:33:34 swdev14 kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Oct 12 15:33:34 swdev14 kernel:  BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
Oct 12 15:33:34 swdev14 kernel:  BIOS-e820: 000000001ff70000 - 000000001ff77000 (ACPI data)
Oct 12 15:33:34 swdev14 kernel:  BIOS-e820: 000000001ff77000 - 000000001ff80000 (ACPI NVS)
Oct 12 15:33:34 swdev14 kernel:  BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
Oct 12 15:33:34 swdev14 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Oct 12 15:33:34 swdev14 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Oct 12 15:33:35 swdev14 kernel:  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
Oct 12 15:33:35 swdev14 kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Oct 12 15:33:35 swdev14 kernel: 0MB HIGHMEM available.
Oct 12 15:33:35 swdev14 irqbalance: irqbalance startup succeeded
Oct 12 15:33:35 swdev14 kernel: 511MB LOWMEM available.
Oct 12 15:33:35 swdev14 kernel: found SMP MP-table at 000f6b00
Oct 12 15:33:35 swdev14 kernel: DMI present.
Oct 12 15:33:35 swdev14 portmap: portmap startup succeeded
Oct 12 15:33:35 swdev14 kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Oct 12 15:33:35 swdev14 kernel: Processor #0 15:2 APIC version 20
Oct 12 15:33:35 swdev14 kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Oct 12 15:33:35 swdev14 kernel: Processor #6 15:2 APIC version 20
Oct 12 15:33:35 swdev14 kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Oct 12 15:33:35 swdev14 kernel: Processor #1 15:2 APIC version 20
Oct 12 15:33:35 swdev14 kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Oct 12 15:33:35 swdev14 kernel: Processor #7 15:2 APIC version 20
Oct 12 15:33:35 swdev14 kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Oct 12 15:33:35 swdev14 kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Oct 12 15:33:35 swdev14 kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Oct 12 15:33:35 swdev14 kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Oct 12 15:33:35 swdev14 kernel: Using ACPI for processor (LAPIC) configuration information
Oct 12 15:33:35 swdev14 kernel: Intel MultiProcessor Specification v1.4
Oct 12 15:33:35 swdev14 kernel:     Virtual Wire compatibility mode.
Oct 12 15:33:35 swdev14 kernel: OEM ID:   Product ID: PLACER CRB   APIC at: 0xFEE00000
Oct 12 15:33:35 swdev14 kernel: I/O APIC #2 Version 32 at 0xFEC00000.
Oct 12 15:33:35 swdev14 kernel: I/O APIC #3 Version 32 at 0xFEC80000.
Oct 12 15:33:35 swdev14 kernel: I/O APIC #4 Version 32 at 0xFEC80100.
Oct 12 15:33:35 swdev14 rpc.statd[2649]: Version 1.0.6 Starting
Oct 12 15:33:35 swdev14 kernel: Enabling APIC mode:  Flat.  Using 3 I/O APICs
Oct 12 15:33:35 swdev14 kernel: Processors: 4
Oct 12 15:33:35 swdev14 kernel: Built 1 zonelists
Oct 12 15:33:35 swdev14 kernel: Initializing CPU#0
Oct 12 15:33:35 swdev14 nfslock: rpc.statd startup succeeded
Oct 12 15:33:35 swdev14 kernel: Kernel command line: ro root=LABEL=/ noapic
Oct 12 15:33:35 swdev14 kernel: (swapper/0): new 324744 us maximum-latency critical section.
Oct 12 15:33:35 swdev14 kernel:  => started at: <start_kernel+0x48/0x1c6>
Oct 12 15:33:35 swdev14 kernel:  => ended at:   <cond_resched+0x26/0x83>
Oct 12 15:33:35 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:35 swdev14 kernel:  [<c0134834>] check_preempt_timing+0x161/0x1f9
Oct 12 15:33:35 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:35 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:35 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:35 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:35 swdev14 kernel:  [<c0135c0c>] register_cpu_notifier+0x18/0x58
Oct 12 15:33:36 swdev14 kernel:  [<c01301b4>] rcu_cpu_notify+0x36/0x38
Oct 12 15:33:36 swdev14 kernel:  [<c03646c7>] rcu_init+0x70/0x74
Oct 12 15:33:36 swdev14 kernel:  [<c035485c>] start_kernel+0xb9/0x1c6
Oct 12 15:33:36 swdev14 kernel:  [<c03543b0>] unknown_bootoption+0x0/0x15d
Oct 12 15:33:36 swdev14 kernel: PID hash table entries: 2048 (order: 11, 32768 bytes)
Oct 12 15:33:36 swdev14 kernel: (swapper/0): new 354276 us maximum-latency critical section.
Oct 12 15:33:36 swdev14 rpcidmapd: rpc.idmapd startup succeeded
Oct 12 15:33:36 swdev14 kernel:  => started at: <cond_resched+0x26/0x83>
Oct 12 15:33:36 swdev14 kernel:  => ended at:   <cond_resched+0x26/0x83>
Oct 12 15:33:36 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:36 swdev14 kernel:  [<c0134834>] check_preempt_timing+0x161/0x1f9
Oct 12 15:33:36 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:36 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:36 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:36 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:36 swdev14 random: Initializing random number generator:  succeeded
Oct 12 15:33:36 swdev14 kernel:  [<c0135c0c>] register_cpu_notifier+0x18/0x58
Oct 12 15:33:36 swdev14 kernel:  [<c0128433>] timer_cpu_notify+0x25/0x27
Oct 12 15:33:36 swdev14 kernel:  [<c03643cb>] init_timers+0x34/0x54
Oct 12 15:33:36 swdev14 kernel:  [<c035486b>] start_kernel+0xc8/0x1c6
Oct 12 15:33:36 swdev14 kernel:  [<c03543b0>] unknown_bootoption+0x0/0x15d
Oct 12 15:33:36 swdev14 kernel: Detected 2592.193 MHz processor.
Oct 12 15:33:36 swdev14 kernel: Using tsc for high-res timesource
Oct 12 15:33:36 swdev14 kernel: (swapper/0): new 705817 us maximum-latency critical section.
Oct 12 15:33:36 swdev14 rc: Starting pcmcia:  succeeded
Oct 12 15:33:36 swdev14 kernel:  => started at: <cond_resched+0x26/0x83>
Oct 12 15:33:36 swdev14 kernel:  => ended at:   <cond_resched+0x26/0x83>
Oct 12 15:33:36 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:36 swdev14 kernel:  [<c0134834>] check_preempt_timing+0x161/0x1f9
Oct 12 15:33:36 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:36 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:36 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:36 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:36 swdev14 kernel:  [<c01337fe>] _mutex_lock+0x19/0x3f
Oct 12 15:33:36 swdev14 kernel:  [<c0133860>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 15:33:36 swdev14 kernel:  [<c01cbdd4>] tty_register_ldisc+0x37/0xa4
Oct 12 15:33:36 swdev14 kernel:  [<c036be3e>] console_init+0x27/0x4a
Oct 12 15:33:36 swdev14 kernel:  [<c035487a>] start_kernel+0xd7/0x1c6
Oct 12 15:33:36 swdev14 kernel:  [<c03543b0>] unknown_bootoption+0x0/0x15d
Oct 12 15:33:36 swdev14 kernel: Console: colour VGA+ 80x25
Oct 12 15:33:36 swdev14 kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Oct 12 15:33:36 swdev14 kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Oct 12 15:33:36 swdev14 kernel: Memory: 513504k/523712k available (1645k kernel code, 9604k reserved, 726k data, 272k init, 0k highmem)
Oct 12 15:33:36 swdev14 netfs: Mounting NFS filesystems:  succeeded
Oct 12 15:33:36 swdev14 kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Oct 12 15:33:36 swdev14 kernel: Security Scaffold v1.0.0 initialized
Oct 12 15:33:36 swdev14 netfs: Mounting other filesystems:  succeeded
Oct 12 15:33:36 swdev14 kernel: Capability LSM initialized
Oct 12 15:33:36 swdev14 kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Oct 12 15:33:37 swdev14 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Oct 12 15:33:37 swdev14 kernel: CPU: L2 cache: 512K
Oct 12 15:33:37 swdev14 kernel: CPU: Physical Processor ID: 0
Oct 12 15:33:37 swdev14 kernel: Intel machine check architecture supported.
Oct 12 15:33:37 swdev14 kernel: Intel machine check reporting enabled on CPU#0.
Oct 12 15:33:37 swdev14 kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Oct 12 15:33:37 swdev14 kernel: Enabling fast FPU save and restore... done.
Oct 12 15:33:37 swdev14 kernel: Enabling unmasked SIMD FPU exception support... done.
Oct 12 15:33:37 swdev14 kernel: Checking 'hlt' instruction... OK.
Oct 12 15:33:37 swdev14 kernel: CPU0: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Oct 12 15:33:37 swdev14 kernel: per-CPU timeslice cutoff: 1462.71 usecs.
Oct 12 15:33:37 swdev14 kernel: task migration cache decay timeout: 2 msecs.
Oct 12 15:33:37 swdev14 kernel: Booting processor 1/1 eip 2000
Oct 12 15:33:37 swdev14 autofs: automount startup succeeded
Oct 12 15:33:37 swdev14 kernel: Initializing CPU#1
Oct 12 15:33:37 swdev14 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Oct 12 15:33:37 swdev14 kernel: CPU: L2 cache: 512K
Oct 12 15:33:37 swdev14 smartd[2807]: smartd version 5.21 Copyright (C) 2002-3 Bruce Allen 
Oct 12 15:33:37 swdev14 kernel: CPU: Physical Processor ID: 0
Oct 12 15:33:37 swdev14 smartd[2807]: Home page is http://smartmontools.sourceforge.net/  
Oct 12 15:33:37 swdev14 smartd[2807]: Opened configuration file /etc/smartd.conf 
Oct 12 15:33:37 swdev14 kernel: Intel machine check architecture supported.
Oct 12 15:33:37 swdev14 smartd[2807]: Configuration file /etc/smartd.conf parsed. 
Oct 12 15:33:37 swdev14 smartd[2807]: Device: /dev/hda, opened 
Oct 12 15:33:37 swdev14 kernel: Intel machine check reporting enabled on CPU#1.
Oct 12 15:33:37 swdev14 kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
Oct 12 15:33:37 swdev14 kernel: CPU1: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Oct 12 15:33:37 swdev14 kernel: Booting processor 2/6 eip 2000
Oct 12 15:33:37 swdev14 smartd[2807]: Device: /dev/hda, not found in smartd database. 
Oct 12 15:33:37 swdev14 kernel: Initializing CPU#2
Oct 12 15:33:37 swdev14 smartd[2807]: Device: /dev/hda, is SMART capable. Adding to "monitor" list. 
Oct 12 15:33:37 swdev14 smartd[2807]: Monitoring 1 ATA and 0 SCSI devices 
Oct 12 15:33:37 swdev14 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Oct 12 15:33:37 swdev14 smartd[2809]: smartd has fork()ed into background mode. New PID=2809. 
Oct 12 15:33:37 swdev14 kernel: CPU: L2 cache: 512K
Oct 12 15:33:37 swdev14 smartd: smartd startup succeeded
Oct 12 15:33:37 swdev14 kernel: CPU: Physical Processor ID: 3
Oct 12 15:33:38 swdev14 kernel: Intel machine check architecture supported.
Oct 12 15:33:38 swdev14 kernel: Intel machine check reporting enabled on CPU#2.
Oct 12 15:33:38 swdev14 kernel: CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
Oct 12 15:33:38 swdev14 kernel: CPU2: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Oct 12 15:33:38 swdev14 kernel: Booting processor 3/7 eip 2000
Oct 12 15:33:38 swdev14 kernel: Initializing CPU#3
Oct 12 15:33:38 swdev14 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Oct 12 15:33:38 swdev14 sshd:  succeeded
Oct 12 15:33:38 swdev14 kernel: CPU: L2 cache: 512K
Oct 12 15:33:38 swdev14 kernel: CPU: Physical Processor ID: 3
Oct 12 15:33:38 swdev14 kernel: Intel machine check architecture supported.
Oct 12 15:33:38 swdev14 kernel: Intel machine check reporting enabled on CPU#3.
Oct 12 15:33:38 swdev14 kernel: CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
Oct 12 15:33:38 swdev14 kernel: CPU3: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Oct 12 15:33:38 swdev14 kernel: Total of 4 processors activated (20594.68 BogoMIPS).
Oct 12 15:33:38 swdev14 kernel: checking TSC synchronization across 4 CPUs: 
Oct 12 15:33:38 swdev14 kernel: CPU#0 had 0 usecs TSC skew, fixed it up.
Oct 12 15:33:38 swdev14 kernel: CPU#2 had 0 usecs TSC skeFlag at 0x36 set to 0x1
Oct 12 15:33:38 swdev14 kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Oct 12 15:33:38 swdev14 xinetd: xinetd startup succeeded
Oct 12 15:33:38 swdev14 kernel: apm: disabled - APM is not SMP safe.
Oct 12 15:33:38 swdev14 kernel: VFS: Disk quotas dquot_6.5.1
Oct 12 15:33:38 swdev14 kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Oct 12 15:33:38 swdev14 kernel: Initializing Cryptographic API
Oct 12 15:33:38 swdev14 kernel: vesafb: probe of vesafb0 failed with error -6
Oct 12 15:33:38 swdev14 kernel: isapnp: Scanning for PnP cards...
Oct 12 15:33:38 swdev14 kernel: isapnp: No Plug & Play device found
Oct 12 15:33:38 swdev14 kernel: requesting new irq thread for IRQ8...
Oct 12 15:33:38 swdev14 kernel: Real Time Clock Driver v1.12
Oct 12 15:33:38 swdev14 kernel: requesting new irq thread for IRQ12...
Oct 12 15:33:38 swdev14 kernel: Failed to disable AUX port, but continuing anyway... Is this a SiS?
Oct 12 15:33:38 swdev14 kernel: If AUX port is really absent please use the 'i8042.noaux' option.
Oct 12 15:33:38 swdev14 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct 12 15:33:38 swdev14 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 12 15:33:38 swdev14 ntpdate[2873]: can't find host wizard 
Oct 12 15:33:38 swdev14 kernel: io scheduler noop registered
Oct 12 15:33:39 swdev14 kernel: io scheduler anticipatory registered
Oct 12 15:33:39 swdev14 kernel: io scheduler deadline registered
Oct 12 15:33:39 swdev14 kernel: io scheduler cfq registered
Oct 12 15:33:39 swdev14 kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Oct 12 15:33:39 swdev14 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Oct 12 15:33:39 swdev14 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct 12 15:33:39 swdev14 kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Oct 12 15:33:39 swdev14 kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Oct 12 15:33:39 swdev14 kernel: ICH4: chipset revision 2
Oct 12 15:33:39 swdev14 kernel: ICH4: not 100%% native mode: will probe irqs later
Oct 12 15:33:39 swdev14 kernel:     ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:DMA, hdb:pio
Oct 12 15:33:39 swdev14 kernel:     ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:DMA, hdd:pio
Oct 12 15:33:39 swdev14 kernel: hda: WDC WD800BB-75CAA0, ATA DISK drive
Oct 12 15:33:39 swdev14 kernel: requesting new irq thread for IRQ14...
Oct 12 15:33:39 swdev14 kernel: elevator: using anticipatory as default io scheduler
Oct 12 15:33:39 swdev14 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct 12 15:33:39 swdev14 kernel: hdc: SONY DVD RW DW-U18A, ATAPI CD/DVD-ROM drive
Oct 12 15:33:39 swdev14 kernel: requesting new irq thread for IRQ15...
Oct 12 15:33:39 swdev14 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct 12 15:33:39 swdev14 kernel: hda: max request size: 128KiB
Oct 12 15:33:39 swdev14 kernel: IRQ#14 thread started up.
Oct 12 15:33:39 swdev14 kernel: hda: Host Protected Area detected.
Oct 12 15:33:39 swdev14 kernel: ^Icurrent capacity is 156250000 sectors (80000 MB)
Oct 12 15:33:39 swdev14 kernel: ^Inative  capacity is 156301488 sectors (80026 MB)
Oct 12 15:33:39 swdev14 kernel: hda: Host Protected Area disabled.
Oct 12 15:33:39 swdev14 kernel: hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Oct 12 15:33:39 swdev14 kernel:  hda: hda1 hda2 < hda5 hda6 hda7 >
Oct 12 15:33:39 swdev14 kernel: mice: PS/2 mouse device common for all mice
Oct 12 15:33:39 swdev14 kernel: IRQ#12 thread started up.
Oct 12 15:33:39 swdev14 kernel: requesting new irq thread for IRQ1...
Oct 12 15:33:39 swdev14 kernel: IRQ#1 thread started up.
Oct 12 15:33:39 swdev14 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Oct 12 15:33:39 swdev14 kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Oct 12 15:33:39 swdev14 kernel: NET: Registered protocol family 2
Oct 12 15:33:39 swdev14 kernel: IP: routing cache hash table of 2048 buckets, 32Kbytes
Oct 12 15:33:39 swdev14 kernel: TCP: Hash tables configured (established 16384 bind 21845)
Oct 12 15:33:39 swdev14 kernel: NET: Registered protocol family 1
Oct 12 15:33:39 swdev14 kernel: NET: Registered protocol family 17
Oct 12 15:33:39 swdev14 kernel: NET: Registered protocol family 8
Oct 12 15:33:39 swdev14 kernel: NET: Registered protocol family 20
Oct 12 15:33:39 swdev14 kernel: Starting balanced_irq
Oct 12 15:33:39 swdev14 kernel: md: Autodetecting RAID arrays.
Oct 12 15:33:39 swdev14 kernel: md: autorun ...
Oct 12 15:33:39 swdev14 kernel: md: ... autorun DONE.
Oct 12 15:33:39 swdev14 kernel: RAMDISK: Compressed image found at block 0
Oct 12 15:33:39 swdev14 kernel: VFS: Mounted root (ext2 filesystem).
Oct 12 15:33:39 swdev14 kernel: kjournald starting.  Commit interval 5 seconds
Oct 12 15:33:39 swdev14 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 12 15:33:39 swdev14 kernel: Freeing unused kernel memory: 272k freed
Oct 12 15:33:39 swdev14 kernel: IRQ#8 thread started up.
Oct 12 15:33:39 swdev14 kernel: usbcore: registered new driver usbfs
Oct 12 15:33:39 swdev14 kernel: usbcore: registered new driver hub
Oct 12 15:33:39 swdev14 kernel: USB Universal Host Controller Interface driver v2.2
Oct 12 15:33:39 swdev14 kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
Oct 12 15:33:39 swdev14 kernel: requesting new irq thread for IRQ11...
Oct 12 15:33:39 swdev14 kernel: uhci_hcd 0000:00:1d.0: irq 11, io base 0x1400
Oct 12 15:33:39 swdev14 kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Oct 12 15:33:39 swdev14 kernel: hub 1-0:1.0: USB hub found
Oct 12 15:33:39 swdev14 kernel: hub 1-0:1.0: 2 ports detected
Oct 12 15:33:39 swdev14 kernel: uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
Oct 12 15:33:39 swdev14 kernel: requesting new irq thread for IRQ10...
Oct 12 15:33:39 swdev14 kernel: uhci_hcd 0000:00:1d.1: irq 10, io base 0x1420
Oct 12 15:33:39 swdev14 kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
Oct 12 15:33:39 swdev14 kernel: hub 2-0:1.0: USB hub found
Oct 12 15:33:39 swdev14 kernel: hub 2-0:1.0: 2 ports detected
Oct 12 15:33:39 swdev14 kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
Oct 12 15:33:39 swdev14 kernel: requesting new irq thread for IRQ5...
Oct 12 15:33:39 swdev14 kernel: uhci_hcd 0000:00:1d.2: irq 5, io base 0x1440
Oct 12 15:33:39 swdev14 kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Oct 12 15:33:39 swdev14 kernel: hub 3-0:1.0: USB hub found
Oct 12 15:33:39 swdev14 kernel: hub 3-0:1.0: 2 ports detected
Oct 12 15:33:39 swdev14 kernel: usb 1-2: new low speed USB device using address 2
Oct 12 15:33:39 swdev14 kernel: IRQ#11 thread started up.
Oct 12 15:33:39 swdev14 kernel: input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-0000:00:1d.0-2
Oct 12 15:33:39 swdev14 kernel: usbcore: registered new driver usbhid
Oct 12 15:33:39 swdev14 kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Oct 12 15:33:39 swdev14 kernel: EXT3 FS on hda6, internal journal
Oct 12 15:33:39 swdev14 kernel: device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Oct 12 15:33:39 swdev14 kernel: Adding 2048216k swap on /dev/hda5.  Priority:-1 extents:1
Oct 12 15:33:39 swdev14 kernel: kjournald starting.  Commit interval 5 seconds
Oct 12 15:33:39 swdev14 kernel: EXT3 FS on hda1, internal journal
Oct 12 15:33:39 swdev14 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 12 15:33:39 swdev14 kernel: kjournald starting.  Commit interval 5 seconds
Oct 12 15:33:39 swdev14 kernel: EXT3 FS on hda7, internal journal
Oct 12 15:33:39 swdev14 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 12 15:33:39 swdev14 kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Oct 12 15:33:39 swdev14 kernel: microcode: No suitable data for CPU0
Oct 12 15:33:39 swdev14 kernel: microcode: No suitable data for CPU2
Oct 12 15:33:39 swdev14 kernel: microcode: No suitable data for CPU3
Oct 12 15:33:39 swdev14 kernel: microcode: No suitable data for CPU1
Oct 12 15:33:39 swdev14 kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Oct 12 15:33:39 swdev14 kernel: parport0: irq 7 detected
Oct 12 15:33:39 swdev14 kernel: SCSI subsystem initialized
Oct 12 15:33:39 swdev14 kernel: inserting floppy driver for 2.6.9-rc4-mm1-VP-T8
Oct 12 15:33:39 swdev14 kernel: Floppy drive(s): fd0 is 1.44M
Oct 12 15:33:39 swdev14 kernel: requesting new irq thread for IRQ6...
Oct 12 15:33:39 swdev14 kernel: IRQ#6 thread started up.
Oct 12 15:33:39 swdev14 kernel: FDC 0 is a National Semiconductor PC87306
Oct 12 15:33:39 swdev14 kernel: tg3.c:v3.10 (September 14, 2004)
Oct 12 15:33:39 swdev14 kernel: eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:66MHz:32-bit) 10/100/1000BaseT Ethernet 00:50:45:00:9b:33
Oct 12 15:33:39 swdev14 kernel: eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
Oct 12 15:33:39 swdev14 kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Oct 12 15:33:39 swdev14 kernel: 0000:05:01.0: 3Com PCI 3c905C Tornado at 0x2000. Vers LK1.1.19
Oct 12 15:33:39 swdev14 kernel: IRQ#15 thread started up.
Oct 12 15:33:39 swdev14 kernel: hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Oct 12 15:33:39 swdev14 kernel: Uniform CD-ROM driver Revision: 3.20
Oct 12 15:33:39 swdev14 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Oct 12 15:33:39 swdev14 kernel: NET: Registered protocol family 10
Oct 12 15:33:39 swdev14 kernel: IPv6 over IPv4 tunneling driver
Oct 12 15:33:40 swdev14 kernel: ------------[ cut here ]------------
Oct 12 15:33:40 swdev14 kernel: kernel BUG at kernel/mutex.c:185!
Oct 12 15:33:40 swdev14 kernel: invalid operand: 0000 [#1]
Oct 12 15:33:40 swdev14 kernel: PREEMPT SMP 
Oct 12 15:33:40 swdev14 kernel: Modules linked in: ipv6 autofs4 nfs lockd sunrpc iptable_filter ip_tables ide_cd cdrom 3c59x mii tg3 floppy sg scsi_mod parport_pc parport microcode dm_mod evdev usbhid uhci_hcd usbcore ext3 jbd
Oct 12 15:33:40 swdev14 kernel: CPU:    0
Oct 12 15:33:40 swdev14 kernel: EIP:    0060:[<c0133ba4>]    Not tainted VLI
Oct 12 15:33:40 swdev14 kernel: EFLAGS: 00010246   (2.6.9-rc4-mm1-VP-T8) 
Oct 12 15:33:40 swdev14 kernel: EIP is at _rw_mutex_write_unlock+0x25/0x2f
Oct 12 15:33:40 swdev14 kernel: eax: 00000000   ebx: 00000000   ecx: c0350f80   edx: c1406b80
Oct 12 15:33:40 swdev14 kernel: esi: da261ac8   edi: da7b1814   ebp: de661f18   esp: de661f18
Oct 12 15:33:40 swdev14 kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Oct 12 15:33:40 swdev14 kernel: Process sshd (pid: 2835, threadinfo=de660000 task=debaea80)
Oct 12 15:33:40 swdev14 kernel: Stack: de661f44 c0253738 c0350f80 00000016 c029a33a c16caa80 da261c94 da261bfc 
Oct 12 15:33:40 swdev14 kernel:        c16caa80 da261a80 ffffffea de661f5c c0275a8c da261a80 00000005 c16caa80 
Oct 12 15:33:40 swdev14 kernel:        00000003 de661f78 c02287ea c16caa80 00000005 00000000 00000004 08090bf0 
Oct 12 15:33:40 swdev14 kernel: Call Trace:
Oct 12 15:33:40 swdev14 kernel:  [<c0253738>] tcp_listen_start+0x175/0x1d1
Oct 12 15:33:40 swdev14 kernel:  [<c029a33a>] _spin_unlock_bh+0x1a/0x34
Oct 12 15:33:40 swdev14 kernel:  [<c0275a8c>] inet_listen+0x65/0x7a
Oct 12 15:33:40 swdev14 kernel:  [<c02287ea>] sys_listen+0x5c/0x74
Oct 12 15:33:40 swdev14 kernel:  [<c02294a4>] sys_socketcall+0xb1/0x239
Oct 12 15:33:40 swdev14 kernel:  [<c015ae81>] sys_close+0x75/0x91
Oct 12 15:33:40 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 15:33:40 swdev14 kernel: Code: 75 fc 89 ec 5d c3 55 89 e5 e8 39 fb fd ff 8b 4d 08 8b 01 85 c0 74 14 8d 41 04 ba ff ff 00 00 f0 0f c1 10 0f 85 6e 03 00 00 5d c3 <0f> 0b b9 00 9a c6 2a c0 eb e2 55 89 e5 e8 0a fb fd ff 8b 4d 08 
Oct 12 15:33:40 swdev14 kernel:  <3>scheduling while atomic: sshd/0x04000001/2835
Oct 12 15:33:40 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c02991cf>] schedule+0xbaf/0xbe2
Oct 12 15:33:40 swdev14 kernel:  [<c029967e>] cond_resched+0x63/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:40 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c0134864>] check_preempt_timing+0x191/0x1f9
Oct 12 15:33:40 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:40 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c029967e>] cond_resched+0x63/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c011f5c8>] profile_task_exit+0x18/0x56
Oct 12 15:33:40 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 15:33:40 swdev14 kernel:  [<c01216e0>] do_exit+0x1f/0x3bd
Oct 12 15:33:40 swdev14 kernel:  [<c0299213>] preempt_schedule+0x11/0x7a
Oct 12 15:33:40 swdev14 kernel:  [<c0107780>] do_invalid_op+0x0/0x10b
Oct 12 15:33:40 swdev14 kernel:  [<c01073e2>] do_divide_error+0x0/0x131
Oct 12 15:33:40 swdev14 kernel:  [<c0117898>] fixup_exception+0x1c/0x38
Oct 12 15:33:40 swdev14 kernel:  [<c0107889>] do_invalid_op+0x109/0x10b
Oct 12 15:33:40 swdev14 kernel:  [<c0133ba4>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 15:33:40 swdev14 kernel:  [<c0134129>] __mcount+0x1d/0x21
Oct 12 15:33:40 swdev14 kernel:  [<c029a11e>] _write_lock+0x1b/0x76
Oct 12 15:33:40 swdev14 kernel:  [<c026436e>] tcp_listen_wlock+0x16/0xac
Oct 12 15:33:40 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 15:33:40 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 15:33:40 swdev14 kernel:  [<c0133ba4>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 15:33:40 swdev14 kernel:  [<c0253738>] tcp_listen_start+0x175/0x1d1
Oct 12 15:33:40 swdev14 kernel:  [<c029a33a>] _spin_unlock_bh+0x1a/0x34
Oct 12 15:33:40 swdev14 kernel:  [<c0275a8c>] inet_listen+0x65/0x7a
Oct 12 15:33:40 swdev14 kernel:  [<c02287ea>] sys_listen+0x5c/0x74
Oct 12 15:33:40 swdev14 kernel:  [<c02294a4>] sys_socketcall+0xb1/0x239
Oct 12 15:33:40 swdev14 kernel:  [<c015ae81>] sys_close+0x75/0x91
Oct 12 15:33:40 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 15:33:40 swdev14 kernel: note: sshd[2835] exited with preempt_count 1
Oct 12 15:33:40 swdev14 kernel: scheduling while atomic: sshd/0x04000001/2835
Oct 12 15:33:40 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c02991cf>] schedule+0xbaf/0xbe2
Oct 12 15:33:40 swdev14 kernel:  [<c029967e>] cond_resched+0x63/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:40 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c0134864>] check_preempt_timing+0x191/0x1f9
Oct 12 15:33:40 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:40 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c029967e>] cond_resched+0x63/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c014b7e5>] unmap_vmas+0x190/0x29b
Oct 12 15:33:40 swdev14 kernel:  [<c0150037>] exit_mmap+0xb2/0x1cc
Oct 12 15:33:40 swdev14 kernel:  [<c011c96d>] mmput+0x3b/0xb9
Oct 12 15:33:40 swdev14 kernel:  [<c01217ef>] do_exit+0x12e/0x3bd
Oct 12 15:33:40 swdev14 kernel:  [<c0107780>] do_invalid_op+0x0/0x10b
Oct 12 15:33:40 swdev14 kernel:  [<c01073e2>] do_divide_error+0x0/0x131
Oct 12 15:33:40 swdev14 kernel:  [<c0117898>] fixup_exception+0x1c/0x38
Oct 12 15:33:40 swdev14 kernel:  [<c0107889>] do_invalid_op+0x109/0x10b
Oct 12 15:33:40 swdev14 kernel:  [<c0133ba4>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 15:33:40 swdev14 kernel:  [<c0134129>] __mcount+0x1d/0x21
Oct 12 15:33:40 swdev14 kernel:  [<c029a11e>] _write_lock+0x1b/0x76
Oct 12 15:33:40 swdev14 kernel:  [<c026436e>] tcp_listen_wlock+0x16/0xac
Oct 12 15:33:40 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 15:33:40 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 15:33:40 swdev14 kernel:  [<c0133ba4>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 15:33:40 swdev14 kernel:  [<c0253738>] tcp_listen_start+0x175/0x1d1
Oct 12 15:33:40 swdev14 kernel:  [<c029a33a>] _spin_unlock_bh+0x1a/0x34
Oct 12 15:33:40 swdev14 kernel:  [<c0275a8c>] inet_listen+0x65/0x7a
Oct 12 15:33:40 swdev14 kernel:  [<c02287ea>] sys_listen+0x5c/0x74
Oct 12 15:33:40 swdev14 kernel:  [<c02294a4>] sys_socketcall+0xb1/0x239
Oct 12 15:33:40 swdev14 kernel:  [<c015ae81>] sys_close+0x75/0x91
Oct 12 15:33:40 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 15:33:40 swdev14 kernel: scheduling while atomic: sshd/0x04000001/2835
Oct 12 15:33:40 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c02991cf>] schedule+0xbaf/0xbe2
Oct 12 15:33:40 swdev14 kernel:  [<c029967e>] cond_resched+0x63/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:40 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c0134864>] check_preempt_timing+0x191/0x1f9
Oct 12 15:33:40 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:40 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c029967e>] cond_resched+0x63/0x83
Oct 12 15:33:40 swdev14 kernel:  [<c014b7e5>] unmap_vmas+0x190/0x29b
Oct 12 15:33:40 swdev14 kernel:  [<c0150037>] exit_mmap+0xb2/0x1cc
Oct 12 15:33:40 swdev14 kernel:  [<c011c96d>] mmput+0x3b/0xb9
Oct 12 15:33:40 swdev14 kernel:  [<c01217ef>] do_exit+0x12e/0x3bd
Oct 12 15:33:40 swdev14 kernel:  [<c0107780>] do_invalid_op+0x0/0x10b
Oct 12 15:33:40 swdev14 kernel:  [<c01073e2>] do_divide_error+0x0/0x131
Oct 12 15:33:40 swdev14 kernel:  [<c0117898>] fixup_exception+0x1c/0x38
Oct 12 15:33:40 swdev14 kernel:  [<c0107889>] do_invalid_op+0x109/0x10b
Oct 12 15:33:40 swdev14 kernel:  [<c0133ba4>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 15:33:40 swdev14 kernel:  [<c0134129>] __mcount+0x1d/0x21
Oct 12 15:33:40 swdev14 kernel:  [<c029a11e>] _write_lock+0x1b/0x76
Oct 12 15:33:40 swdev14 kernel:  [<c026436e>] tcp_listen_wlock+0x16/0xac
Oct 12 15:33:40 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 15:33:40 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 15:33:40 swdev14 kernel:  [<c0133ba4>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 15:33:40 swdev14 kernel:  [<c0253738>] tcp_listen_start+0x175/0x1d1
Oct 12 15:33:41 swdev14 kernel:  [<c029a33a>] _spin_unlock_bh+0x1a/0x34
Oct 12 15:33:41 swdev14 kernel:  [<c0275a8c>] inet_listen+0x65/0x7a
Oct 12 15:33:41 swdev14 kernel:  [<c02287ea>] sys_listen+0x5c/0x74
Oct 12 15:33:41 swdev14 kernel:  [<c02294a4>] sys_socketcall+0xb1/0x239
Oct 12 15:33:41 swdev14 kernel:  [<c015ae81>] sys_close+0x75/0x91
Oct 12 15:33:41 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 15:33:41 swdev14 kernel: scheduling while atomic: sshd/0x04000001/2835
Oct 12 15:33:41 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 15:33:41 swdev14 kernel:  [<c02991cf>] schedule+0xbaf/0xbe2
Oct 12 15:33:41 swdev14 kernel:  [<c029967e>] cond_resched+0x63/0x83
Oct 12 15:33:41 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:41 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:41 swdev14 kernel:  [<c0134864>] check_preempt_timing+0x191/0x1f9
Oct 12 15:33:41 swdev14 kernel:  [<c0134912>] touch_preempt_timing+0x46/0x4a
Oct 12 15:33:41 swdev14 kernel:  [<c0299641>] cond_resched+0x26/0x83
Oct 12 15:33:41 swdev14 kernel:  [<c029967e>] cond_resched+0x63/0x83
Oct 12 15:33:41 swdev14 kernel:  [<c014b7e5>] unmap_vmas+0x190/0x29b
Oct 12 15:33:41 swdev14 kernel:  [<c0150037>] exit_mmap+0xb2/0x1cc
Oct 12 15:33:41 swdev14 kernel:  [<c011c96d>] mmput+0x3b/0xb9
Oct 12 15:33:41 swdev14 kernel:  [<c01217ef>] do_exit+0x12e/0x3bd
Oct 12 15:33:41 swdev14 kernel:  [<c0107780>] do_invalid_op+0x0/0x10b
Oct 12 15:33:41 swdev14 kernel:  [<c01073e2>] do_divide_error+0x0/0x131
Oct 12 15:33:41 swdev14 kernel:  [<c0117898>] fixup_exception+0x1c/0x38
Oct 12 15:33:41 swdev14 kernel:  [<c0107889>] do_invalid_op+0x109/0x10b
Oct 12 15:33:41 swdev14 kernel:  [<c0133ba4>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 15:33:41 swdev14 kernel:  [<c0134129>] __mcount+0x1d/0x21
Oct 12 15:33:41 swdev14 kernel:  [<c029a11e>] _write_lock+0x1b/0x76
Oct 12 15:33:41 swdev14 kernel:  [<c026436e>] tcp_listen_wlock+0x16/0xac
Oct 12 15:33:41 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 15:33:41 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 15:33:41 swdev14 kernel:  [<c0133ba4>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 15:33:41 swdev14 kernel:  [<c0253738>] tcp_listen_start+0x175/0x1d1
Oct 12 15:33:41 swdev14 kernel:  [<c029a33a>] _spin_unlock_bh+0x1a/0x34
Oct 12 15:33:41 swdev14 kernel:  [<c0275a8c>] inet_listen+0x65/0x7a
Oct 12 15:33:41 swdev14 kernel:  [<c02287ea>] sys_listen+0x5c/0x74
Oct 12 15:33:41 swdev14 kernel:  [<c02294a4>] sys_socketcall+0xb1/0x239
Oct 12 15:33:41 swdev14 kernel:  [<c015ae81>] sys_close+0x75/0x91
Oct 12 15:33:41 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 15:33:41 swdev14 kernel: scheduling while atomic: sshd/0x04000001/2835
Oct 12 15:33:41 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 15:33:41 swdev14 kernel:  [<c02991cf>] schedule+0xbaf/0xbe2
Oct 12 15:33:41 swdev14 kernel:  [<c029967e>] cond_resched+0x63/0x83
Oct 12 15:33:41 swdev14 kernel:  [<c0113d1c>] smp_apic_timer_interrupt+0x79/0xe4
Oct 12 15:33:41 swdev14 kernel:  [<c0134914>] touch_preempt_timing+0x48/0x4a
Oct 12 15:33:41 swdev14 kernel:  [<c0106bb6>] apic_timer_interrupt+0x1a/0x20
Oct 12 15:33:41 swdev14 kernel:  [<c0134914>] touch_preempt_timing+0x48/0x4a
Oct 12 15:33:41 swdev14 kernel:  [<c029967e>] cond_resched+0x63/0x83
Oct 12 15:33:41 swdev14 kernel:  [<c014dfa3>] remove_vm_struct+0x1f/0x9f
Oct 12 15:33:41 swdev14 kernel:  [<c01500f7>] exit_mmap+0x172/0x1cc
Oct 12 15:33:41 swdev14 kernel:  [<c011c96d>] mmput+0x3b/0xb9
Oct 12 15:33:41 swdev14 kernel:  [<c01217ef>] do_exit+0x12e/0x3bd
Oct 12 15:33:41 swdev14 kernel:  [<c0107780>] do_invalid_op+0x0/0x10b
Oct 12 15:33:41 swdev14 kernel:  [<c01073e2>] do_divide_error+0x0/0x131
Oct 12 15:33:41 swdev14 kernel:  [<c0117898>] fixup_exception+0x1c/0x38
Oct 12 15:33:41 swdev14 kernel:  [<c0107889>] do_invalid_op+0x109/0x10b
Oct 12 15:33:41 swdev14 kernel:  [<c0133ba4>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 15:33:41 swdev14 kernel:  [<c0134129>] __mcount+0x1d/0x21
Oct 12 15:33:41 swdev14 kernel:  [<c029a11e>] _write_lock+0x1b/0x76
Oct 12 15:33:41 swdev14 kernel:  [<c026436e>] tcp_listen_wlock+0x16/0xac
Oct 12 15:33:41 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 15:33:41 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 15:33:41 swdev14 kernel:  [<c0133ba4>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 15:33:41 swdev14 kernel:  [<c0253738>] tcp_listen_start+0x175/0x1d1
Oct 12 15:33:41 swdev14 kernel:  [<c029a33a>] _spin_unlock_bh+0x1a/0x34
Oct 12 15:33:41 swdev14 kernel:  [<c0275a8c>] inet_listen+0x65/0x7a
Oct 12 15:33:41 swdev14 kernel:  [<c02287ea>] sys_listen+0x5c/0x74
Oct 12 15:33:41 swdev14 kernel:  [<c02294a4>] sys_socketcall+0xb1/0x239
Oct 12 15:33:41 swdev14 kernel:  [<c015ae81>] sys_close+0x75/0x91
Oct 12 15:33:41 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 15:33:41 swdev14 kernel: scheduling while atomic: sshd/0x00000001/2835
Oct 12 15:33:41 swdev14 kernel: caller is __down+0x8a/0x107
Oct 12 15:33:41 swdev14 kernel:  [<c02991cf>] schedule+0xbaf/0xbe2
Oct 12 15:33:41 swdev14 kernel:  [<c02983fe>] __down+0x8a/0x107
Oct 12 15:33:41 swdev14 kernel:  [<c0134129>] __mcount+0x1d/0x21
Oct 12 15:33:41 swdev14 kernel:  [<c0134129>] __mcount+0x1d/0x21
Oct 12 15:33:41 swdev14 kernel:  [<c029a2c0>] _spin_unlock_irqrestore+0xb/0x36
Oct 12 15:33:41 swdev14 kernel:  [<c02983f9>] __down+0x85/0x107
Oct 12 15:33:41 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 15:33:41 swdev14 kernel:  [<c02983fe>] __down+0x8a/0x107
Oct 12 15:33:41 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 15:33:41 swdev14 kernel:  [<c02985c4>] __down_failed+0x8/0xc
Oct 12 15:33:41 swdev14 kernel:  [<c011c3cc>] .text.lock.sched+0x5/0x15
Oct 12 15:33:41 swdev14 kernel:  [<c01ccb0d>] disassociate_ctty+0x1d/0x16d
Oct 12 15:33:41 swdev14 kernel:  [<c01218d9>] do_exit+0x218/0x3bd
Oct 12 15:33:41 swdev14 kernel:  [<c0107780>] do_invalid_op+0x0/0x10b
Oct 12 15:33:41 swdev14 kernel:  [<c01073e2>] do_divide_error+0x0/0x131
Oct 12 15:33:41 swdev14 kernel:  [<c0117898>] fixup_exception+0x1c/0x38
Oct 12 15:33:41 swdev14 kernel:  [<c0107889>] do_invalid_op+0x109/0x10b
Oct 12 15:33:41 swdev14 kernel:  [<c0133ba4>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 15:33:41 swdev14 kernel:  [<c0134129>] __mcount+0x1d/0x21
Oct 12 15:33:41 swdev14 kernel:  [<c029a11e>] _write_lock+0x1b/0x76
Oct 12 15:33:41 swdev14 kernel:  [<c026436e>] tcp_listen_wlock+0x16/0xac
Oct 12 15:33:41 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 15:33:41 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 15:33:41 swdev14 kernel:  [<c0133ba4>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 15:33:41 swdev14 kernel:  [<c0253738>] tcp_listen_start+0x175/0x1d1
Oct 12 15:33:41 swdev14 kernel:  [<c029a33a>] _spin_unlock_bh+0x1a/0x34
Oct 12 15:33:41 swdev14 kernel:  [<c0275a8c>] inet_listen+0x65/0x7a
Oct 12 15:33:41 swdev14 kernel:  [<c02287ea>] sys_listen+0x5c/0x74
Oct 12 15:33:41 swdev14 kernel:  [<c02294a4>] sys_socketcall+0xb1/0x239
Oct 12 15:33:41 swdev14 kernel:  [<c015ae81>] sys_close+0x75/0x91
Oct 12 15:33:41 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 15:33:47 swdev14 ntpdate[2873]: step time server 159.82.80.54 offset -0.490683 sec
Oct 12 15:33:47 swdev14 ntpd:  succeeded
Oct 12 15:33:47 swdev14 ntpd[2877]: ntpd 4.2.0@1.1161-r Thu Mar 11 11:46:39 EST 2004 (1)
Oct 12 15:33:47 swdev14 ntpd: ntpd startup succeeded
Oct 12 15:33:47 swdev14 ntpd[2877]: precision = 1.000 usec
Oct 12 15:33:47 swdev14 ntpd[2877]: kernel time sync status 0040
Oct 12 15:33:47 swdev14 ntpd[2877]: configure: keyword "opus" unknown, line ignored
Oct 12 15:33:47 swdev14 ntpd[2877]: configure: keyword "hal" unknown, line ignored
Oct 12 15:33:47 swdev14 ntpd[2877]: configure: keyword "wizard" unknown, line ignored
Oct 12 15:33:47 swdev14 ntpd[2877]: configure: keyword "time1.utc.com" unknown, line ignored
Oct 12 15:33:47 swdev14 ntpd[2877]: configure: keyword "time2.utc.com" unknown, line ignored
Oct 12 15:33:47 swdev14 ntpd[2877]: configure: keyword "time3.utc.com" unknown, line ignored
Oct 12 15:33:47 swdev14 vsftpd: vsftpd vsftpd succeeded
Oct 12 15:33:47 swdev14 ntpd[2877]: frequency initialized 117.670 PPM from /var/lib/ntp/drift
Oct 12 15:33:47 swdev14 ntpd[2877]: configure: keyword "authenticate" unknown, line ignored
Oct 12 15:33:47 swdev14 gpm[2896]: *** info [startup.c(95)]: 
Oct 12 15:33:47 swdev14 gpm[2896]: Started gpm successfully. Entered daemon mode.
Oct 12 15:33:47 swdev14 gpm[2896]: *** info [mice.c(1766)]: 
Oct 12 15:33:47 swdev14 gpm[2896]: imps2: Auto-detected intellimouse PS/2
Oct 12 15:33:48 swdev14 gpm: gpm startup succeeded
Oct 12 15:33:48 swdev14 crond: crond startup succeeded
Oct 12 15:33:50 swdev14 kernel: lp0: using parport0 (polling).
Oct 12 15:33:50 swdev14 kernel: lp0: console ready
Oct 12 15:36:04 swdev14 syslogd 1.4.1: restart.

--------------050903090504070806010501--
