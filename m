Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVBOCWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVBOCWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 21:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVBOCWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 21:22:23 -0500
Received: from a213-22-240-12.netcabo.pt ([213.22.240.12]:2176 "EHLO
	sergiomb.no-ip.org") by vger.kernel.org with ESMTP id S261593AbVBOCWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 21:22:13 -0500
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov
X-Antivirus-bastov: 1.24-st-qms (Clear:RC:1(192.168.1.2):. Processed in 0.304146 secs Process 5643)
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give
	dev=/dev/hdX as device
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1108426832.5015.4.camel@bastov>
References: <1108426832.5015.4.camel@bastov>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 15 Feb 2005 02:22:07 +0000
Message-Id: <1108434128.5491.8.camel@bastov>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for the google archives :

I work with Linux more than 10 years and this messages are a great
sheet ! I can't understand a thing of the fuck is going in the mind of
the author.

"Use ide-cd and give dev=/dev/hdX as device" 
cracks me up , Can someone translate this to English ?

reading man fstab-sync we get 

 --add=UDI
Add an entry to the /etc/fstab file by giving a HAL Unique Device
Identifier

no fucking example of the fuck is one UDI !

here is my /var/log/message after a reboot the cdwriter still no
working.
A fucking example could be a great help !

Feb 15 01:41:44 bastov su(pam_unix)[5370]: session opened for user root by sergio(uid=500)
Feb 15 01:55:51 bastov kernel: SCSI subsystem initialized
Feb 15 01:55:51 bastov kernel: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
Feb 15 01:55:51 bastov kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Feb 15 01:55:51 bastov kernel:   Vendor: HP        Model: CD-Writer+ 8200   Rev: 1.0f
Feb 15 01:55:51 bastov kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Feb 15 01:55:51 bastov hald[4294]: Timed out waiting for hotplug event 701. Rebasing to 705
Feb 15 01:55:51 bastov scsi.agent[5621]: cdrom at /devices/pci0000:00/0000:00:1f.1/ide1/1.0/host0/target0:0:0/0:0:0:0
Feb 15 01:55:51 bastov kernel: ide-scsi: Warning this device driver is only intended for specialist devices.
Feb 15 01:55:51 bastov kernel: ide-scsi: Do not use for cd burning, use /dev/hdX directly instead.
Feb 15 01:55:51 bastov kernel: sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Feb 15 01:55:51 bastov kernel: ide-scsi: unsup command: dev hdc: flags = REQ_CMD REQ_STARTED
Feb 15 01:55:51 bastov kernel: sector 0, nr/cnr 1/1
Feb 15 01:55:51 bastov kernel: bio c06558c0, biotail c06558c0, buffer c601f000, data 00000000, len 0
Feb 15 01:55:51 bastov kernel: end_request: I/O error, dev hdc, sector 0
Feb 15 01:55:51 bastov kernel: FAT: unable to read boot sector
Feb 15 01:55:51 bastov kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Feb 15 01:55:51 bastov kernel:  printing eip:
Feb 15 01:55:51 bastov kernel: c01d5fac
Feb 15 01:55:51 bastov kernel: *pde = 00000000
Feb 15 01:55:51 bastov kernel: Oops: 0000 [#1]
Feb 15 01:55:51 bastov kernel: Modules linked in: sr_mod ide_scsi scsi_mod md5 ipv6 parport_pc lp parport autofs4sunrpc pcmcia yenta_socket pcmcia_core microcode vfat fat dm_mod video button battery ac uhci_hcd hw_random i2c_i801 i2c_core snd_ens1371 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer sndsoundcore snd_page_alloc gameport 3c59x floppy ext3 jbd
Feb 15 01:55:51 bastov kernel: CPU:    0
Feb 15 01:55:51 bastov kernel: EIP:    0060:[<c01d5fac>]    Not tainted VLI
Feb 15 01:55:51 bastov kernel: EFLAGS: 00210286   (2.6.10-1.760_FC3)
Feb 15 01:55:51 bastov kernel: EIP is at get_kobj_path_length+0x10/0x25
Feb 15 01:55:51 bastov kernel: eax: 00000000   ebx: 00000001   ecx: ffffffff   edx: d3dd5490
Feb 15 01:55:51 bastov kernel: esi: 00000000   edi: 00000000   ebp: d3dd5490   esp: c0e74e44
Feb 15 01:55:51 bastov kernel: ds: 007b   es: 007b   ss: 0068
Feb 15 01:55:51 bastov kernel: Process mount (pid: 5559, threadinfo=c0e74000 task=ca144e50)
Feb 15 01:55:51 bastov kernel: Stack: 000000d0 00000005 c01d6016 00000005 d2419400 00000000 00000005 d499fec0
Feb 15 01:55:51 bastov kernel:        c01d6716 fffffff4 d2419400 d2a7c2c0 d499fec0 d499fec0 c01d67c1 000000d0
Feb 15 01:55:51 bastov kernel:        c01689ed d2419440 d2419400 c01670b5 fffffffb fffffffb d2a7c2c0 c01689b0
Feb 15 01:55:51 bastov kernel: Call Trace:
Feb 15 01:55:51 bastov kernel:  [<c01d6016>] kobject_get_path+0xe/0x4a
Feb 15 01:55:51 bastov kernel:  [<c01d6716>] do_kobject_uevent+0x19/0xba
Feb 15 01:55:51 bastov kernel:  [<c01d67c1>] kobject_uevent+0xa/0xc
Feb 15 01:55:51 bastov kernel:  [<c01689ed>] kill_block_super+0x16/0x30
Feb 15 01:55:51 bastov kernel:  [<c01670b5>] deactivate_super+0xc8/0xdd
Feb 15 01:55:51 bastov kernel:  [<c01689b0>] get_sb_bdev+0xf1/0x118
Feb 15 01:55:51 bastov kernel:  [<c01c178c>] selinux_sb_copy_data+0x33/0x159
Feb 15 01:55:51 bastov kernel:  [<d499e851>] vfat_get_sb+0xe/0x11 [vfat]
Feb 15 01:55:51 bastov kernel:  [<d499e80d>] vfat_fill_super+0x0/0x36 [vfat]
Feb 15 01:55:51 bastov kernel:  [<c0168b72>] do_kern_mount+0x8a/0x13a
Feb 15 01:55:51 bastov kernel:  [<c0180cc4>] do_new_mount+0x61/0x90
Feb 15 01:55:51 bastov kernel:  [<c0181677>] do_mount+0x178/0x190
Feb 15 01:55:51 bastov kernel:  [<c0143394>] __alloc_pages+0xac/0x28e
Feb 15 01:55:51 bastov kernel:  [<c0181a96>] sys_mount+0x6a/0xbd
Feb 15 01:55:51 bastov kernel:  [<c0103443>] syscall_call+0x7/0xb
Feb 15 01:55:51 bastov kernel: Code: 75 14 89 d8 e8 9a ff ff ff 85 c0 89 c6 74 07 89 d8 e8 4e c9 fc ff 5b 89 f0 5e c3 57 89 c2 53 bb 01 00 00 00 8b 3a 31 c0 83 c9 ff <f2> ae f7 d1 49 8b 52 24 8d 5c 0b 01 85 d2 75 e9 89 d8 5b 5fc3
Feb 15 01:55:56 bastov fstab-sync[5755]: added mount point /media/cdrecorder for /dev/scd0






On Tue, 2005-02-15 at 00:20 +0000, Sergio Monteiro Basto wrote:
> What this message means ?
> 
> instead 
> hdc=ide-scsi 
> what should I put in options of boot kernel ?
> 
> 
> please cc me with a quick reply.
> for google the archives 
> 
> thanks,
-- 
Sérgio M.B.

