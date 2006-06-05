Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751246AbWFER4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWFER4m (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 13:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWFER4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 13:56:42 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:19170 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751246AbWFER4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 13:56:40 -0400
Date: Mon, 5 Jun 2006 18:56:37 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060605175637.GA16186@skynet.ie>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060603232004.68c4e1e3.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am seeing more networking-related funniness with 2.6.17-rc5-mm3 on the
same machine previously fixed by git-net-llc-fix.patch. The console log is
below. I've done no investigation work in case it's a known problem.

kernel /vmlinuz-autobench ro root=/dev/VolGroup00/LogVol00 rhgb quiet console=t
tyS1,19200 autobench_args: root=30726124 ABAT:1149529388 earlyprintk=serial,tty
S1,19200
   [Linux-bzImage, setup=0x1e00, size=0x1e0687]
initrd /initrd-autobench.img
   [Linux-initrd @ 0x37e60000, 0x18fbd9 bytes]
Bootdata ok (command line is ro root=/dev/VolGroup00/LogVol00 rhgb quiet console=ttyS1,19200 autobench_args: root=30726124 ABAT:1149529388 earlyprintk=serial,ttyS1,19200)
Linux version 2.6.17-rc5-mm2-autokern1 (root@bl6-13.ltc.austin.ibm.com) (/usr/local/autobench/var/tmp/build/scripts/mkcompile_h: line 61: /usr/local/autobench/sources/x86_64-cross/*/bin/x86_64-unknown-linux-gnu-gcc: No such file or directory) #1 SMP Mon Jun 5 12:36:09 CDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d400 (usable)
 BIOS-e820: 000000000009d400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffcddc0 (usable)
 BIOS-e820: 000000003ffcddc0 - 000000003ffd0000 (ACPI data)
 BIOS-e820: 000000003ffd0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
kernel direct mapping tables up to 100000000 @ 8000-8000
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x2208
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x0e] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 14, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x0d] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 13, version 17, address 0xfec10000, GSI 24-27
ACPI: IOAPIC (id[0x0c] address[0xfec20000] gsi_base[48])
IOAPIC[2]: apic_id 12, version 17, address 0xfec20000, GSI 48-51
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 low level)
Setting APIC routing to physical flat
ACPI: HPET id: 0x10228203 base: 0xfecff000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
SMP: Allowing 4 CPUs, 0 hotplug CPUs
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet console=ttyS1,19200 autobench_args: root=30726124 ABAT:1149529388 earlyprintk=serial,ttyS1,19200
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
Red Hat nash version 5.0.32 starting
  Reading all physical volumes.  This may take a while...
  Found volume group "VolGroup00" using metadata type lvm2
  2 logical volume(s) in volume group "VolGroup00" now active
INIT: version 2.86 booting
                Welcome to Fedora Core
                press 'I' to enter interactive startup.
Setting clock  (localtime): Mon Jun  5 12:47:49 CDT 2006 [  OK  ]
Starting udev: [  OK  ]
Setting hostname bl6-13.ltc.austin.ibm.com:  [  OK  ]
Setting up Logical Volume Management:   2 logical volume(s) in volume group "VolGroup00" now active
[  OK  ]
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/VolGroup00/LogVol00 
/dev/VolGroup00/LogVol00: clean, 285228/7929856 files, 2745851/7929856 blocks
[/sbin/fsck.ext3 (1) -- /boot] fsck.ext3 -a /dev/sda1 
/boot: clean, 63/512512 files, 43614/512064 blocks
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling local filesystem quotas:  [  OK  ]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Starting readahead_early:  Starting background readahead: [  OK  ]
[  OK  ]
FATAL: Error inserting acpi_cpufreq (/lib/modules/2.6.17-rc5-mm2-autokern1/kernel/arch/x86_64/kernel/cpufreq/acpi-cpufreq.ko): No such device
Bringing up loopback interface:  [  OK  ]
Bringing up interface eth1:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting irqbalance: [  OK  ]
Starting portmap: [  OK  ]
Starting NFS statd: [  OK  ]
Starting RPC idmapd: FATAL: Module sunrpc not found.
FATAL: Error running install command for sunrpc
Starting system message bus: [  OK  ]
Starting Bluetooth services:[  OK  ]
[  OK  ]
Mounting other filesystems:  [  OK  ]
Starting hidd: [  OK  ]
Starting automount: [  OK  ]
Starting smartd: [  OK  ]
Starting acpi daemon: [  OK  ]
Starting hpiod: [  OK  ]
Starting hpssd: [  OK  ]
Starting cups: [  OK  ]
Starting sshd: [  OK  ]
Starting sendmail: [  OK  ]
Starting sm-client: [  OK  ]
Starting console mouse services: [  OK  ]
Starting crond: [  OK  ]
Starting xfs: [  OK  ]
Starting anacron: [  OK  ]
Starting atd: [  OK  ]
Starting Avahi daemon: [  OK  ]
Starting cups-config-daemon: [  OK  ]
Starting HAL daemon: [  OK  ]
Fedora Core release 5 (Bordeaux)
Kernel 2.6.17-rc5-mm2-autokern1 on an x86_64
bl6-13.ltc.austin.ibm.com login: -- 0:conmux-control -- time-stamp -- Jun/05/06 10:47:46 --
-- 0:conmux-control -- time-stamp -- Jun/05/06 10:51:12 --
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81268fc4>] icmp_rcv+0x17c/0x184
 [<ffffffff812484ca>] ip_local_deliver+0xfe/0x1bf
 [<ffffffff812489bf>] ip_rcv+0x434/0x475
 [<ffffffff8122d615>] netif_receive_skb+0x2c6/0x2e5
 [<ffffffff81199add>] tg3_poll+0x716/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160<7>Losing some ticks... checking if CPU frequency changed.
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff8125923f>] tcp_rcv_established+0xe3/0x71a
 [<ffffffff8126079d>] tcp_v4_do_rcv+0x2b/0x2ff
 [<ffffffff8126106d>] tcp_v4_rcv+0x5fc/0x996
 [<ffffffff812484ca>] ip_local_deliver+0xfe/0x1bf
 [<ffffffff812489bf>] ip_rcv+0x434/0x475
 [<ffffffff8122d615>] netif_receive_skb+0x2c6/0x2e5
 [<ffffffff81199add>] tg3_poll+0x716/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81268fc4>] icmp_rcv+0x17c/0x184
 [<ffffffff812484ca>] ip_local_deliver+0xfe/0x1bf
 [<ffffffff812489bf>] ip_rcv+0x434/0x475
 [<ffffffff8122d615>] netif_receive_skb+0x2c6/0x2e5
 [<ffffffff81199add>] tg3_poll+0x716/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
Unable to handle kernel NULL pointer dereference at 0000000000000010 RIP: 
 [<ffffffff8108b063>] prepare_binprm+0xb/0xf4
PGD ccd9067 PUD e0ce067 PMD 0 
Oops: 0000 [1] SMP 
last sysfs file: /block/sda/sda1/size
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff8125923f>] tcp_rcv_established+0xe3/0x71a
 [<ffffffff8126079d>] tcp_v4_do_rcv+0x2b/0x2ff
 [<ffffffff8126106d>] tcp_v4_rcv+0x5fc/0x996
 [<ffffffff812484ca>] ip_local_deliver+0xfe/0x1bf
 [<ffffffff812489bf>] ip_rcv+0x434/0x475
 [<ffffffff8122d615>] netif_receive_skb+0x2c6/0x2e5
 [<ffffffff81199add>] tg3_poll+0x716/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
CPU 2 
Modules linked in: ipv6 ppdev hidp rfcomm l2cap bluetooth video sony_acpi button battery asus_acpi ac lp parport_pc parport nvram
Pid: 18763, comm: sh Not tainted 2.6.17-rc5-mm2-autokern1 #1
RIP: 0010:[<ffffffff8108b063>]  [<ffffffff8108b063>] prepare_binprm+0xb/0xf4
RSP: 0018:ffff81000cb3ded8  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff81003eae6800 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000003fff RDI: ffff81003eae6800
RBP: ffff810029649c00 R08: ffff81000cb3c000 R09: 000000000000afa7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff81001a618000 R14: 000000000070a560 R15: 000000000070b5c0
FS:  00002aba68ba6d30(0000) GS:ffff81003ffbe8c0(0000) knlGS:00000000f7f5a6b0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000010 CR3: 000000000cdab000 CR4: 00000000000006e0
Process sh (pid: 18763, threadinfo ffff81000cb3c000, task ffff8100285437c0)
Stack: ffff81003eae6800 BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
ffffffff8108b63f ffff81000cb3df58 ffff81001a618000 
       000000000070a560 000000000070b5c0 ffff81001a618000 0000000000709620 
       0000000000000000 ffffffff81007f14 
Call Trace:
 [<ffffffff8108b63f>] do_execve+0x11d/0x24b
 [<ffffffff81007f14>] sys_execve+0x34/0x87
 [<ffffffff81009677>] stub_execve+0x67/0xb0
Code: 48 8b 41 10 48 8b 70 20 b8 f3 ff ff ff 0f b7 56 4c f6 c2 49 
RIP  [<ffffffff8108b063>] prepare_binprm+0xb/0xf4 RSP <ffff81000cb3ded8>
CR2: 0000000000000010
 BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff8125923f>] tcp_rcv_established+0xe3/0x71a
 [<ffffffff8126079d>] tcp_v4_do_rcv+0x2b/0x2ff
 [<ffffffff8126106d>] tcp_v4_rcv+0x5fc/0x996
 [<ffffffff812484ca>] ip_local_deliver+0xfe/0x1bf
 [<ffffffff812489bf>] ip_rcv+0x434/0x475
 [<ffffffff8122d615>] netif_receive_skb+0x2c6/0x2e5
 [<ffffffff81199add>] tg3_poll+0x716/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff811d94a3>] sd_rw_intr+0x2a2/0x2b1
 [<ffffffff811cbe47>] scsi_device_unbusy+0x5d/0x77
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff8125923f>] tcp_rcv_established+0xe3/0x71a
 [<ffffffff8126079d>] tcp_v4_do_rcv+0x2b/0x2ff
 [<ffffffff8126106d>] tcp_v4_rcv+0x5fc/0x996
 [<ffffffff812484ca>] ip_local_deliver+0xfe/0x1bf
 [<ffffffff812489bf>] ip_rcv+0x434/0x475
 [<ffffffff8122d615>] netif_receive_skb+0x2c6/0x2e5
 [<ffffffff81199add>] tg3_poll+0x716/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff8125923f>] tcp_rcv_established+0xe3/0x71a
 [<ffffffff8126079d>] tcp_v4_do_rcv+0x2b/0x2ff
 [<ffffffff8126106d>] tcp_v4_rcv+0x5fc/0x996
 [<ffffffff812484ca>] ip_local_deliver+0xfe/0x1bf
 [<ffffffff812489bf>] ip_rcv+0x434/0x475
 [<ffffffff8122d615>] netif_receive_skb+0x2c6/0x2e5
 [<ffffffff81199add>] tg3_poll+0x716/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff8125923f>] tcp_rcv_established+0xe3/0x71a
 [<ffffffff8126079d>] tcp_v4_do_rcv+0x2b/0x2ff
 [<ffffffff8126106d>] tcp_v4_rcv+0x5fc/0x996
 [<ffffffff812484ca>] ip_local_deliver+0xfe/0x1bf
 [<ffffffff812489bf>] ip_rcv+0x434/0x475
 [<ffffffff8122d615>] netif_receive_skb+0x2c6/0x2e5
 [<ffffffff81199add>] tg3_poll+0x716/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff8125923f>] tcp_rcv_established+0xe3/0x71a
 [<ffffffff8126079d>] tcp_v4_do_rcv+0x2b/0x2ff
 [<ffffffff8126106d>] tcp_v4_rcv+0x5fc/0x996
 [<ffffffff812484ca>] ip_local_deliver+0xfe/0x1bf
 [<ffffffff812489bf>] ip_rcv+0x434/0x475
 [<ffffffff8122d615>] netif_receive_skb+0x2c6/0x2e5
 [<ffffffff81199add>] tg3_poll+0x716/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff811d94a3>] sd_rw_intr+0x2a2/0x2b1
 [<ffffffff811cbe47>] scsi_device_unbusy+0x5d/0x77
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff8125923f>] tcp_rcv_established+0xe3/0x71a
 [<ffffffff8126079d>] tcp_v4_do_rcv+0x2b/0x2ff
 [<ffffffff8126106d>] tcp_v4_rcv+0x5fc/0x996
 [<ffffffff812484ca>] ip_local_deliver+0xfe/0x1bf
 [<ffffffff812489bf>] ip_rcv+0x434/0x475
 [<ffffffff8122d615>] netif_receive_skb+0x2c6/0x2e5
 [<ffffffff81199add>] tg3_poll+0x716/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff811d94a3>] sd_rw_intr+0x2a2/0x2b1
 [<ffffffff811cbe47>] scsi_device_unbusy+0x5d/0x77
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff8125923f>] tcp_rcv_established+0xe3/0x71a
 [<ffffffff8126079d>] tcp_v4_do_rcv+0x2b/0x2ff
 [<ffffffff8126106d>] tcp_v4_rcv+0x5fc/0x996
 [<ffffffff812484ca>] ip_local_deliver+0xfe/0x1bf
 [<ffffffff812489bf>] ip_rcv+0x434/0x475
 [<ffffffff8122d615>] netif_receive_skb+0x2c6/0x2e5
 [<ffffffff81199add>] tg3_poll+0x716/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
BUG: warning at include/net/dst.h:153/dst_release()
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81252ce2>] tcp_recvmsg+0x622/0x7fb
 [<ffffffff8122720e>] sock_common_recvmsg+0x2d/0x44
 [<ffffffff81223aaf>] do_sock_read+0xc6/0xd1
 [<ffffffff81223bff>] sock_aio_read+0x4f/0x5e
 [<ffffffff8102bed5>] __wake_up+0x36/0x4d
 [<ffffffff81080bc8>] do_sync_read+0xc9/0x106
 [<ffffffff81045d20>] autoremove_wake_function+0x0/0x2e
 [<ffffffff81170577>] tty_ldisc_deref+0x65/0x77
 [<ffffffff81080ce9>] vfs_read+0xe4/0x172
 [<ffffffff81081037>] sys_read+0x45/0x6e
 [<ffffffff810092be>] system_call+0x7e/0x83
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81252ce2>] tcp_recvmsg+0x622/0x7fb
 [<ffffffff8122720e>] sock_common_recvmsg+0x2d/0x44
 [<ffffffff81223aaf>] do_sock_read+0xc6/0xd1
 [<ffffffff81223bff>] sock_aio_read+0x4f/0x5e
 [<ffffffff8102bed5>] __wake_up+0x36/0x4d
 [<ffffffff81080bc8>] do_sync_read+0xc9/0x106
 [<ffffffff81045d20>] autoremove_wake_function+0x0/0x2e
 [<ffffffff81170577>] tty_ldisc_deref+0x65/0x77
 [<ffffffff81080ce9>] vfs_read+0xe4/0x172
 [<ffffffff81081037>] sys_read+0x45/0x6e
 [<ffffffff810092be>] system_call+0x7e/0x83
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff811d94a3>] sd_rw_intr+0x2a2/0x2b1
 [<ffffffff811cbe47>] scsi_device_unbusy+0x5d/0x77
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff8125923f>] tcp_rcv_established+0xe3/0x71a
 [<ffffffff8126079d>] tcp_v4_do_rcv+0x2b/0x2ff
 [<ffffffff8126106d>] tcp_v4_rcv+0x5fc/0x996
 [<ffffffff812484ca>] ip_local_deliver+0xfe/0x1bf
 [<ffffffff812489bf>] ip_rcv+0x434/0x475
 [<ffffffff8122d615>] netif_receive_skb+0x2c6/0x2e5
 [<ffffffff81199add>] tg3_poll+0x716/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
BUG: warning at include/net/dst.h:153/dst_release()
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff811d94a3>] sd_rw_intr+0x2a2/0x2b1
 [<ffffffff811cbe47>] scsi_device_unbusy+0x5d/0x77
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
Call Trace:
 [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81252ce2>] tcp_recvmsg+0x622/0x7fb
 [<ffffffff8122720e>] sock_common_recvmsg+0x2d/0x44
 [<ffffffff81223aaf>] do_sock_read+0xc6/0xd1
 [<ffffffff81223bff>] sock_aio_read+0x4f/0x5e
 [<ffffffff8102bed5>] __wake_up+0x36/0x4d
 [<ffffffff81080bc8>] do_sync_read+0xc9/0x106BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
 [<ffffffff81045d20>] autoremove_wake_function+0x0/0x2e
 [<ffffffff81092210>] do_ioctl+0x64/0x6f
 [<ffffffff81080ce9>] vfs_read+0xe4/0x172
 [<ffffffff81081037>] sys_read+0x45/0x6e
 [<ffffffff810092be>] system_call+0x7e/0x83
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81252ce2>] tcp_recvmsg+0x622/0x7fb
 [<ffffffff8122720e>] sock_common_recvmsg+0x2d/0x44
 [<ffffffff81223aaf>] do_sock_read+0xc6/0xd1
 [<ffffffff81223bff>] sock_aio_read+0x4f/0x5e
 [<ffffffff8102bed5>] __wake_up+0x36/0x4d
 [<ffffffff81080bc8>] do_sync_read+0xc9/0x106
 [<ffffffff81045d20>] autoremove_wake_function+0x0/0x2e
 [<ffffffff81092210>] do_ioctl+0x64/0x6f
 [<ffffffff81080ce9>] vfs_read+0xe4/0x172
 [<ffffffff81081037>] sys_read+0x45/0x6e
 [<ffffffff810092be>] system_call+0x7e/0x83
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81252ce2>] tcp_recvmsg+0x622/0x7fb
 [<ffffffff8122720e>] sock_common_recvmsg+0x2d/0x44
 [<ffffffff81223aaf>] do_sock_read+0xc6/0xd1
 [<ffffffff81223bff>] sock_aio_read+0x4f/0x5e
 [<ffffffff8102bed5>] __wake_up+0x36/0x4d
 [<ffffffff81080bc8>] do_sync_read+0xc9/0x106
 [<ffffffff81045d20>] autoremove_wake_function+0x0/0x2e
 [<ffffffff81092210>] do_ioctl+0x64/0x6f
 [<ffffffff81080ce9>] vfs_read+0xe4/0x172BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff81007807>] default_idle+0x0/0x54
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
 [<ffffffff81081037>] sys_read+0x45/0x6e
 [<ffffffff810092be>] system_call+0x7e/0x83
general protection fault: 0000 [2] SMP 
last sysfs file: /block/sda/sda1/size
CPU 3 
Modules linked in: ipv6 ppdev hidp rfcomm l2cap bluetooth video sony_acpi button battery asus_acpi ac lp parport_pc parport nvram
Pid: 17887, comm: sshd Not tainted 2.6.17-rc5-mm2-autokern1 #1
RIP: 0010:[<ffffffff81228334>]  [<ffffffff81228334>] skb_drop_fraglist+0x17/0x26
RSP: 0018:ffff81000ef8dc48  EFLAGS: 00010206
RAX: 00000000026b2300 RBX: 4000000000000060 RCX: 000000000000b56c
RDX: ffff8100162f6900 RSI: ffffffff81321250 RDI: 4000000000000060
RBP: 0000000000000090 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: ffff81000ea78800 R12: 00000000ffffff95
R13: 0000000000000000 R14: ffff810034b84ac0 R15: 0000000000003f70
FS:  00002ae22a4babe0(0000) GS:ffff810037e0cdc0(0000) knlGS:00000000f7f0b6b0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000005b9e5c CR3: 000000000f2ef000 CR4: 00000000000006e0
Process sshd (pid: 17887, threadinfo ffff81000ef8c000, task ffff810015501840)
Stack: ffff810034b84ac0 ffffffff812283c7 00000000000001d8 ffff810034b84ac0 
       0000000000000090 ffffffff812281c2 ffff81000ea78800 ffffffff81252ce2 
       0000000000000246 0000000100000000 
Call Trace:
 [<ffffffff812283c7>] skb_release_data+0x84/0x97
 [<ffffffff812281c2>] kfree_skbmem+0x9/0x7fBUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff8103b598>] do_timer+0x9b/0x4bd
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
 [<ffffffff81252ce2>] tcp_recvmsg+0x622/0x7fb
 [<ffffffff8122720e>] sock_common_recvmsg+0x2d/0x44
 [<ffffffff81223aaf>] do_sock_read+0xc6/0xd1
 [<ffffffff81223bff>] sock_aio_read+0x4f/0x5e
 [<ffffffff8102bed5>] __wake_up+0x36/0x4d
 [<ffffffff81080bc8>] do_sync_read+0xc9/0x106
 [<ffffffff81045d20>] autoremove_wake_function+0x0/0x2e
 [<ffffffff81092210>] do_ioctl+0x64/0x6f
 [<ffffffff81080ce9>] vfs_read+0xe4/0x172
 [<ffffffff81081037>] sys_read+0x45/0x6e
 [<ffffffff810092be>] system_call+0x7e/0x83
Code: 48 8b 1b e8 b9 ff ff ff 48 85 db 75 f0 5b c3 55 53 48 89 fb 
RIP  [<ffffffff81228334>] skb_drop_fraglist+0x17/0x26 RSP <ffff81000ef8dc48>
 ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/slab.c:3430
invalid opcode: 0000 [3] SMP 
last sysfs file: /block/sda/sda1/size
CPU 1 
Modules linked in: ipv6 ppdev hidp rfcomm l2cap bluetooth video sony_acpi button battery asus_acpi ac lp parport_pc parport nvram
Pid: 6, comm: ksoftirqd/1 Not tainted 2.6.17-rc5-mm2-autokern1 #1
RIP: 0010:[<ffffffff8107d0a4>]  [<ffffffff8107d0a4>] kmem_cache_free+0x5f/0x77
RSP: 0018:ffff810037e1ff28  EFLAGS: 00010287
RAX: 0000000000000080 RBX: ffff81000cfc1480 RCX: 000000000000000a
RDX: ffff81000185c980 RSI: ffff81000e3a6c00 RDI: ffff8100026b2340
RBP: ffff8100024e7d40 R08: 0000000000000008 R09: 0000000000000000
BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
R10: 0000000000000000 R11: ffff81003ff950d0 R12: 0000000000000008
R13: 0000000000000001 R14: ffffffff812b1104 R15: 0000000000000000
FS:  00002ae22a4babe0(0000) GS:ffff81003ff81340(0000) knlGS:00000000f7f5c6b0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000005b9e5c CR3: 0000000001001000 CR4: 00000000000006e0
Process ksoftirqd/1 (pid: 6, threadinfo ffff810037e14000, task ffff81003ff950d0)
Stack: ffff81000cfc1480 ffffffff8104394c ffff8100024e7dc0 0000000000000000 
       ffffffff814cbc90 ffffffff810439ee 0000000000000000 ffffffff81037bc1 
       0000000000000001 ffffffff81476f90 
Call Trace:
 <IRQ> [<ffffffff8104394c>] __rcu_process_callbacks+0x12a/0x1ab
 [<ffffffff810439ee>] rcu_process_callbacks+0x21/0x42
 [<ffffffff81037bc1>] tasklet_action+0x69/0xa8
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff81037d1b>] ksoftirqd+0x0/0xbf
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 <EOI> [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff81037d84>] ksoftirqd+0x69/0xbf
 [<ffffffff81045806>] kthread+0x107/0x133
 [<ffffffff81037d1b>] ksoftirqd+0x0/0xbf
 [<ffffffff8100a146>] child_rip+0x8/0x12
 [<ffffffff81037d1b>] ksoftirqd+0x0/0xbf
 [<ffffffff810456ff>] kthread+0x0/0x133
 [<ffffffff8100a13e>] child_rip+0x0/0x12
Code: 0f 0b 68 41 56 2b 81 c2 66 0d 9c 5b fa 31 d2 e8 99 f9 ff ff 
RIP  [<ffffffff8107d0a4>] kmem_cache_free+0x5f/0x77BUG: warning at include/net/dst.h:153/dst_release()
Call Trace:
 <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
 [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
 [<ffffffff8122d80c>] net_rx_action+0xac/0x160
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
 [<ffffffff810097b8>] ret_from_intr+0x0/0xb
 <EOI>
Attempt to release alive inet socket ffff81003f8b2780
 RSP <ffff810037e1ff28>
 <3>BUG: sleeping function called from invalid context at include/linux/rwsem.h:53
in_atomic():1, irqs_disabled():0
Call Trace:
 <IRQ> [<ffffffff810299a0>] __might_sleep+0xc0/0xc2
 [<ffffffff8103f5a1>] blocking_notifier_call_chain+0x1f/0x4e
 [<ffffffff81034c96>] do_exit+0x22/0x8b2
 [<ffffffff8128a3a7>] _spin_unlock_irqrestore+0xb/0xd
 [<ffffffff8100aa61>] do_divide_error+0x0/0xa2
 [<ffffffff8128ad5e>] do_trap+0xe6/0xf3
 [<ffffffff8100ac90>] do_invalid_op+0x9b/0xa5
 [<ffffffff8107d0a4>] kmem_cache_free+0x5f/0x77
 [<ffffffff81009f8d>] error_exit+0x0/0x84
 [<ffffffff8107d0a4>] kmem_cache_free+0x5f/0x77
 [<ffffffff8104394c>] __rcu_process_callbacks+0x12a/0x1ab
 [<ffffffff810439ee>] rcu_process_callbacks+0x21/0x42
 [<ffffffff81037bc1>] tasklet_action+0x69/0xa8
 [<ffffffff81037904>] __do_softirq+0x48/0xb4
 [<ffffffff81037d1b>] ksoftirqd+0x0/0xbf
 [<ffffffff8100a496>] call_softirq+0x1e/0x28
 <EOI> [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
 [<ffffffff81037d84>] ksoftirqd+0x69/0xbf
 [<ffffffff81045806>] kthread+0x107/0x133
 [<ffffffff81037d1b>] ksoftirqd+0x0/0xbf
 [<ffffffff8100a146>] child_rip+0x8/0x12
 [<ffffffff81037d1b>] ksoftirqd+0x0/0xbf
 [<ffffffff810456ff>] kthread+0x0/0x133
 [<ffffffff8100a13e>] child_rip+0x0/0x12
Kernel panic - not syncing: Aiee, killing interrupt handler!
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
