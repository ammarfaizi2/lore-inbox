Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274174AbRJDPLl>; Thu, 4 Oct 2001 11:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274133AbRJDPLW>; Thu, 4 Oct 2001 11:11:22 -0400
Received: from pop.gmx.de ([213.165.64.20]:39470 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S274162AbRJDPLQ>;
	Thu, 4 Oct 2001 11:11:16 -0400
Date: Tue, 2 Oct 2001 23:11:45 +0200
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [2.4.10] invalid operand: 0000
Message-ID: <20011002231145.A30457@marvin.mahowi.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.10 i686
X-Editor: VIM - Vi IMproved 5.7 (2000 Jun 24, compiled Apr  6 2001 09:59:07)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've got a kernel error "invalid operand: 0000" on 2.4.10. Here's what
ksymoops says:


ksymoops 2.4.0 on i686 2.4.10.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10/ (default)
     -m /usr/src/linux/System.map (specified)

Warning (expand_objects): object /lib/modules/2.4.10/kernel/drivers/net/8139too.o for module 8139too has changed since load
Warning (expand_objects): object /lib/modules/2.4.10/kernel/drivers/scsi/ide-scsi.o for module ide-scsi has changed since load
Warning (expand_objects): object /lib/modules/2.4.10/kernel/drivers/scsi/aic7xxx/aic7xxx.o for module aic7xxx has changed since load
Warning (expand_objects): object /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o for module scsi_mod has changed since load
Warning (compare_maps): mismatch on symbol audio_devs  , sound says cde4b620, /lib/modules/2.4.10/kernel/drivers/sound/sound.o says cde4afc0.  Ignoring /lib/modules/2.4.10/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol midi_devs  , sound says cde4b690, /lib/modules/2.4.10/kernel/drivers/sound/sound.o says cde4b030.  Ignoring /lib/modules/2.4.10/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol mixer_devs  , sound says cde4b638, /lib/modules/2.4.10/kernel/drivers/sound/sound.o says cde4afd8.  Ignoring /lib/modules/2.4.10/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_audiodevs  , sound says cde4b634, /lib/modules/2.4.10/kernel/drivers/sound/sound.o says cde4afd4.  Ignoring /lib/modules/2.4.10/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_midis  , sound says cde4b6a8, /lib/modules/2.4.10/kernel/drivers/sound/sound.o says cde4b048.  Ignoring /lib/modules/2.4.10/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_mixers  , sound says cde4b64c, /lib/modules/2.4.10/kernel/drivers/sound/sound.o says cde4afec.  Ignoring /lib/modules/2.4.10/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_synths  , sound says cde4b68c, /lib/modules/2.4.10/kernel/drivers/sound/sound.o says cde4b02c.  Ignoring /lib/modules/2.4.10/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol synth_devs  , sound says cde4b660, /lib/modules/2.4.10/kernel/drivers/sound/sound.o says cde4b000.  Ignoring /lib/modules/2.4.10/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol sd  , sd_mod says c8d53958, /lib/modules/2.4.10/kernel/drivers/scsi/sd_mod.o says c8d537e0.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/sd_mod.o entry
Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says c8d4fb00, /lib/modules/2.4.10/kernel/net/packet/af_packet.o says c8d4f8e4.  Ignoring /lib/modules/2.4.10/kernel/net/packet/af_packet.o entry
Warning (compare_maps): mismatch on symbol ConnectCount  , khttpd says c8d36080, /lib/modules/2.4.10/kernel/net/khttpd/khttpd.o says c8d35100.  Ignoring /lib/modules/2.4.10/kernel/net/khttpd/khttpd.o entry
Warning (compare_maps): mismatch on symbol CurrentTime  , khttpd says c8d37040, /lib/modules/2.4.10/kernel/net/khttpd/khttpd.o says c8d360c0.  Ignoring /lib/modules/2.4.10/kernel/net/khttpd/khttpd.o entry
Warning (compare_maps): mismatch on symbol CurrentTime_i  , khttpd says c8d37080, /lib/modules/2.4.10/kernel/net/khttpd/khttpd.o says c8d36100.  Ignoring /lib/modules/2.4.10/kernel/net/khttpd/khttpd.o entry
Warning (compare_maps): mismatch on symbol DaemonCount  , khttpd says c8d36084, /lib/modules/2.4.10/kernel/net/khttpd/khttpd.o says c8d35104.  Ignoring /lib/modules/2.4.10/kernel/net/khttpd/khttpd.o entry
Warning (compare_maps): mismatch on symbol sysctl_khttpd_dynamicstring  , khttpd says c8d370a0, /lib/modules/2.4.10/kernel/net/khttpd/khttpd.o says c8d36120.  Ignoring /lib/modules/2.4.10/kernel/net/khttpd/khttpd.o entry
Warning (compare_maps): mismatch on symbol threadinfo  , khttpd says c8d35e80, /lib/modules/2.4.10/kernel/net/khttpd/khttpd.o says c8d34f00.  Ignoring /lib/modules/2.4.10/kernel/net/khttpd/khttpd.o entry
Warning (compare_maps): mismatch on symbol unix_socket_table  , unix says c88ed0c0, /lib/modules/2.4.10/kernel/net/unix/unix.o says c88ecce0.  Ignoring /lib/modules/2.4.10/kernel/net/unix/unix.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_detect_complete  , aic7xxx says c882f424, /lib/modules/2.4.10/kernel/drivers/scsi/aic7xxx/aic7xxx.o says c882ccc4.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_no_probe  , aic7xxx says c882f420, /lib/modules/2.4.10/kernel/drivers/scsi/aic7xxx/aic7xxx.o says c882ccc0.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_verbose  , aic7xxx says c882f428, /lib/modules/2.4.10/kernel/drivers/scsi/aic7xxx/aic7xxx.o says c882ccc8.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says c8814664, /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o says c8812ebc.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says c8814690, /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o says c8812ee8.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says c881468c, /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o says c8812ee4.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says c8814694, /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o says c8812eec.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod says c8814660, /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o says c8812eb8.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o entry
8139too Fast Ethernet driver 0.9.18a
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012ae81>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c1171080   ebx: c1171080   ecx: c1171080   edx: 00000000
esi: c1171080   edi: 00000000   ebp: 40432000   esp: c5073e64
ds: 0018   es: 0018   ss: 0018
Process as (pid: 8925, stackpage=c5073000)
Stack: c1171080 00052000 c4fc5104 40432000 c1040000 00000206 ffffffff 00001084 
       c012b605 c012b997 c1171080 00052000 c01214c3 c1171080 0000f000 c0121860 
       05c42025 c6544d40 c5ed1d20 40032000 00052000 c7466404 c7466404 40432000 
Call Trace: [<c012b605>] [<c012b997>] [<c01214c3>] [<c0121860>] [<c0123c31>] 
   [<c0114b46>] [<c01186df>] [<c0106c29>] [<c0112dd8>] [<c012e058>] [<c0130273>] 
   [<c0106e94>] [<c0106dc4>] 
Code: 0f 0b 8b 56 08 85 d2 74 02 0f 0b 89 f0 2b 05 0c fa 23 c0 c1 

>>EIP; c012ae81 <__free_pages_ok+11/1e0>   <=====
Trace; c012b605 <__free_pages+1d/20>
Trace; c012b997 <free_page_and_swap_cache+8f/94>
Trace; c01214c3 <__free_pte+53/58>
Trace; c0121860 <zap_page_range+150/1fc>
Trace; c0123c31 <exit_mmap+b5/114>
Trace; c0114b46 <mmput+4a/68>
Trace; c01186df <do_exit+87/1cc>
Trace; c0106c29 <do_signal+21d/284>
Trace; c0112dd8 <do_page_fault+0/4a8>
Trace; c012e058 <shmem_file_write+25c/2bc>
Trace; c0130273 <sys_llseek+cf/dc>
Trace; c0106e94 <error_code+34/40>
Trace; c0106dc4 <signal_return+14/20>
Code;  c012ae81 <__free_pages_ok+11/1e0>
00000000 <_EIP>:
Code;  c012ae81 <__free_pages_ok+11/1e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012ae83 <__free_pages_ok+13/1e0>
   2:   8b 56 08                  mov    0x8(%esi),%edx
Code;  c012ae86 <__free_pages_ok+16/1e0>
   5:   85 d2                     test   %edx,%edx
Code;  c012ae88 <__free_pages_ok+18/1e0>
   7:   74 02                     je     b <_EIP+0xb> c012ae8c <__free_pages_ok+1c/1e0>
Code;  c012ae8a <__free_pages_ok+1a/1e0>
   9:   0f 0b                     ud2a   
Code;  c012ae8c <__free_pages_ok+1c/1e0>
   b:   89 f0                     mov    %esi,%eax
Code;  c012ae8e <__free_pages_ok+1e/1e0>
   d:   2b 05 0c fa 23 c0         sub    0xc023fa0c,%eax
Code;  c012ae94 <__free_pages_ok+24/1e0>
  13:   c1 00 00                  roll   $0x0,(%eax)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c012aeb5>]
EFLAGS: 00010202
eax: 00000005   ebx: c10ee700   ecx: c10ee700   edx: 00000000
esi: c10ee700   edi: 00000000   ebp: c75bde6c   esp: c6b1fed8
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 30217, stackpage=c6b1f000)
Stack: c10ee700 00000000 00000000 c75bde6c 00000000 00000000 c75bde6c c0123e06 
       c012b605 c0123f1c c10ee700 c10ee700 c0124036 c10ee700 00000000 c6b1ff48 
       00000000 c75bde6c 00000000 00000001 c10ee700 c6b1ff48 00000000 c012410b 
Call Trace: [<c0123e06>] [<c012b605>] [<c0123f1c>] [<c0124036>] [<c012410b>] 
   [<c01435ac>] [<c0141c88>] [<c013bb16>] [<c013bbf3>] [<c0106d83>] 
Code: 0f 0b 8b 46 18 a9 20 00 00 00 74 02 0f 0b 8b 46 18 a9 40 00 

>>EIP; c012aeb5 <__free_pages_ok+45/1e0>   <=====
Trace; c0123e06 <remove_inode_page+16/1c>
Trace; c012b605 <__free_pages+1d/20>
Trace; c0123f1c <truncate_complete_page+44/4c>
Trace; c0124036 <truncate_list_pages+112/1a4>
Trace; c012410b <truncate_inode_pages+43/6c>
Trace; c01435ac <iput+a8/198>
Trace; c0141c88 <d_delete+4c/78>
Trace; c013bb16 <vfs_unlink+f6/12c>
Trace; c013bbf3 <sys_unlink+a7/11c>
Trace; c0106d83 <system_call+33/40>
Code;  c012aeb5 <__free_pages_ok+45/1e0>
00000000 <_EIP>:
Code;  c012aeb5 <__free_pages_ok+45/1e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012aeb7 <__free_pages_ok+47/1e0>
   2:   8b 46 18                  mov    0x18(%esi),%eax
Code;  c012aeba <__free_pages_ok+4a/1e0>
   5:   a9 20 00 00 00            test   $0x20,%eax
Code;  c012aebf <__free_pages_ok+4f/1e0>
   a:   74 02                     je     e <_EIP+0xe> c012aec3 <__free_pages_ok+53/1e0>
Code;  c012aec1 <__free_pages_ok+51/1e0>
   c:   0f 0b                     ud2a   
Code;  c012aec3 <__free_pages_ok+53/1e0>
   e:   8b 46 18                  mov    0x18(%esi),%eax
Code;  c012aec6 <__free_pages_ok+56/1e0>
  11:   a9 40 00 00 00            test   $0x40,%eax


29 warnings issued.  Results may not be reliable.


Bye,

Manfred
-- 
 /"\                        |  *  AIM: mahowi42  *  ICQ: 61597169  *
 \ /  ASCII ribbon campaign | PGP-Key available at Public Key Servers
  X   against HTML mail     | or "http://www.mahowi.de/pgp/mahowi.asc"
 / \  and postings          |  * RSA: 0xC05BC0F5 * DSS: 0x4613B5CA *
