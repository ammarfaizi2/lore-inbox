Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbTIIFqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 01:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263955AbTIIFqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 01:46:14 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.30]:63588 "EHLO
	mwinf0104.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263949AbTIIFqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 01:46:09 -0400
From: kinarky <kinarky@free.fr>
Reply-To: kinarky@free.fr
To: linux-kernel@vger.kernel.org
Subject: crash log with 2.4.22 kernel and usb modem
Date: Tue, 9 Sep 2003 07:33:02 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309090733.02884.kinarky@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello maybe this log describe a 2.4.22 kernel bug, sometimes it make my 
keyboard leds blink
it happens when a speedtouch usb modem loose sync, i don't really know what 
exactly is involved in the kernel
at 6:34 the 9 sep i was watching a divx with this box :-\
chipset via kt133 
usb controller VT82C586B USB

Sep  9 06:34:29 masteur /etc/hotplug/net.agent: NET unregister event not 
supported
Sep  9 06:34:33 masteur /etc/hotplug/net.agent: assuming ppp0 is already up
Sep  9 06:34:34 masteur net_cnx_down: Arret Connexion ADSL:
Sep  9 06:34:34 masteur kernel: usb.c: USB disconnect on device 00:04.2-0 
address 1
Sep  9 06:34:34 masteur kernel: usb.c: USB disconnect on device 00:04.2-2 
address 2
Sep  9 06:34:34 masteur kernel: usb.c: USB bus 1 deregistered
Sep  9 06:34:34 masteur kernel: usb.c: USB disconnect on device 00:04.3-0 
address 1
Sep  9 06:34:34 masteur kernel: usb.c: USB disconnect on device 00:04.3-2 
address 2
Sep  9 06:34:34 masteur kernel: usb.c: USB bus 2 deregistered
Sep  9 06:34:34 masteur kernel: kmem_cache_destroy: Can't free all objects 
c184ac90
Sep  9 06:34:34 masteur kernel: uhci: not all urb_priv's were freed
Sep  9 06:34:34 masteur net_cnx_down:
Sep  9 06:34:34 masteur internet: Stopping internet connection if needed:  
succeeded
Sep  9 06:34:36 masteur net_cnx_up: SIOCDELRT: No such process
Sep  9 06:34:36 masteur net_cnx_up: Lancement Connexion ADSL:
Sep  9 06:34:36 masteur kernel: uhci.c: USB Universal Host Controller 
Interface driver v1.1
Sep  9 06:34:36 masteur kernel: kernel BUG at slab.c:815!
Sep  9 06:34:36 masteur kernel: invalid operand: 0000
Sep  9 06:34:36 masteur kernel: uhci udf i2c-dev agpgart nvidia binfmt_misc lp 
parport_pc parport snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm snd-timer 
snd-page-alloc snd-rawmidi snd-util-mem snd-seq-device snd-hwdep 
snd-ac97-codec snd soundcore ipt_ttl ipt_unclean ipt_TCPMSS ip_nat_irc 
ip_nat_ftp ipt_limit ipt_state iptable_filter iptable_mangle ipt_LOG 
ipt_MASQUERADE ipt_TOS ipt_REDIRECT iptable_nat ipt_REJECT ip_tables 
ip_conntrack_irc ip_conntrack_ftp ip_conntrack ppp_deflate bsd_comp pppoatm 
ppp_async ppp_generic slhc af_packet via686a w83781d i2c-proc i2c-isa 
i2c-viapro i2c-core sr_mod floppy 8139too mii nls_iso8859-15 nls_cp850 vfat 
fat supermount ide-cd cdrom ide-scsi scsi_mod speedtch usbcore rtc ext3 jbd
Sep  9 06:34:36 masteur kernel: CPU:    0
Sep  9 06:34:36 masteur kernel: EIP:    0010:[kmem_cache_create+573/912]    
Tainted: P
Sep  9 06:34:36 masteur kernel: EIP:    0010:[<c01f69bd>]    Tainted: P
Sep  9 06:34:36 masteur kernel: EFLAGS: 00010246
Sep  9 06:34:36 masteur kernel: EIP is at kmem_cache_create+0x23d/0x390 
[kernel]
Sep  9 06:34:36 masteur kernel: eax: 00000000   ebx: c184add4   ecx: c184acf4   
edx: c184acf4
Sep  9 06:34:36 masteur kernel: esi: c184acee   edi: f0839dc8   ebp: c015d538   
esp: d98cfee4
Sep  9 06:34:36 masteur kernel: ds: 0018   es: 0018   ss: 0018
Sep  9 06:34:36 masteur kernel: Process insmod (pid: 6338, stackpage=d98cf000)
Sep  9 06:34:36 masteur kernel: Stack: fffffffc 0000001c fffffff4 f083ad08 
00000019 ffffffea f083986a f0839dba
Sep  9 06:34:36 masteur kernel:        0000003c 00000020 00000000 00000000 
00000000 f0835000 c01d7b90 f083acfc
Sep  9 06:34:36 masteur kernel:        00000001 081419b8 00005c30 00000060 
00000060 00000004 00000001 ef344bc0
Sep  9 06:34:36 masteur kernel: Call Trace:
Sep  9 06:34:37 masteur kernel:  
[ipt_state:__insmod_ipt_state_O/lib/modules/2.4.22-6mdk/kernel/net/ipv+-1524472/96] 
__ksymtab+0x0/0x28 [uhci]
Sep  9 06:34:37 masteur kernel:  [<f083ad08>] __ksymtab+0x0/0x28 [uhci]
Sep  9 06:34:37 masteur kernel:  
[ipt_state:__insmod_ipt_state_O/lib/modules/2.4.22-6mdk/kernel/net/ipv+-1529750/96] 
uhci_hcd_init+0x6a/0xf0 [uhci]
Sep  9 06:34:37 masteur kernel:  [<f083986a>] uhci_hcd_init+0x6a/0xf0 [uhci]
Sep  9 06:34:37 masteur kernel:  
[ipt_state:__insmod_ipt_state_O/lib/modules/2.4.22-6mdk/kernel/net/ipv+-1528390/96] 
.rodata.str1.1+0x3e1/0x407 [uhci]
Sep  9 06:34:37 masteur kernel:  [<f0839dba>] .rodata.str1.1+0x3e1/0x407 
[uhci]
Sep  9 06:34:37 masteur kernel:  [sys_init_module+1552/1664] 
sys_init_module+0x610/0x680 [kernel]
Sep  9 06:34:37 masteur kernel:  [<c01d7b90>] sys_init_module+0x610/0x680 
[kernel]
Sep  9 06:34:37 masteur kernel:  
[ipt_state:__insmod_ipt_state_O/lib/modules/2.4.22-6mdk/kernel/net/ipv+-1524484/96] 
.kmodtab+0x0/0xc [uhci]
Sep  9 06:34:37 masteur kernel:  [<f083acfc>] .kmodtab+0x0/0xc [uhci]
Sep  9 06:34:37 masteur kernel:  
[ipt_state:__insmod_ipt_state_O/lib/modules/2.4.22-6mdk/kernel/net/ipv+-1548192/96] 
uhci_show_td+0x0/0x1a0 [uhci]
Sep  9 06:34:37 masteur kernel:  [<f0835060>] uhci_show_td+0x0/0x1a0 [uhci]
Sep  9 06:34:37 masteur kernel:  [system_call+51/64] system_call+0x33/0x40 
[kernel]
Sep  9 06:34:37 masteur kernel:  [<c01c3093>] system_call+0x33/0x40 [kernel]
Sep  9 06:34:37 masteur kernel:
Sep  9 06:34:37 masteur kernel: Code: 0f 0b 2f 03 6b b0 34 c0 8b 12 81 fa e4 
38 10 c0 75 d3 8d 43
Sep  9 06:34:36 masteur net_cnx_up: modprobe: insmod 
/lib/modules/2.4.22-6mdk/kernel/drivers/usb/host/uhci.o.gz failed
Sep  9 06:34:37 masteur net_cnx_up: modprobe: insmod uhci failed
Sep  9 06:34:40 masteur /etc/hotplug/net.agent: NET unregister event not 
supported

