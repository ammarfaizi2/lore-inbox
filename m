Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVIBRSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVIBRSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVIBRSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:18:31 -0400
Received: from 59-171-177-165.rev.home.ne.jp ([59.171.177.165]:60583 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1750729AbVIBRSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:18:30 -0400
Date: Sat, 03 Sep 2005 02:18:20 +0900 (JST)
Message-Id: <20050903.021820.1300541056.whatisthis@jcom.home.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: [x86_64] Exception when using powernowd.
From: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
X-Mailer: Mew version 4.2.52 on Emacs 22.0.50 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Sat_Sep__3_02_18_20_2005_796)--"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Sat_Sep__3_02_18_20_2005_796)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I'm using MSI K8T Neo2 (VIA K8T800 chipset) and Athlon64 3000+
with  linux x86_64 2.6.13 kernel and Debian/sid.
When enable powernow-k8 (i.e. using powernowd,cpudyn) to
saving power, some process is down by null protection and
system is unstable.
Then disabling powernow-k8,and reboot, system is very stable.

I attach any log,please give me a advice.

Regards,
Ohta.


----Next_Part(Sat_Sep__3_02_18_20_2005_796)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="dmesg.20050902-1.log"

[    0.000000] Bootdata ok (command line is root=/dev/md5 ro hdb=ide-scsi vga=0x315 video=vesafb:ywrap pnpacpi=off )
[    0.000000] Linux version 2.6.13-gcc402 (root@melchior) (gcc version 4.0.2 20050821 (prerelease) (Debian 4.0.1-6)) #2 Tue Aug 30 00:22:00 JST 2005
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e7000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
[    0.000000]  BIOS-e820: 000000003ffc0000 - 000000003ffce000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003ffce000 - 000000003fff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
[    0.000000] ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f7570
[    0.000000] ACPI: RSDT (v001 A M I  OEMRSDT  0x06000508 MSFT 0x00000097) @ 0x000000003ffc0000
[    0.000000] ACPI: FADT (v002 A M I  OEMFACP  0x06000508 MSFT 0x00000097) @ 0x000000003ffc0200
[    0.000000] ACPI: MADT (v001 A M I  OEMAPIC  0x06000508 MSFT 0x00000097) @ 0x000000003ffc0390
[    0.000000] ACPI: OEMB (v001 A M I  AMI_OEM  0x06000508 MSFT 0x00000097) @ 0x000000003ffce040
[    0.000000] ACPI: DSDT (v001  1XXXX 1XXXX005 0x00000005 INTL 0x02002026) @ 0x0000000000000000
[    0.000000] On node 0 totalpages: 261983
[    0.000000]   DMA zone: 3999 pages, LIFO batch:1
[    0.000000]   Normal zone: 257984 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages, LIFO batch:1
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:15 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 40000000 (gap: 40000000:bec00000)
[    0.000000] Checking aperture...
[    0.000000] CPU 0: aperture @ d0000000 size 128 MB
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: root=/dev/md5 ro hdb=ide-scsi vga=0x315 video=vesafb:ywrap pnpacpi=off 
[    0.000000] ide_setup: hdb=ide-scsi
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[    0.000000] time.c: Using 3.579545 MHz PM timer.
[    0.000000] time.c: Detected 1800.145 MHz processor.
[   39.155235] time.c: Using PIT/TSC based timekeeping.
[   39.155259] Console: colour dummy device 80x25
[   39.157182] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   39.160127] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   39.182924] Memory: 1023588k/1048320k available (3696k kernel code, 24276k reserved, 2152k data, 248k init)
[   39.261082] Calibrating delay using timer specific routine.. 3610.32 BogoMIPS (lpj=7220648)
[   39.261113] Security Framework v1.0.0 initialized
[   39.261119] SELinux:  Disabled at boot.
[   39.261123] Capability LSM initialized
[   39.261134] Mount-cache hash table entries: 256
[   39.261213] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   39.261217] CPU: L2 Cache: 512K (64 bytes/line)
[   39.261224] mtrr: v2.0 (20020519)
[   39.261228] CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
[   39.310166] Using local APIC timer interrupts.
[   39.365640] Detected 12.501 MHz APIC timer.
[   39.365657] testing NMI watchdog ... OK.
[   39.405998] NET: Registered protocol family 16
[   39.406023] ACPI: bus type pci registered
[   39.406031] PCI: Using configuration type 1
[   39.406384] ACPI: Subsystem revision 20050408
[   39.414390] ACPI: Interpreter enabled
[   39.414396] ACPI: Using IOAPIC for interrupt routing
(snip)
[ 1045.184824] general protection fault: 0000 [1] 
[ 1045.184829] CPU 0 
[ 1045.184831] Modules linked in: deflate zlib_deflate twofish serpent aes_x86_64 blowfish des sha256 sha1 crypto_null parport_pc lp parport ipt_TOS ipt_MASQUERADE ipt_REJECT ipt_LOG ipt_state ipt_pkttype ipt_CONNMARK ipt_MARK ipt_connmark ipt_owner ipt_recent ipt_iprange ipt_physdev ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp iptable_filter ip_tables ipv6 w83627hf eeprom i2c_sensor w83627hf_wdt i2c_dev i2c_isa i2c_viapro upd64083 upd64031a mpg600gr saa717x ivtv i2c_algo_bit tvaudio tuner saa7134 video_buf v4l2_common v4l1_compat i2c_core ir_common videodev snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_via82xx snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd_rtctimer snd_timer snd soundcore psmouse r8169 tg3 sbp2 tsdev joydev evdev usbhid usblp
[ 1045.184869] Pid: 4001, comm: tar Not tainted 2.6.13-gcc402
[ 1045.184872] RIP: 0010:[<ffffffff801c1028>] <ffffffff801c1028>{__d_lookup+616}
[ 1045.184880] RSP: 0018:ffff81003cb1be38  EFLAGS: 00010202
[ 1045.184884] RAX: 534e4f435f4c5452 RBX: 534e4f435f4c5452 RCX: 0000000000000012
[ 1045.184889] RDX: 0000000000003486 RSI: 01870617c8f43486 RDI: ffff81002c27eeb8
[ 1045.184893] RBP: ffff81000ba4a258 R08: 000000000025c4ea R09: ffff81002f4ac016
[ 1045.184897] R10: 000000000053b590 R11: ffffffff8027b940 R12: ffff81002c27eeb8
[ 1045.184901] R13: 000000000025c4ea R14: ffff81003cb1bef8 R15: 0000000000000003
[ 1045.184905] FS:  00002aaaab01f6d0(0000) GS:ffffffff80730800(0000) knlGS:0000000000000000
[ 1045.184908] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1045.184912] CR2: 00002aaab14b5000 CR3: 00000000077b7000 CR4: 00000000000006e0
[ 1045.184916] Process tar (pid: 4001, threadinfo ffff81003cb1a000, task ffff8100124917d0)
[ 1045.184918] Stack: 0000000100000010 ffff810000000000 ffff81002f4ac016 0000000000000000 
[ 1045.184924]        ffff81002c27eeb8 0000000000000000 ffff81003cb1bef8 ffff810009841a50 
[ 1045.184930]        0000000000000035 ffffffff801b17a4 
[ 1045.184933] Call Trace:<ffffffff801b17a4>{__lookup_hash+116} <ffffffff801b18de>{lookup_create+110}
[ 1045.184953]        <ffffffff801b5f89>{sys_mkdir+105} <ffffffff8019bd38>{sys_close+360}
[ 1045.184969]        <ffffffff8010f31e>{system_call+126} 
[ 1045.184984] 
[ 1045.184985] Code: 48 8b 03 0f 18 08 44 3b ab 78 ff ff ff 48 8d ab 30 ff ff ff 
[ 1045.184993] RIP <ffffffff801c1028>{__d_lookup+616} RSP <ffff81003cb1be38>
[ 1045.184999]  <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
[ 1045.185005] in_atomic():0, irqs_disabled():1
[ 1045.185006] 
[ 1045.185007] Call Trace:<ffffffff8013d8c5>{profile_task_exit+21} <ffffffff8013f412>{do_exit+34}
[ 1045.185017]        <ffffffff80300737>{do_unblank_screen+135} <ffffffff80110ef5>{die+69}
[ 1045.185032]        <ffffffff8011130e>{do_general_protection+270} <ffffffff8010fc99>{error_exit+0}
[ 1045.185044]        <ffffffff8027b940>{dummy_inode_permission+0} <ffffffff801c1028>{__d_lookup+616}
[ 1045.185059]        <ffffffff801b17a4>{__lookup_hash+116} <ffffffff801b18de>{lookup_create+110}
[ 1045.185076]        <ffffffff801b5f89>{sys_mkdir+105} <ffffffff8019bd38>{sys_close+360}
[ 1045.185092]        <ffffffff8010f31e>{system_call+126} 

----Next_Part(Sat_Sep__3_02_18_20_2005_796)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="lsmod.20050902-1.log"

Module                  Size  Used by
upd64083               20188  0 
upd64031a              18076  0 
mpg600gr                7380  0 
saa717x                38632  0 
ivtv                 1217140  0 
deflate                 4032  0 
zlib_deflate           24544  1 deflate
twofish                45952  0 
serpent                20288  0 
aes_x86_64             26152  0 
blowfish                9536  0 
des                    17536  0 
sha256                  9472  0 
sha1                    3456  0 
crypto_null             3392  0 
parport_pc             39344  0 
lp                     13632  0 
parport                44492  2 parport_pc,lp
ipt_TOS                 3008  2 
ipt_MASQUERADE          3712  1 
ipt_REJECT              5760  4 
ipt_LOG                 8448  19 
ipt_state               2432  11 
ipt_pkttype             2240  4 
ipt_CONNMARK            2752  0 
ipt_MARK                3200  0 
ipt_connmark            2304  0 
ipt_owner               5888  0 
ipt_recent             15512  0 
ipt_iprange             2432  0 
ipt_physdev             2832  0 
ipt_multiport           3392  0 
ipt_conntrack           2944  0 
iptable_mangle          3328  1 
ip_nat_irc              3136  0 
ip_nat_tftp             2304  0 
ip_nat_ftp              4416  0 
iptable_nat            25240  5 ipt_MASQUERADE,ip_nat_irc,ip_nat_tftp,ip_nat_ftp
ip_conntrack_irc       72704  1 ip_nat_irc
ip_conntrack_tftp       4608  1 ip_nat_tftp
ip_conntrack_ftp       73728  1 ip_nat_ftp
iptable_filter          3392  1 
ip_tables              20480  18 ipt_TOS,ipt_MASQUERADE,ipt_REJECT,ipt_LOG,ipt_state,ipt_pkttype,ipt_CONNMARK,ipt_MARK,ipt_connmark,ipt_owner,ipt_recent,ipt_iprange,ipt_physdev,ipt_multiport,ipt_conntrack,iptable_mangle,iptable_nat,iptable_filter
ipv6                  293280  46 
w83627hf               37864  0 
eeprom                  8144  0 
i2c_sensor              3712  2 w83627hf,eeprom
w83627hf_wdt            6224  0 
i2c_dev                13312  0 
i2c_isa                 3520  0 
i2c_viapro              9368  0 
i2c_algo_bit            9800  1 ivtv
tvaudio                29660  0 
tuner                  40680  0 
saa7134               131412  0 
video_buf              24132  1 saa7134
v4l2_common             7104  1 saa7134
v4l1_compat            13380  1 saa7134
i2c_core               22400  14 upd64083,upd64031a,mpg600gr,saa717x,w83627hf,eeprom,i2c_sensor,i2c_dev,i2c_isa,i2c_viapro,i2c_algo_bit,tvaudio,tuner,saa7134
ir_common               8516  1 saa7134
videodev               10816  2 ivtv,saa7134
snd_seq_dummy           3908  0 
snd_seq_oss            42852  0 
snd_seq_midi            8832  0 
snd_seq_midi_event      9664  2 snd_seq_oss,snd_seq_midi
snd_seq                75096  6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_via82xx            30816  0 
snd_ac97_codec         98756  1 snd_via82xx
snd_pcm_oss            57952  0 
snd_mixer_oss          18368  1 snd_pcm_oss
snd_pcm               108748  3 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_page_alloc         10768  2 snd_via82xx,snd_pcm
snd_mpu401_uart        10432  1 snd_via82xx
snd_rawmidi            30880  2 snd_seq_midi,snd_mpu401_uart
snd_seq_device          9488  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_rawmidi
snd_rtctimer            3752  0 
snd_timer              32968  3 snd_seq,snd_pcm,snd_rtctimer
snd                    61504  11 snd_seq_oss,snd_seq,snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_mpu401_uart,snd_rawmidi,snd_seq_device,snd_timer
soundcore              10848  2 saa7134,snd
psmouse                36356  0 
r8169                  34504  0 
tg3                   117124  0 
sbp2                   27144  8 
tsdev                   8064  0 
joydev                 10880  0 
evdev                  11840  0 
usbhid                 40992  0 
usblp                  14336  0 

----Next_Part(Sat_Sep__3_02_18_20_2005_796)--
Content-Type: Application/Octet-Stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dot.config.gz"

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

----Next_Part(Sat_Sep__3_02_18_20_2005_796)----
