Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWIOIa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWIOIa4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWIOIa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:30:56 -0400
Received: from k2smtpout03-01.prod.mesa1.secureserver.net ([64.202.189.171]:63640
	"HELO k2smtpout03-01.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1750742AbWIOIaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:30:55 -0400
X-Antivirus-MYDOMAIN-Mail-From: razvan.g@plutohome.com via plutohome.com.secureserver.net
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:0(82.77.255.201):SA:0(-2.4/5.0):. Processed in 1.091118 secs Process 4644)
Message-ID: <450A64CC.5060008@plutohome.com>
Date: Fri, 15 Sep 2006 11:31:08 +0300
From: Razvan Gavril <razvan.g@plutohome.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Some ooupses with 2.6.18rc7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: unable to handle kernel NULL pointer dereference at virtual address 
00000001
 printing eip:
00000001
*pde = 00000000
Oops: 0000 [#11]
SMP
Modules linked in: ide_generic bttv video_buf firmware_class rfcomm 
ir_common compat_ioctl32 i2c_algo_bit l2cap btcx_risc tveeprom videodev 
v4l1_compat v4l2_common ipt_TCPMSS xt_tcpudp xt_mark xt_state 
iptable_nat iptable_filter ip_tables x_tables nfsd exportfs lockd 
nfs_acl sunrpc ext2 autofs4 nvidia agpgart ipv6 vga16fb vgastate 
mousedev ip_nat_irc ip_nat_ftp ip_nat ip_conntrack_irc ip_conntrack_ftp 
ip_conntrack nfnetlink sr_mod sbp2 hci_usb bluetooth snd_hda_intel 
snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm analog eth1394 psmouse 
ftdi_sio gameport snd_mpu401 serio_raw evdev joydev snd_mpu401_uart 
snd_rawmidi snd_seq_device parport_pc parport snd_timer rtc floppy snd 
soundcore i2c_nforce2 snd_page_alloc pl2303 i2c_core usbserial ext3 jbd 
mbcache 8139too sd_mod ide_cd cdrom ide_disk usbhid sata_nv libata 
scsi_mod 8139cp mii ohci1394 ieee1394 ehci_hcd forcedeth amd74xx generic 
ide_core ohci_hcd usbcore
CPU:    0
EIP:    0060:[<00000001>]    Tainted: P      VLI
EFLAGS: 00010282   (2.6.18-rc7-pluto-1-686-smp #1)
EIP is at 0x1
eax: 00000000   ebx: f6621ac4   ecx: 00000000   edx: df8e0418
esi: f6621ac4   edi: 00000003   ebp: 00000003   esp: c2137fb4
ds: 007b   es: 007b   ss: 0068
Process auto.PlutoStora (pid: 32239, ti=c2136000 task=b212f030 
task.ti=c2136000)
Stack: c2136000 b010329b 00000003 00000000 00000000 00000003 00000001 
af970218
       0000003f 0000007b 0000007b 0000003f a7e8ffa1 00000073 00000206 
af9701cc
       0000007b 5a5a5a5a a55a5a5a
Call Trace:
 [<b010329b>] syscall_call+0x7/0xb
Code:  Bad EIP value.
EIP: [<00000001>] 0x1 SS:ESP 0068:c2137fb4




Sep 15 03:31:02 dcerouter kernel: BUG: unable to handle kernel NULL 
pointer dereference at virtual address 00000003
Sep 15 03:31:02 dcerouter kernel:  printing eip:
Sep 15 03:31:02 dcerouter kernel: 00000003
Sep 15 03:31:02 dcerouter kernel: *pde = 00000000
Sep 15 03:31:02 dcerouter kernel: Oops: 0000 [#10]
Sep 15 03:31:02 dcerouter kernel: SMP
Sep 15 03:31:02 dcerouter kernel: Modules linked in: ide_generic bttv 
video_buf firmware_class rfcomm ir_common compat_ioctl32 i2c_algo_bit 
l2cap btcx_risc tveeprom videodev v4l1_compat v4l2_common ipt_TCPMSS 
xt_tcpudp xt_mark xt_state iptable_nat iptable_filter ip_tables x_tables 
nfsd exportfs lockd nfs_acl sunrpc ext2 autofs4 nvidia agpgart ipv6 vga16fb
vgastate mousedev ip_nat_irc ip_nat_ftp ip_nat ip_conntrack_irc 
ip_conntrack_ftp ip_conntrack nfnetlink sr_mod sbp2 hci_usb bluetooth 
snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm analog 
eth1394 psmouse ftdi_sio gameport snd_mpu401 serio_raw evdev joydev 
snd_mpu401_uart snd_rawmidi snd_seq_device parport_pc parport snd_timer 
rtc floppy snd
soundcore i2c_nforce2 snd_page_alloc pl2303 i2c_core usbserial ext3 jbd 
mbcache 8139too sd_mod ide_cd cdrom ide_disk usbhid sata_nv libata 
scsi_mod 8139cp mii ohci1394 ieee1394 ehci_hcd forcedeth amd74xx generic 
ide_core ohci_hcd usbcore
Sep 15 03:31:02 dcerouter kernel: CPU:    0
Sep 15 03:31:02 dcerouter kernel: EIP:    0060:[<00000003>]    Tainted: 
P      VLI
Sep 15 03:31:02 dcerouter kernel: EFLAGS: 00010282   
(2.6.18-rc7-pluto-1-686-smp #1)
Sep 15 03:31:02 dcerouter kernel: EIP is at 0x3
Sep 15 03:31:02 dcerouter kernel: eax: 00000001   ebx: dfa8d238   ecx: 
00000000   edx: f39d7250
Sep 15 03:31:02 dcerouter kernel: esi: dfa8d238   edi: 00000003   ebp: 
00000003   esp: cf12bfb4
Sep 15 03:31:02 dcerouter kernel: ds: 007b   es: 007b   ss: 0068
Sep 15 03:31:02 dcerouter kernel: Process SetupRemoteAcce (pid: 29092, 
ti=cf12a000 task=bf0e6570 task.ti=cf12a000)
Sep 15 03:31:02 dcerouter kernel: Stack: cf12a000 b010329b 00000003 
00000001 00000000 00000003 00000003 afbea618
Sep 15 03:31:02 dcerouter kernel:        0000003f 0000007b 0000007b 
0000003f a7ef7fa1 00000073 00000202 afbea5cc
Sep 15 03:31:02 dcerouter kernel:        0000007b 5a5a5a5a a55a5a5a
Sep 15 03:31:02 dcerouter kernel: Call Trace:
Sep 15 03:31:02 dcerouter kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 15 03:31:02 dcerouter kernel: Code:  Bad EIP value.
Sep 15 03:31:02 dcerouter kernel: EIP: [<00000003>] 0x3 SS:ESP 0068:cf12bfb4

