Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313688AbSDZGzu>; Fri, 26 Apr 2002 02:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSDZGzu>; Fri, 26 Apr 2002 02:55:50 -0400
Received: from mailserver.advnet.net ([216.115.68.3]:63173 "EHLO
	mailserver.advnet.net") by vger.kernel.org with ESMTP
	id <S313688AbSDZGzY>; Fri, 26 Apr 2002 02:55:24 -0400
Message-ID: <3CC8FA17.3080507@advnet.net>
Date: Fri, 26 Apr 2002 02:56:23 -0400
From: mjh48060 <mjh48060@advnet.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020424
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: A kernel oops report
Content-Type: multipart/mixed;
 boundary="------------070301030504010909070806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070301030504010909070806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The computer seems to freeze after I've been connected to the internet 
for a while. Sometimes pppd won't terminate, either.
I hope the report helps.
- Mike


--------------070301030504010909070806
Content-Type: text/plain;
 name="aiee.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aiee.txt"

ksymoops 2.4.5 on i686 2.4.19-pre7.  Options used
     -v /usr/src/linux/vmlinux (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre7 (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/net/bsd_comp.o for module bsd_comp has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/net/ppp_async.o for module ppp_async has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/net/ppp_generic.o for module ppp_generic has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/net/slhc.o for module slhc has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/char/serial.o for module serial has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/pnp/isa-pnp.o for module isa-pnp has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/net/ipv4/netfilter/ipt_LOG.o for module ipt_LOG has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/net/ipv4/netfilter/ipt_state.o for module ipt_state has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/net/ipv4/netfilter/ip_conntrack_ftp.o for module ip_conntrack_ftp has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/net/ipv4/netfilter/ip_conntrack.o for module ip_conntrack has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/net/ipv4/netfilter/iptable_filter.o for module iptable_filter has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/net/ipv4/netfilter/ip_tables.o for module ip_tables has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/scsi/sg.o for module sg has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/usb/scanner.o for module scanner has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/usb/usb-ohci.o for module usb-ohci has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/usb/usbcore.o for module usbcore has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/char/rtc.o for module rtc has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/media/video/tuner.o for module tuner has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/media/video/tvaudio.o for module tvaudio has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/media/video/bttv.o for module bttv has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/i2c/i2c-algo-bit.o for module i2c-algo-bit has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/i2c/i2c-core.o for module i2c-core has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/media/video/videodev.o for module videodev has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/char/joystick/analog.o for module analog has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/sound/es1371.o for module es1371 has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/sound/soundcore.o for module soundcore has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/sound/ac97_codec.o for module ac97_codec has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/char/joystick/gameport.o for module gameport has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/input/joydev.o for module joydev has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/input/input.o for module input has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/video/sis/sisfb.o for module sisfb has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/video/fbcon-cfb8.o for module fbcon-cfb8 has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/video/fbcon-cfb32.o for module fbcon-cfb32 has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/video/fbcon-cfb16.o for module fbcon-cfb16 has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/block/floppy.o for module floppy has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/scsi/sr_mod.o for module sr_mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/scsi/ide-scsi.o for module ide-scsi has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/ide/ide-cd.o for module ide-cd has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/cdrom/cdrom.o for module cdrom has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/drivers/scsi/scsi_mod.o for module scsi_mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/net/appletalk/appletalk.o for module appletalk has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/net/ipx/ipx.o for module ipx has changed since load
Warning (expand_objects): object /lib/modules/2.4.19-pre7/kernel/arch/i386/kernel/apm.o for module apm has changed since load
Apr 26 02:29:13 linux003 kernel: Unable to handle kernel paging request at virtual address ffffffe9
Apr 26 02:29:13 linux003 kernel: c0200023
Apr 26 02:29:13 linux003 kernel: *pde = 00001063
Apr 26 02:29:13 linux003 kernel: Oops: 0002
Apr 26 02:29:13 linux003 kernel: CPU:    0
Apr 26 02:29:13 linux003 kernel: EIP:    0010:[<c0200023>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 26 02:29:13 linux003 kernel: EFLAGS: 00010246
Apr 26 02:29:13 linux003 kernel: eax: 00000000   ebx: cb3f46d8   ecx: 00000246   edx: cb3f4600
Apr 26 02:29:13 linux003 kernel: esi: 0000002c   edi: 00000020   ebp: c7ff36c0   esp: c2511e2c
Apr 26 02:29:13 linux003 kernel: ds: 0018   es: 0018   ss: 0018
Apr 26 02:29:13 linux003 kernel: Process kdeinit (pid: 20388, stackpage=c2511000)
Apr 26 02:29:13 linux003 kernel: Stack: c7ff36c0 c02b3808 cb3f46d8 cb3f4600 00000020 c01fecad cb3f4600 c7ff36c0 
Apr 26 02:29:13 linux003 kernel:        00000020 c7ff36c0 cb3f4600 c02b3808 ffffff95 00000001 00000246 00000000 
Apr 26 02:29:13 linux003 kernel:        976a3a7d c01f7d98 c0205fa7 cb3f4600 c7ff36c0 ca84b828 0000004c cb3f46d8 
Apr 26 02:29:13 linux003 kernel: Call Trace: [<c01fecad>] [<c01f7d98>] [<c0205fa7>] [<c01f7de1>] [<c01f8487>] 
Apr 26 02:29:13 linux003 kernel:    [<c02108dd>] [<c01dd0bd>] [<c01dd1be>] [<c0133c26>] [<c010883b>] 
Apr 26 02:29:13 linux003 kernel: Code: 00 58 e9 67 ea ff ff 50 51 52 e8 ce b9 f1 ff 5a 59 58 e9 cb 


>>EIP; c0200023 <.text.lock.tcp_input+19/36>   <=====

>>ebx; cb3f46d8 <_end+b11a3e4/fd3dd0c>
>>edx; cb3f4600 <_end+b11a30c/fd3dd0c>
>>ebp; c7ff36c0 <_end+7d193cc/fd3dd0c>
>>esp; c2511e2c <_end+2237b38/fd3dd0c>

Trace; c01fecad <tcp_rcv_established+14d/6b0>
Trace; c01f7d98 <tcp_data_wait+128/140>
Trace; c0205fa7 <tcp_v4_do_rcv+27/110>
Trace; c01f7de1 <tcp_prequeue_process+31/90>
Trace; c01f8487 <tcp_recvmsg+4b7/7f0>
Trace; c02108dd <inet_recvmsg+3d/60>
Trace; c01dd0bd <sock_recvmsg+3d/b0>
Trace; c01dd1be <sock_read+8e/a0>
Trace; c0133c26 <sys_read+96/f0>
Trace; c010883b <system_call+33/38>

Code;  c0200023 <.text.lock.tcp_input+19/36>
00000000 <_EIP>:
Code;  c0200023 <.text.lock.tcp_input+19/36>   <=====
   0:   00 58 e9                  add    %bl,0xffffffe9(%eax)   <=====
Code;  c0200026 <.text.lock.tcp_input+1c/36>
   3:   67 ea ff ff 50 51 52      addr16 ljmp $0xe852,$0x5150ffff
Code;  c020002d <.text.lock.tcp_input+23/36>
   a:   e8 
Code;  c020002e <.text.lock.tcp_input+24/36>
   b:   ce                        into   
Code;  c020002f <.text.lock.tcp_input+25/36>
   c:   b9 f1 ff 5a 59            mov    $0x595afff1,%ecx
Code;  c0200034 <.text.lock.tcp_input+2a/36>
  11:   58                        pop    %eax
Code;  c0200035 <.text.lock.tcp_input+2b/36>
  12:   e9 cb 00 00 00            jmp    e2 <_EIP+0xe2> c0200105 <tcp_cwnd_restart+95/a0>


44 warnings issued.  Results may not be reliable.
d099acc0 bsdcomp_cleanup	[bsd_comp]
d099ac90 bsdcomp_init	[bsd_comp]
d099a000 __insmod_bsd_comp_O/lib/modules/2.4.19-pre7/kernel/drivers/net/bsd_comp.o_M3CC77346_V132115	[bsd_comp]
d099a060 __insmod_bsd_comp_S.text_L3184	[bsd_comp]
d099ace0 __insmod_bsd_comp_S.rodata_L384	[bsd_comp]
d099af80 __insmod_bsd_comp_S.data_L64	[bsd_comp]
d09987a0 ppp_crc16_table_R58d54d4b	[ppp_async]
d0997000 __insmod_ppp_async_O/lib/modules/2.4.19-pre7/kernel/drivers/net/ppp_async.o_M3CC77346_V132115	[ppp_async]
d0997060 __insmod_ppp_async_S.text_L5088	[ppp_async]
d0998540 __insmod_ppp_async_S.rodata_L224	[ppp_async]
d0998740 __insmod_ppp_async_S.data_L608	[ppp_async]
d0994080 ppp_register_channel_R7d1dac95	[ppp_generic]
d09941c0 ppp_unregister_channel_R0d752837	[ppp_generic]
d0994160 ppp_channel_index_R951919b0	[ppp_generic]
d0994180 ppp_unit_number_R092e9e14	[ppp_generic]
d09937c0 ppp_input_R90a6ceda	[ppp_generic]
d0993950 ppp_input_error_R2b04c806	[ppp_generic]
d0994290 ppp_output_wakeup_Reb06c97b	[ppp_generic]
d09946e0 ppp_register_compressor_R9682e733	[ppp_generic]
d0994730 ppp_unregister_compressor_Ra1b928df	[ppp_generic]
d0995e40 all_ppp_units_Rf6e9a5cf	[ppp_generic]
d0995dbc all_channels_R532ea23f	[ppp_generic]
d0992000 __insmod_ppp_generic_O/lib/modules/2.4.19-pre7/kernel/drivers/net/ppp_generic.o_M3CC77346_V132115	[ppp_generic]
d0992060 __insmod_ppp_generic_S.text_L13424	[ppp_generic]
d09955c0 __insmod_ppp_generic_S.rodata_L960	[ppp_generic]
d0995da0 __insmod_ppp_generic_S.data_L160	[ppp_generic]
d0995e40 __insmod_ppp_generic_S.bss_L12	[ppp_generic]
d098f060 slhc_init_R2e0e927f	[slhc]
d098f1b0 slhc_free_R2894cfb0	[slhc]
d098fcd0 slhc_remember_R0bc55868	[slhc]
d098f270 slhc_compress_R76135e6c	[slhc]
d098f8d0 slhc_uncompress_R3bc1319e	[slhc]
d098fe80 slhc_toss_Rf89e3455	[slhc]
d098f000 __insmod_slhc_O/lib/modules/2.4.19-pre7/kernel/drivers/net/slhc.o_M3CC77346_V132115	[slhc]
d098f060 __insmod_slhc_S.text_L3792	[slhc]
d098ff40 __insmod_slhc_S.rodata_L416	[slhc]
d0986e90 register_serial_Ra18dc2b1	[serial]
d09870f0 unregister_serial_Rce8a3e65	[serial]
d0982000 __insmod_serial_O/lib/modules/2.4.19-pre7/kernel/drivers/char/serial.o_M3CC77341_V132115	[serial]
d0982060 __insmod_serial_S.text_L21120	[serial]
d09873e0 __insmod_serial_S.rodata_L2464	[serial]
d0988040 __insmod_serial_S.data_L17504	[serial]
d098c4a0 __insmod_serial_S.bss_L3328	[serial]
d0980ce0 isapnp_cards_R593dbfd2	[isa-pnp]
d0980ce8 isapnp_devices_R2db6fba6	[isa-pnp]
d097b550 isapnp_present_Rbf8b39e9	[isa-pnp]
d097b570 isapnp_cfg_begin_R770a0036	[isa-pnp]
d097b630 isapnp_cfg_end_R28b715a6	[isa-pnp]
d097a060 isapnp_read_byte_Re3be82b4	[isa-pnp]
d097a090 isapnp_read_word_Rbf3d7670	[isa-pnp]
d097a0d0 isapnp_read_dword_Rcfbf7247	[isa-pnp]
d097a130 isapnp_write_byte_Rda8fd495	[isa-pnp]
d097a160 isapnp_write_word_R6aed3a24	[isa-pnp]
d097a1a0 isapnp_write_dword_Rd7dc599a	[isa-pnp]
d097a2f0 isapnp_wake_Rfc4e2140	[isa-pnp]
d097a310 isapnp_device_Re00489ef	[isa-pnp]
d097a330 isapnp_activate_R2ee66b41	[isa-pnp]
d097a360 isapnp_deactivate_Re5bc3040	[isa-pnp]
d097b810 isapnp_find_card_R16fde671	[isa-pnp]
d097b850 isapnp_find_dev_Rf9d40cfa	[isa-pnp]
d097b9d0 isapnp_probe_cards_R1d966f40	[isa-pnp]
d097baa0 isapnp_probe_devs_R1262a617	[isa-pnp]
d097bb00 isapnp_activate_dev_Rb157554e	[isa-pnp]
d097d3a0 isapnp_resource_change_R09b965af	[isa-pnp]
d097d650 isapnp_register_driver_Rae332ea8	[isa-pnp]
d097d6b0 isapnp_unregister_driver_R17e86281	[isa-pnp]
d097a000 __insmod_isa-pnp_O/lib/modules/2.4.19-pre7/kernel/drivers/pnp/isa-pnp.o_M3CC77347_V132115	[isa-pnp]
d097a060 __insmod_isa-pnp_S.text_L23168	[isa-pnp]
d097fb00 __insmod_isa-pnp_S.rodata_L3360	[isa-pnp]
d0980ce0 __insmod_isa-pnp_S.data_L704	[isa-pnp]
d0980fa0 __insmod_isa-pnp_S.bss_L40	[isa-pnp]
d0972b80 __insmod_ipt_LOG_S.data_L192	[ipt_LOG]
d0972740 __insmod_ipt_LOG_S.rodata_L832	[ipt_LOG]
d0972000 __insmod_ipt_LOG_O/lib/modules/2.4.19-pre7/kernel/net/ipv4/netfilter/ipt_LOG.o_M3CC77355_V132115	[ipt_LOG]
d0972060 __insmod_ipt_LOG_S.text_L1760	[ipt_LOG]
d0970000 __insmod_ipt_state_O/lib/modules/2.4.19-pre7/kernel/net/ipv4/netfilter/ipt_state.o_M3CC77355_V132115	[ipt_state]
d0970060 __insmod_ipt_state_S.text_L176	[ipt_state]
d0970220 __insmod_ipt_state_S.data_L64	[ipt_state]
d0970110 __insmod_ipt_state_S.rodata_L4	[ipt_state]
d096ea80 ip_ftp_lock_R0a75f158	[ip_conntrack_ftp]
d096ea84 ip_conntrack_ftp_Red617569	[ip_conntrack_ftp]
d096e000 __insmod_ip_conntrack_ftp_O/lib/modules/2.4.19-pre7/kernel/net/ipv4/netfilter/ip_conntrack_ftp.o_M3CC77355_V132115	[ip_conntrack_ftp]
d096e060 __insmod_ip_conntrack_ftp_S.text_L1968	[ip_conntrack_ftp]
d096e820 __insmod_ip_conntrack_ftp_S.rodata_L192	[ip_conntrack_ftp]
d096ea80 __insmod_ip_conntrack_ftp_S.data_L108	[ip_conntrack_ftp]
d096eb00 __insmod_ip_conntrack_ftp_S.bss_L416	[ip_conntrack_ftp]
d0964530 ip_conntrack_protocol_register_R8e288131	[ip_conntrack]
d09645b0 ip_conntrack_protocol_unregister_R01939918	[ip_conntrack]
d09654f0 invert_tuplepr_R5e68d8a9	[ip_conntrack]
d0965750 ip_conntrack_alter_reply_R85dc02e5	[ip_conntrack]
d09670c4 ip_conntrack_destroyed_Ref5b77f8	[ip_conntrack]
d09649a0 ip_conntrack_get_R60c1ed6f	[ip_conntrack]
d0967040 ip_conntrack_module_Rb0361033	[ip_conntrack]
d0965840 ip_conntrack_helper_register_R1844eee6	[ip_conntrack]
d0965890 ip_conntrack_helper_unregister_R40d1f34f	[ip_conntrack]
d0965be0 ip_ct_selective_cleanup_R74c9972a	[ip_conntrack]
d0965980 ip_ct_refresh_R561efb44	[ip_conntrack]
d0965540 ip_conntrack_expect_related_Raed0cb12	[ip_conntrack]
d0965710 ip_conntrack_unexpect_related_R5963f8a1	[ip_conntrack]
d0964c30 ip_conntrack_tuple_taken_Rbe57882b	[ip_conntrack]
d09659f0 ip_ct_gather_frags_Ra5412404	[ip_conntrack]
d09670e0 ip_conntrack_htable_size_R8ef8af4c	[ip_conntrack]
d0964000 __insmod_ip_conntrack_O/lib/modules/2.4.19-pre7/kernel/net/ipv4/netfilter/ip_conntrack.o_M3CC77355_V132115	[ip_conntrack]
d0964060 __insmod_ip_conntrack_S.text_L10016	[ip_conntrack]
d09667c0 __insmod_ip_conntrack_S.rodata_L881	[ip_conntrack]
d0967040 __insmod_ip_conntrack_S.data_L1344	[ip_conntrack]
d0967580 __insmod_ip_conntrack_S.bss_L12	[ip_conntrack]
d0960000 __insmod_iptable_filter_O/lib/modules/2.4.19-pre7/kernel/net/ipv4/netfilter/iptable_filter.o_M3CC77355_V132115	[iptable_filter]
d0960360 __insmod_iptable_filter_S.data_L896	[iptable_filter]
d0960060 __insmod_iptable_filter_S.text_L368	[iptable_filter]
d09601e0 __insmod_iptable_filter_S.rodata_L96	[iptable_filter]
d095da60 ipt_register_table_Re1eafda5	[ip_tables]
d095dc20 ipt_unregister_table_Rd100f4c6	[ip_tables]
d095d960 ipt_register_match_R242ff548	[ip_tables]
d095da20 ipt_unregister_match_R64dd8e54	[ip_tables]
d095c080 ipt_do_table_R298d4c38	[ip_tables]
d095d860 ipt_register_target_Ra7ffafbb	[ip_tables]
d095d920 ipt_unregister_target_R5c6f30a9	[ip_tables]
d095c000 __insmod_ip_tables_O/lib/modules/2.4.19-pre7/kernel/net/ipv4/netfilter/ip_tables.o_M3CC77355_V132115	[ip_tables]
d095c060 __insmod_ip_tables_S.text_L9072	[ip_tables]
d095e440 __insmod_ip_tables_S.rodata_L192	[ip_tables]
d095e780 __insmod_ip_tables_S.data_L512	[ip_tables]
d0959ec0 __insmod_sg_S.data_L384	[sg]
d0959520 __insmod_sg_S.rodata_L1696	[sg]
d095a040 __insmod_sg_S.bss_L4	[sg]
d0954060 __insmod_sg_S.text_L21152	[sg]
d0959ee0 sg_big_buff	[sg]
d0954000 __insmod_sg_O/lib/modules/2.4.19-pre7/kernel/drivers/scsi/sg.o_M3CC77347_V132115	[sg]
d0950060 __insmod_scanner_S.text_L3616	[scanner]
d09518a0 __insmod_scanner_S.data_L2208	[scanner]
d0950d80 usb_scanner_exit	[scanner]
d0950d90 usb_scanner_init	[scanner]
d0950000 __insmod_scanner_O/lib/modules/2.4.19-pre7/kernel/drivers/usb/scanner.o_M3CC77348_V132115	[scanner]
d0950ec0 __insmod_scanner_S.rodata_L2208	[scanner]
d094a500 __insmod_usb-ohci_S.data_L224	[usb-ohci]
d0949ce0 __insmod_usb-ohci_S.rodata_L1792	[usb-ohci]
d0946060 __insmod_usb-ohci_S.text_L15472	[usb-ohci]
d094a54c sohci_device_operations	[usb-ohci]
d0946000 __insmod_usb-ohci_O/lib/modules/2.4.19-pre7/kernel/drivers/usb/usb-ohci.o_M3CC77348_V132115	[usb-ohci]
d09372c0 usb_ifnum_to_if_R6123fa43	[usbcore]
d0937310 usb_epnum_to_ep_desc_Rf9a2189c	[usbcore]
d0937060 usb_register_R26bf6a8f	[usbcore]
d0937230 usb_deregister_R4b1cd027	[usbcore]
d0937100 usb_scan_devices_Rca4f6301	[usbcore]
d09376f0 usb_alloc_bus_Re268b474	[usbcore]
d0937770 usb_free_bus_R28d7fedb	[usbcore]
d0937790 usb_register_bus_R728f1a68	[usbcore]
d0937880 usb_deregister_bus_R1c036dcc	[usbcore]
d0937f40 usb_alloc_dev_Rb707f6d9	[usbcore]
d0938000 usb_free_dev_Rf56d6855	[usbcore]
d0938040 usb_inc_dev_use_R2dbd9a91	[usbcore]
d0937960 usb_driver_claim_interface_R15f7dde1	[usbcore]
d0937990 usb_interface_claimed_R1dbb7935	[usbcore]
d09379b0 usb_driver_release_interface_R6bd4b4c2	[usbcore]
d09379d0 usb_match_id_R1a96f88a	[usbcore]
d0938df0 usb_root_hub_string_Ra68718f0	[usbcore]
d0939c80 usb_new_device_R4825ad10	[usbcore]
d093b9a0 usb_reset_device_Rfb22676a	[usbcore]
d0939000 usb_connect_R6d7ed738	[usbcore]
d0938ee0 usb_disconnect_R4471192d	[usbcore]
d0937590 usb_check_bandwidth_Rae6fb1e3	[usbcore]
d0937630 usb_claim_bandwidth_R9de02aa8	[usbcore]
d0937670 usb_release_bandwidth_Ra6d00337	[usbcore]
d0939140 usb_set_address_R41f9b07e	[usbcore]
d0939180 usb_get_descriptor_Rd48ae013	[usbcore]
d0939240 usb_get_class_descriptor_R514a7711	[usbcore]
d0938e70 __usb_get_extra_descriptor_R9924c496	[usbcore]
d0939300 usb_get_device_descriptor_R2effafd7	[usbcore]
d09392a0 usb_get_string_Rdeaade17	[usbcore]
d0939b50 usb_string_R528ac9fd	[usbcore]
d0939370 usb_get_protocol_R2b12db63	[usbcore]
d09393c0 usb_set_protocol_R5eee10a1	[usbcore]
d09397d0 usb_get_report_R181b8cac	[usbcore]
d0939830 usb_set_report_R963196c2	[usbcore]
d0939400 usb_set_idle_Rcb958dde	[usbcore]
d0939520 usb_clear_halt_Rc8ea807b	[usbcore]
d0939660 usb_set_interface_Rf2956b8d	[usbcore]
d0939890 usb_get_configuration_Re27044b0	[usbcore]
d0939700 usb_set_configuration_R039ae827	[usbcore]
d0939320 usb_get_status_R0928bf7f	[usbcore]
d09384c0 usb_get_current_frame_number_R753ee4ff	[usbcore]
d0938050 usb_alloc_urb_Rd4e2900c	[usbcore]
d09380c0 usb_free_urb_Rf0d063e1	[usbcore]
d09380e0 usb_submit_urb_Raf72ba7b	[usbcore]
d0938120 usb_unlink_urb_Rbc21f3db	[usbcore]
d09383b0 usb_control_msg_R61c2cbb2	[usbcore]
d0938450 usb_bulk_msg_R2efdb130	[usbcore]
d0944af4 usb_devfs_handle_Re9c5f87f	[usbcore]
d0940390 usb_hcd_pci_probe_R27bcd21e	[usbcore]
d0940790 usb_hcd_pci_remove_R788581b3	[usbcore]
d09408f0 usb_hcd_pci_suspend_R5520249a	[usbcore]
d0940940 usb_hcd_pci_resume_R38eb0532	[usbcore]
d0941170 usb_hcd_giveback_urb_R4e1240f1	[usbcore]
d0937000 __insmod_usbcore_O/lib/modules/2.4.19-pre7/kernel/drivers/usb/usbcore.o_M3CC77348_V132115	[usbcore]
d0937060 __insmod_usbcore_S.text_L41312	[usbcore]
d09412e0 __insmod_usbcore_S.rodata_L10368	[usbcore]
d09445a0 __insmod_usbcore_S.data_L1332	[usbcore]
d0944ae0 __insmod_usbcore_S.bss_L96	[usbcore]
d0934000 __insmod_rtc_O/lib/modules/2.4.19-pre7/kernel/drivers/char/rtc.o_M3CC77341_V132115	[rtc]
d0934060 __insmod_rtc_S.text_L4336	[rtc]
d09351c0 __insmod_rtc_S.rodata_L544	[rtc]
d0935540 __insmod_rtc_S.data_L128	[rtc]
d09355c0 __insmod_rtc_S.bss_L24	[rtc]
d0930000 __insmod_tuner_O/lib/modules/2.4.19-pre7/kernel/drivers/media/video/tuner.o_M3CC77345_V132115	[tuner]
d0930060 __insmod_tuner_S.text_L4512	[tuner]
d0931200 __insmod_tuner_S.rodata_L2656	[tuner]
d0931d80 __insmod_tuner_S.data_L832	[tuner]
d09320c0 __insmod_tuner_S.bss_L4	[tuner]
d092e31c tda9873	[tvaudio]
d092e314 tda9850	[tvaudio]
d092e318 tda9855	[tvaudio]
d092e324 tea6300	[tvaudio]
d092e320 tda9874a	[tvaudio]
d092e32c pic16c54	[tvaudio]
d092c060 __insmod_tvaudio_S.text_L5728	[tvaudio]
d092e310 tda9840	[tvaudio]
d092c000 __insmod_tvaudio_O/lib/modules/2.4.19-pre7/kernel/drivers/media/video/tvaudio.o_M3CC77345_V132115	[tvaudio]
d092e328 tea6420	[tvaudio]
d092d6c0 __insmod_tvaudio_S.rodata_L1920	[tvaudio]
d092e30c tda8425	[tvaudio]
d092dfe0 __insmod_tvaudio_S.data_L3072	[tvaudio]
d090f520 bttv_get_cardinfo_R48320158	[bttv]
d090f560 bttv_get_id_R294b5550	[bttv]
d090f590 bttv_gpio_enable_R11dc4b6d	[bttv]
d090f5f0 bttv_read_gpio_Rbcf2d2fb	[bttv]
d090f640 bttv_write_gpio_R8ecf4acc	[bttv]
d090f6b0 bttv_get_gpio_queue_Rad4c505f	[bttv]
d0907000 __insmod_bttv_O/lib/modules/2.4.19-pre7/kernel/drivers/media/video/bttv.o_M3CC77345_V132115	[bttv]
d0907060 __insmod_bttv_S.text_L35664	[bttv]
d090ff00 __insmod_bttv_S.rodata_L9408	[bttv]
d09129a0 __insmod_bttv_S.data_L14048	[bttv]
d0916080 __insmod_bttv_S.bss_L5952	[bttv]
d09050f0 i2c_bit_add_bus_R8c3bc60e	[i2c-algo-bit]
d09051f0 i2c_bit_del_bus_R92b18f49	[i2c-algo-bit]
d0904000 __insmod_i2c-algo-bit_O/lib/modules/2.4.19-pre7/kernel/drivers/i2c/i2c-algo-bit.o_M3CC77343_V132115	[i2c-algo-bit]
d0904060 __insmod_i2c-algo-bit_S.text_L4608	[i2c-algo-bit]
d0905260 __insmod_i2c-algo-bit_S.rodata_L2016	[i2c-algo-bit]
d0905bc0 __insmod_i2c-algo-bit_S.data_L64	[i2c-algo-bit]
d0905c00 __insmod_i2c-algo-bit_S.bss_L12	[i2c-algo-bit]
d08ff060 i2c_add_adapter_Rd50a523b	[i2c-core]
d08ff210 i2c_del_adapter_R97e1c952	[i2c-core]
d08ff3d0 i2c_add_driver_R4f23b208	[i2c-core]
d08ff4c0 i2c_del_driver_Rff1b8c74	[i2c-core]
d08ff700 i2c_attach_client_Rf9e63ce2	[i2c-core]
d08ff7c0 i2c_detach_client_R9677bd52	[i2c-core]
d08ff870 i2c_inc_use_client_Rdca6b454	[i2c-core]
d08ff8a0 i2c_dec_use_client_R875e0829	[i2c-core]
d08ff8d0 i2c_get_client_R7eee76d6	[i2c-core]
d08ff9e0 i2c_use_client_R9f6debd8	[i2c-core]
d08ffa20 i2c_release_client_R17368932	[i2c-core]
d08ff6d0 i2c_check_addr_R3ff49108	[i2c-core]
d08ffee0 i2c_master_send_R933abeec	[i2c-core]
d08fff90 i2c_master_recv_R7f9cffd8	[i2c-core]
d0900070 i2c_control_Ra72a2399	[i2c-core]
d08ffe60 i2c_transfer_R7c4e2b41	[i2c-core]
d0900460 i2c_adapter_id_R83500f56	[i2c-core]
d09000e0 i2c_probe_R53db42d9	[i2c-core]
d0900a90 i2c_smbus_xfer_R7281dd66	[i2c-core]
d0900490 i2c_smbus_write_quick_Raa684b81	[i2c-core]
d09004c0 i2c_smbus_read_byte_R86949866	[i2c-core]
d0900500 i2c_smbus_write_byte_R94669bef	[i2c-core]
d0900530 i2c_smbus_read_byte_data_Red52ecf9	[i2c-core]
d0900570 i2c_smbus_write_byte_data_R3936b756	[i2c-core]
d09005b0 i2c_smbus_read_word_data_R4bbcd408	[i2c-core]
d09005f0 i2c_smbus_write_word_data_R69e6c9e5	[i2c-core]
d0900630 i2c_smbus_process_call_Rb47f8305	[i2c-core]
d0900680 i2c_smbus_read_block_data_R05e3bfac	[i2c-core]
d09006f0 i2c_smbus_write_block_data_Rb02f65a5	[i2c-core]
d0900b30 i2c_get_functionality_R2e5c3fbc	[i2c-core]
d0900b50 i2c_check_functionality_R4a766bf4	[i2c-core]
d08ff000 __insmod_i2c-core_O/lib/modules/2.4.19-pre7/kernel/drivers/i2c/i2c-core.o_M3CC77343_V132115	[i2c-core]
d08ff060 __insmod_i2c-core_S.text_L7440	[i2c-core]
d0900d80 __insmod_i2c-core_S.rodata_L3392	[i2c-core]
d0902140 __insmod_i2c-core_S.data_L128	[i2c-core]
d09021c0 __insmod_i2c-core_S.bss_L256	[i2c-core]
d08fd218 video_proc_entry_R0f00d622	[videodev]
d08fc990 video_register_device_Rba57cb7c	[videodev]
d08fcb60 video_unregister_device_Rd6324eeb	[videodev]
d08fc0e0 video_devdata_R530e7ef5	[videodev]
d08fc3d0 video_generic_ioctl_R04c45710	[videodev]
d08fc530 video_exclusive_open_R4f4eab07	[videodev]
d08fc570 video_exclusive_release_Ra069e532	[videodev]
d08fc000 __insmod_videodev_O/lib/modules/2.4.19-pre7/kernel/drivers/media/video/videodev.o_M3CC77345_V132115	[videodev]
d08fc060 __insmod_videodev_S.text_L3184	[videodev]
d08fcf40 __insmod_videodev_S.rodata_L704	[videodev]
d08fd200 __insmod_videodev_S.data_L160	[videodev]
d08fd2a0 __insmod_videodev_S.bss_L1024	[videodev]
d08fa880 __insmod_analog_S.rodata_L544	[analog]
d08face0 __insmod_analog_S.bss_L128	[analog]
d08f9000 __insmod_analog_O/lib/modules/2.4.19-pre7/kernel/drivers/char/joystick/analog.o_M3CC77342_V132115	[analog]
d08fa870 analog_exit	[analog]
d08fac5c analog_types	[analog]
d08fa850 analog_init	[analog]
d08f9060 __insmod_analog_S.text_L6176	[analog]
d08fac00 __insmod_analog_S.data_L196	[analog]
d08f6e80 __insmod_es1371_S.rodata_L1312	[es1371]
d08f1000 __insmod_es1371_O/lib/modules/2.4.19-pre7/kernel/drivers/sound/es1371.o_M3CC77348_V132115	[es1371]
d08f76c0 __insmod_es1371_S.data_L768	[es1371]
d08f1060 __insmod_es1371_S.text_L23616	[es1371]
d08ef280 register_sound_special_R811a2804	[soundcore]
d08ef340 register_sound_mixer_Rfccdf515	[soundcore]
d08ef370 register_sound_midi_R78e0a062	[soundcore]
d08ef3a0 register_sound_dsp_R48569318	[soundcore]
d08ef3d0 register_sound_synth_R201f50dc	[soundcore]
d08ef400 unregister_sound_special_R99c95fa5	[soundcore]
d08ef420 unregister_sound_mixer_R7afc9d8a	[soundcore]
d08ef440 unregister_sound_midi_Rfdab6de3	[soundcore]
d08ef460 unregister_sound_dsp_Rcd083b10	[soundcore]
d08ef480 unregister_sound_synth_Rdf03108a	[soundcore]
d08ef820 mod_firmware_load_R39e3dd23	[soundcore]
d08ef000 __insmod_soundcore_O/lib/modules/2.4.19-pre7/kernel/drivers/sound/soundcore.o_M3CC77348_V132115	[soundcore]
d08ef060 __insmod_soundcore_S.text_L2032	[soundcore]
d08ef860 __insmod_soundcore_S.rodata_L480	[soundcore]
d08efd80 __insmod_soundcore_S.data_L128	[soundcore]
d08efe00 __insmod_soundcore_S.bss_L100	[soundcore]
d08eb8a0 ac97_read_proc_Rbae4da72	[ac97_codec]
d08ebc10 ac97_probe_codec_R84601c2b	[ac97_codec]
d08ec110 ac97_set_dac_rate_R42924aaa	[ac97_codec]
d08ec230 ac97_set_adc_rate_R5307368c	[ac97_codec]
d08ec2a0 ac97_save_state_R32a87bac	[ac97_codec]
d08ec2b0 ac97_restore_state_R9cc8c30e	[ac97_codec]
d08eb000 __insmod_ac97_codec_O/lib/modules/2.4.19-pre7/kernel/drivers/sound/ac97_codec.o_M3CC77348_V132115	[ac97_codec]
d08eb060 __insmod_ac97_codec_S.text_L4752	[ac97_codec]
d08ec360 __insmod_ac97_codec_S.rodata_L3456	[ac97_codec]
d08ed340 __insmod_ac97_codec_S.data_L704	[ac97_codec]
d08e91d0 gameport_register_port_R98692e58	[gameport]
d08e9210 gameport_unregister_port_R70daab68	[gameport]
d08e9260 gameport_register_device_R274f9f7b	[gameport]
d08e92a0 gameport_unregister_device_Rf205c758	[gameport]
d08e9300 gameport_open_Ra9b0d2ad	[gameport]
d08e9340 gameport_close_R9d5c376e	[gameport]
d08e91b0 gameport_rescan_Rfdd49e99	[gameport]
d08e9360 gameport_cooked_read_Rbde36ba8	[gameport]
d08e9000 __insmod_gameport_O/lib/modules/2.4.19-pre7/kernel/drivers/char/joystick/gameport.o_M3CC77342_V132115	[gameport]
d08e9060 __insmod_gameport_S.text_L816	[gameport]
d08e9610 __insmod_gameport_S.bss_L12	[gameport]
d08e79c0 __insmod_joydev_S.data_L128	[joydev]
d08e7860 __insmod_joydev_S.rodata_L64	[joydev]
d08e6060 __insmod_joydev_S.text_L5200	[joydev]
d08e6000 __insmod_joydev_O/lib/modules/2.4.19-pre7/kernel/drivers/input/joydev.o_M3CC77344_V132115	[joydev]
d08e7a40 __insmod_joydev_S.bss_L128	[joydev]
d08e4490 input_register_device_Red26d6c8	[input]
d08e4580 input_unregister_device_R2a85ef86	[input]
d08e4610 input_register_handler_R90e6e1ad	[input]
d08e4670 input_unregister_handler_Ra583121e	[input]
d08e47c0 input_register_minor_Re986ad09	[input]
d08e4810 input_unregister_minor_R3827a32e	[input]
d08e43b0 input_open_device_R799c1d08	[input]
d08e43e0 input_close_device_R8e0a8527	[input]
d08e4060 input_event_Rc10da7ce	[input]
d08e4000 __insmod_input_O/lib/modules/2.4.19-pre7/kernel/drivers/input/input.o_M3CC77344_V132115	[input]
d08e4060 __insmod_input_S.text_L2112	[input]
d08e4b60 __insmod_input_S.rodata_L288	[input]
d08e4c80 __insmod_input_S.data_L96	[input]
d08e4ce0 __insmod_input_S.bss_L128	[input]
d00a8580 sis_malloc_Ra3329ed5	[sisfb]
d00a85c0 sis_free_Rced25333	[sisfb]
d00a7320 sis_dispinfo_R601b25a5	[sisfb]
d00bb920 ivideo_R261ffb2c	[sisfb]
d00a7000 __insmod_sisfb_O/lib/modules/2.4.19-pre7/kernel/drivers/video/sis/sisfb.o_M3CC77349_V132115	[sisfb]
d00a7060 __insmod_sisfb_S.text_L64848	[sisfb]
d00b6dc0 __insmod_sisfb_S.rodata_L4288	[sisfb]
d00b8020 __insmod_sisfb_S.data_L14592	[sisfb]
d00bb920 __insmod_sisfb_S.bss_L4116	[sisfb]
d00a5d60 fbcon_cfb8_Rd2bf66c6	[fbcon-cfb8]
d00a5060 fbcon_cfb8_setup_R695d9503	[fbcon-cfb8]
d00a5090 fbcon_cfb8_bmove_Rc8b5e852	[fbcon-cfb8]
d00a5300 fbcon_cfb8_clear_R79c01d5f	[fbcon-cfb8]
d00a53d0 fbcon_cfb8_putc_R8c6fd90b	[fbcon-cfb8]
d00a5620 fbcon_cfb8_putcs_R91934bab	[fbcon-cfb8]
d00a58f0 fbcon_cfb8_revc_R2ede7906	[fbcon-cfb8]
d00a5990 fbcon_cfb8_clear_margins_Re213bfc0	[fbcon-cfb8]
d00a5000 __insmod_fbcon-cfb8_O/lib/modules/2.4.19-pre7/kernel/drivers/video/fbcon-cfb8.o_M3CC77349_V132115	[fbcon-cfb8]
d00a5060 __insmod_fbcon-cfb8_S.text_L2608	[fbcon-cfb8]
d00a5aa0 __insmod_fbcon-cfb8_S.rodata_L64	[fbcon-cfb8]
d00a5d20 __insmod_fbcon-cfb8_S.data_L128	[fbcon-cfb8]
d00a3ec0 fbcon_cfb32_Ref188894	[fbcon-cfb32]
d00a3060 fbcon_cfb32_setup_R53e217c0	[fbcon-cfb32]
d00a3090 fbcon_cfb32_bmove_R86aa6797	[fbcon-cfb32]
d00a3320 fbcon_cfb32_clear_R91782423	[fbcon-cfb32]
d00a34e0 fbcon_cfb32_putc_Rc27056ce	[fbcon-cfb32]
d00a36e0 fbcon_cfb32_putcs_Rf1b3d6f2	[fbcon-cfb32]
d00a3960 fbcon_cfb32_revc_R77b5aab2	[fbcon-cfb32]
d00a3a50 fbcon_cfb32_clear_margins_Rbbe0d44a	[fbcon-cfb32]
d00a3000 __insmod_fbcon-cfb32_O/lib/modules/2.4.19-pre7/kernel/drivers/video/fbcon-cfb32.o_M3CC77349_V132115	[fbcon-cfb32]
d00a3060 __insmod_fbcon-cfb32_S.text_L3024	[fbcon-cfb32]
d00a3c40 __insmod_fbcon-cfb32_S.rodata_L64	[fbcon-cfb32]
d00a3ec0 __insmod_fbcon-cfb32_S.data_L64	[fbcon-cfb32]
d00a1fc0 fbcon_cfb16_R88f099fe	[fbcon-cfb16]
d00a1060 fbcon_cfb16_setup_R38e51540	[fbcon-cfb16]
d00a1090 fbcon_cfb16_bmove_Rd47cc183	[fbcon-cfb16]
d00a1310 fbcon_cfb16_clear_Raa1d23dd	[fbcon-cfb16]
d00a14d0 fbcon_cfb16_putc_R90a6f0da	[fbcon-cfb16]
d00a1760 fbcon_cfb16_putcs_R4ab766ba	[fbcon-cfb16]
d00a1a70 fbcon_cfb16_revc_Red419e34	[fbcon-cfb16]
d00a1b20 fbcon_cfb16_clear_margins_R56b1f4e9	[fbcon-cfb16]
d00a1000 __insmod_fbcon-cfb16_O/lib/modules/2.4.19-pre7/kernel/drivers/video/fbcon-cfb16.o_M3CC77349_V132115	[fbcon-cfb16]
d00a1060 __insmod_fbcon-cfb16_S.text_L3248	[fbcon-cfb16]
d00a1d20 __insmod_fbcon-cfb16_S.rodata_L64	[fbcon-cfb16]
d00a1fa0 __insmod_fbcon-cfb16_S.data_L96	[fbcon-cfb16]
d0094000 __insmod_floppy_O/lib/modules/2.4.19-pre7/kernel/drivers/block/floppy.o_M3CC77340_V132115	[floppy]
d0094060 __insmod_floppy_S.text_L29824	[floppy]
d009b560 __insmod_floppy_S.rodata_L8288	[floppy]
d009d760 __insmod_floppy_S.data_L2752	[floppy]
d009e220 __insmod_floppy_S.bss_L4416	[floppy]
d0091bf0 sr_reset	[sr_mod]
d0092250 sr_vendor_init	[sr_mod]
d00919d0 sr_lock_door	[sr_mod]
d0091950 sr_tray_move	[sr_mod]
d0092360 sr_cd_check	[sr_mod]
d0092160 sr_dev_ioctl	[sr_mod]
d0092d80 __insmod_sr_mod_S.data_L228	[sr_mod]
d0090ce0 get_capabilities	[sr_mod]
d0090060 __insmod_sr_mod_S.text_L9424	[sr_mod]
d0091b50 sr_get_mcn	[sr_mod]
d0092270 sr_set_blocklength	[sr_mod]
d0090000 __insmod_sr_mod_O/lib/modules/2.4.19-pre7/kernel/drivers/scsi/sr_mod.o_M3CC77347_V132115	[sr_mod]
d0091fe0 sr_read_sector	[sr_mod]
d00915d0 sr_do_ioctl	[sr_mod]
d0091b10 sr_get_last_session	[sr_mod]
d0092e20 sr_bdops	[sr_mod]
d0091a50 sr_disk_status	[sr_mod]
d0091cc0 sr_audio_ioctl	[sr_mod]
d0092e64 scsi_CDs	[sr_mod]
d0092e64 __insmod_sr_mod_S.bss_L20	[sr_mod]
d0091a10 sr_drive_status	[sr_mod]
d00920e0 sr_is_xa	[sr_mod]
d0091ef0 sr_read_cd	[sr_mod]
d0091c10 sr_select_speed	[sr_mod]
d0090ab0 get_sectorsize	[sr_mod]
d0092560 __insmod_sr_mod_S.rodata_L1312	[sr_mod]
d008d000 __insmod_ide-scsi_O/lib/modules/2.4.19-pre7/kernel/drivers/scsi/ide-scsi.o_M3CC77347_V132115	[ide-scsi]
d008dd00 idescsi_detect	[ide-scsi]
d008de50 idescsi_queue	[ide-scsi]
d008d060 __insmod_ide-scsi_S.text_L5328	[ide-scsi]
d008ddb0 idescsi_info	[ide-scsi]
d008e3c0 idescsi_reset	[ide-scsi]
d008dd70 idescsi_release	[ide-scsi]
d008e540 __insmod_ide-scsi_S.rodata_L1344	[ide-scsi]
d008e3d0 idescsi_bios	[ide-scsi]
d008db70 idescsi_reinit	[ide-scsi]
d008e3b0 idescsi_abort	[ide-scsi]
d008ec80 __insmod_ide-scsi_S.data_L256	[ide-scsi]
d008ed80 __insmod_ide-scsi_S.bss_L96	[ide-scsi]
d008ddc0 idescsi_ioctl	[ide-scsi]
d008db80 idescsi_init	[ide-scsi]
d00868d0 ide_cdrom_reinit	[ide-cd]
d0086c80 __insmod_ide-cd_S.rodata_L11040	[ide-cd]
d0086c90 packet_command_texts	[ide-cd]
d00870e0 sense_key_texts	[ide-cd]
d0086a80 ide_cdrom_init	[ide-cd]
d0089980 __insmod_ide-cd_S.data_L224	[ide-cd]
d00871b8 sense_data_texts	[ide-cd]
d0089a40 ignore	[ide-cd]
d0083000 __insmod_ide-cd_O/lib/modules/2.4.19-pre7/kernel/drivers/ide/ide-cd.o_M3CC77343_V132115	[ide-cd]
d0083060 __insmod_ide-cd_S.text_L15296	[ide-cd]
d007dd10 cdrom_get_disc_info_R6bc3dbd6	[cdrom]
d007dc60 cdrom_get_track_info_R6d600868	[cdrom]
d007dec0 cdrom_get_next_writable_R36914bae	[cdrom]
d007dda0 cdrom_get_last_written_R78263467	[cdrom]
d007ad50 cdrom_count_tracks_Re746a53b	[cdrom]
d007a060 register_cdrom_R5a61744f	[cdrom]
d007a2e0 unregister_cdrom_R703d3575	[cdrom]
d007a3c0 cdrom_open_Rd99185d2	[cdrom]
d007a8d0 cdrom_release_R912ffc76	[cdrom]
d007bc20 cdrom_ioctl_R5ec2d3c6	[cdrom]
d007ad10 cdrom_media_changed_R0054e9fe	[cdrom]
d007aac0 cdrom_number_of_slots_R5d8f3672	[cdrom]
d007abd0 cdrom_select_disc_R8dcbf2fd	[cdrom]
d007b990 cdrom_mode_select_Rcf102018	[cdrom]
d007b920 cdrom_mode_sense_R441c9253	[cdrom]
d007af40 init_cdrom_command_Rfacde1b5	[cdrom]
d007a3a0 cdrom_find_device_R57baf788	[cdrom]
d007a000 __insmod_cdrom_O/lib/modules/2.4.19-pre7/kernel/drivers/cdrom/cdrom.o_M3CC77341_V132115	[cdrom]
d007a060 __insmod_cdrom_S.text_L18224	[cdrom]
d007eaa0 __insmod_cdrom_S.rodata_L6752	[cdrom]
d0080be0 __insmod_cdrom_S.data_L576	[cdrom]
d0080e20 __insmod_cdrom_S.bss_L1056	[cdrom]
d006ce00 scsi_register_module_Rfa20b7b0	[scsi_mod]
d006ce60 scsi_unregister_module_R81d85a75	[scsi_mod]
d0073c20 scsi_free_R475dddfa	[scsi_mod]
d0073b60 scsi_malloc_R1cce3f92	[scsi_mod]
d006d440 scsi_register_R75c0a64b	[scsi_mod]
d006d370 scsi_unregister_Rb694e267	[scsi_mod]
d006e5a0 scsicam_bios_param_R05be8249	[scsi_mod]
d006e6b0 scsi_partsize_R55805ec6	[scsi_mod]
d006b140 scsi_allocate_device_R1871af9d	[scsi_mod]
d006b980 scsi_do_cmd_Rca1d33b9	[scsi_mod]
d0075000 scsi_command_size_R9b05ea5c	[scsi_mod]
d006ddd0 scsi_ioctl_Rfb943115	[scsi_mod]
d006e1b0 print_command_R528232e7	[scsi_mod]
d006e410 print_sense_R9d72f5cd	[scsi_mod]
d006e440 print_req_sense_Re52b6c95	[scsi_mod]
d006e460 print_msg_R8cc5ae07	[scsi_mod]
d006e210 print_status_Re4c08ccd	[scsi_mod]
d0077b1c scsi_dma_free_sectors_Re930b3cb	[scsi_mod]
d006e160 kernel_scsi_ioctl_Rda9b10fd	[scsi_mod]
d0077b20 scsi_need_isa_buffer_Re22bca98	[scsi_mod]
d006b3b0 scsi_release_command_Rada2c105	[scsi_mod]
d006e520 print_Scsi_Cmnd_R9f7e40e0	[scsi_mod]
d006ef90 scsi_block_when_processing_errors_R9cefb000	[scsi_mod]
d0070dd0 scsi_mark_host_reset_Ra6a53238	[scsi_mod]
d006d970 scsi_ioctl_send_command_R7546103e	[scsi_mod]
d006b0b0 scsi_allocate_request_R272586c3	[scsi_mod]
d006b110 scsi_release_request_Rdd4364b3	[scsi_mod]
d006b660 scsi_wait_req_Rd47dd9ae	[scsi_mod]
d006b720 scsi_do_req_R0a1a90a9	[scsi_mod]
d0071ee0 scsi_report_bus_reset_Rbd56ea4c	[scsi_mod]
d0071ea0 scsi_block_requests_Rdcbb3be2	[scsi_mod]
d0071eb0 scsi_unblock_requests_R2635e94b	[scsi_mod]
d006d080 scsi_get_host_dev_Rf44af168	[scsi_mod]
d006d100 scsi_free_host_dev_Rab716484	[scsi_mod]
d006f480 scsi_sleep_R35962bf8	[scsi_mod]
d006ec80 proc_print_scsidevice_Rf4f6b37c	[scsi_mod]
d0078100 proc_scsi_R325b9726	[scsi_mod]
d00717c0 scsi_io_completion_R320cd3f4	[scsi_mod]
d00716e0 scsi_end_request_Rbd114846	[scsi_mod]
d0071f10 scsi_register_blocked_host_R15e4da84	[scsi_mod]
d0071f20 scsi_deregister_blocked_host_Raad8892b	[scsi_mod]
d006d150 scsi_reset_provider_R4d140700	[scsi_mod]
d0078128 scsi_hostlist_R5e1545a9	[scsi_mod]
d0078130 scsi_hosts_R82665707	[scsi_mod]
d007812c scsi_devicelist_R17103e4b	[scsi_mod]
d0075020 scsi_device_types_Rd54b74ac	[scsi_mod]
d006eea0 scsi_add_timer_Rb68ea3c3	[scsi_mod]
d006eef0 scsi_delete_timer_R68ca93f7	[scsi_mod]
d006b000 __insmod_scsi_mod_O/lib/modules/2.4.19-pre7/kernel/drivers/scsi/scsi_mod.o_M3CC77347_V132115	[scsi_mod]
d006b060 __insmod_scsi_mod_S.text_L40688	[scsi_mod]
d0075000 __insmod_scsi_mod_S.rodata_L8640	[scsi_mod]
d0077af0 __insmod_scsi_mod_S.data_L1548	[scsi_mod]
d00780fc __insmod_scsi_mod_S.bss_L64	[scsi_mod]
d00219d0 aarp_send_ddp_Reabf87b8	[appletalk]
d0022e10 atrtr_get_dev_Rf1f7c8f8	[appletalk]
d0022c20 atalk_find_dev_addr_R1ec03760	[appletalk]
d0021000 __insmod_appletalk_O/lib/modules/2.4.19-pre7/kernel/net/appletalk/appletalk.o_M3CC77354_V132115	[appletalk]
d0021060 __insmod_appletalk_S.text_L15904	[appletalk]
d0024f00 __insmod_appletalk_S.rodata_L1590	[appletalk]
d0025760 __insmod_appletalk_S.data_L652	[appletalk]
d0025a00 __insmod_appletalk_S.bss_L268	[appletalk]
d001de10 ipxrtr_route_skb_Rfcfd7423	[ipx]
d001f1a0 ipx_if_offset_R08de4f2c	[ipx]
d001c170 ipx_remove_socket_R1d2c4381	[ipx]
d001f030 ipx_register_spx_Rc369b89d	[ipx]
d001f070 ipx_unregister_spx_Rb5e39e64	[ipx]
d001c000 __insmod_ipx_O/lib/modules/2.4.19-pre7/kernel/net/ipx/ipx.o_M3CC77355_V132115	[ipx]
d001c060 __insmod_ipx_S.text_L13248	[ipx]
d001f500 __insmod_ipx_S.rodata_L1055	[ipx]
d001fba0 __insmod_ipx_S.data_L584	[ipx]
d001fde8 __insmod_ipx_S.bss_L44	[ipx]
d0018000 __insmod_apm_O/lib/modules/2.4.19-pre7/kernel/arch/i386/kernel/apm.o_M3CC77357_V132115	[apm]
d0018060 __insmod_apm_S.text_L6112	[apm]
d00198a0 __insmod_apm_S.rodata_L2304	[apm]
d001a300 __insmod_apm_S.data_L224	[apm]
d001a3e0 __insmod_apm_S.bss_L104	[apm]
c0106e30 machine_real_restart_R3da1b07a
c0106d80 default_idle_R92897e3d
c02aa1a0 drive_info_R744aa133
c0255480 boot_cpu_data_R0657d037
c02a9e68 EISA_bus_R7413793a
c02a9e6c MCA_bus_Rf48a2c4c
c0114580 __verify_write_R203afbeb
c01072c0 dump_thread_Rae90b20c
c010e6d0 dump_fpu_Rf7e7d3e6
c010e770 dump_extended_fpu_Ra9c2ac9b
c0114de0 __ioremap_R9eac042a
c0114ec0 iounmap_R5fb196d4
c0109cb0 enable_irq_Rfcec0987
c0109c50 disable_irq_R3ce4ca6f
c010a340 disable_irq_nosync_R27bbf221
c010a010 probe_irq_mask_R360b1afe
c01070d0 kernel_thread_R7e9ebb05
c02a99e4 pm_idle_Rf890fe7f
c02a99e8 pm_power_off_R60a32ea9
c010d2b0 get_cmos_time_Rb31ddfb4
c02a9ec0 apm_info_R50db8be5
c010022c gdt_R455fbf86
c0104000 empty_zero_page_R84daabab
c01077ac __down_failed
c01077b8 __down_failed_interruptible
c01077c4 __down_failed_trylock
c01077d0 __up_wakeup
c0218a18 csum_partial_copy_generic_Re8aa9a96
c0218b90 __udelay_R9e7d6bd0
c0218b60 __delay_R466c14a7
c0218bb0 __const_udelay_Reae3dfd6
c0218de0 __get_user_1
c0218df4 __get_user_2
c0218e10 __get_user_4
c0219290 strtok_Ree9c1bd4
c0219250 strpbrk_R9a1dfd65
c0218e90 strstr_R1e6d26a8
c0218cc0 strncpy_from_user_R24428be5
c0218c90 __strncpy_from_user_Rc003c637
c0218d10 clear_user_R7aec9089
c0218d50 __clear_user_Rf3341268
c0218c30 __generic_copy_from_user_R116166aa
c0218be0 __generic_copy_to_user_Rd523fdd3
c0218d80 strnlen_user_Rbcc308bb
c010dc40 pci_alloc_consistent_R33390bf1
c010dcb0 pci_free_consistent_Rb2748b28
c0110c70 pcibios_penalize_isa_irq_R5211c8bf
c0255540 pci_mem_start_R3da171f9
c010fcd0 pcibios_set_irq_routing_R0fe2bbb8
c010fb90 pcibios_get_irq_routing_table_R294a76e5
c0218ed0 _mmx_memcpy_R15670e2d
c0219120 mmx_clear_page_Rd0c312ff
c0219170 mmx_copy_page_Recb52bbc
c01139c0 IO_APIC_get_PCI_irq_vector_R1eb922a3
c02a9e80 screen_info_Rc7d8d4d6
c0107570 get_wchan_R9aee23c3
c0255940 rtc_lock_R0f9b8c98
c0218e30 memcpy
c0218e70 memset
c02aa424 is_sony_vaio_laptop_R7462d5e4
c0111a50 mtrr_add_R56179c5f
c0111c70 mtrr_del_R272d394e
c01174a0 register_exec_domain_R47e9f5c8
c01174f0 unregister_exec_domain_Ra226b04a
c0117530 __set_personality_R6a47571d
c025642c abi_defhandler_coff_R0a1599e0
c0256430 abi_defhandler_elf_Ra2cfb2a8
c0256434 abi_defhandler_lcall7_R188ab858
c0256438 abi_defhandler_libcso_Rc3cac2a9
c02aeea4 abi_traceflg_R9c9c987a
c02aeea0 abi_fake_utsname_R2e0b4e21
c0117d30 printk_R1b7d4074
c0117e50 acquire_console_sem_Rf174ed48
c0117f40 console_print_Rb714a981
c0117f60 console_unblank_Rb857dfed
c0117f90 register_console_R80c5241f
c01180f0 unregister_console_Rd83dc0dd
c011fa70 dequeue_signal_R8e39319b
c011f7c0 flush_signals_Race8f98a
c01201c0 force_sig_Rd25eb6b8
c011ff10 force_sig_info_R0a9b3de4
c01201e0 kill_pg_R38f29719
c011ffa0 kill_pg_info_R8e2d4990
c0120220 kill_proc_R932da67e
c01211b0 kill_proc_info_Rfb68b264
c0120200 kill_sl_Rfba12fd0
c0120000 kill_sl_info_R1988d21e
c01203a0 notify_parent_R63c24846
c0121240 recalc_sigpending_Rff816951
c01201a0 send_sig_R885235a7
c011fe80 send_sig_info_Rabb145cf
c011f910 block_all_signals_R4b34fbf5
c011f940 unblock_all_signals_R0a2487e0
c0121270 notifier_chain_register_R60cec3b9
c01212b0 notifier_chain_unregister_Rf099679c
c01212e0 notifier_call_chain_R28846962
c0121320 register_reboot_notifier_R1cc6719a
c0121340 unregister_reboot_notifier_R3980aac1
c01224d0 in_group_p_Rc3cf1128
c0122500 in_egroup_p_Rd8a2ab95
c02574a0 hotplug_path_R12dcd5a6
c0122e10 exec_usermodehelper_Rc47bf6ad
c0123430 call_usermodehelper_R84a291c8
c0123220 request_module_R27e4dc04
c01235c0 schedule_task_R2d6c3d04
c01237c0 flush_scheduled_tasks_R7c3242b4
00000001 Using_Versions
c01181a0 inter_module_register_R62dada05
c0118280 inter_module_unregister_R7a9e845e
c0118310 inter_module_get_Rf6a0ce24
c0118370 inter_module_get_request_Rb69f826b
c01183a0 inter_module_put_R6b99f7d8
c0118b60 try_inc_mod_count_Re6105b23
c0125bb0 do_mmap_pgoff_Rb4b2d023
c0126530 do_munmap_R45f1e02b
c01267d0 do_brk_R9eecde16
c011a380 exit_mm_Re8945904
c011a140 exit_files_R13aa7a9d
c011a210 exit_fs_R593cf35d
c011f7e0 exit_sighand_R4615555e
c012e230 _alloc_pages_Re3eb419c
c012e410 __alloc_pages_R963d25b0
c01303e0 alloc_pages_node_R4eddcb48
c012e580 __get_free_pages_R4784e424
c012e5c0 get_zeroed_page_R0c2188c7
c012e610 __free_pages_Rb32b26fb
c012e630 free_pages_R9941ccb8
c02b5164 num_physpages_R0948cde9
c012c9d0 kmem_find_general_cachep_R52bb6891
c012c020 kmem_cache_create_Rd1c0b4e6
c012c430 kmem_cache_destroy_Rdf83c692
c012c3f0 kmem_cache_shrink_R12f7cf04
c012c6e0 kmem_cache_alloc_R75810956
c012c8a0 kmem_cache_free_R891f2686
c012c7a0 kmalloc_R93d4cfe6
c012c930 kfree_R037a0cba
c012ba30 vfree_R2fd1d81c
c012baa0 __vmalloc_R79995c5b
c01257b0 vmalloc_to_page_R40d2ee95
c02b5170 mem_map_Ra82ad7a1
c0124cc0 remap_page_range_R69d01e73
c02b5160 max_mapnr_R01139ffc
c02b516c high_memory_R8a7d1c31
c0125110 vmtruncate_R8d95dcd2
c01261a0 find_vma_Re0a81994
c0126080 get_unmapped_area_Rcdad6639
c0254880 init_mm_Rcd59d344
c0258260 def_blk_fops_R35f97fa7
c01468a0 update_atime_R90897c94
c0137f10 get_fs_type_R17a85a9e
c0138350 get_super_Rfe15c70c
c0138230 drop_super_R3d4ebcb4
c013c480 getname_R7c60d66e
c02b6ed4 names_cachep_Rd25469b4
c01347b0 fput_R30f2944d
c0134890 fget_Rfe5b2df0
c01464d0 igrab_Rb34ac412
c0146460 iunique_R90b509c5
c0146530 iget4_R31c8eefc
c0146670 iput_R377c729a
c0146850 force_delete_R97876af4
c013c7f0 follow_up_R2a2f29c5
c013c870 follow_down_R830af30f
c0147a60 lookup_mnt_Ra86490be
c013d2a0 path_init_R6fa097d3
c013d120 path_walk_R37b32584
c013c6a0 path_release_R8a6d319f
c013d4a0 __user_walk_Ra3902dc4
c013d430 lookup_one_len_R7239ae0c
c013d3a0 lookup_hash_Rd76aaaa7
c01337d0 sys_close_R268cc6a2
c0258678 dcache_lock_R819132b5
c0144ba0 d_alloc_root_R5ff3bfec
c0144d80 d_delete_R9d349033
c0144520 dget_locked_R6f55c32e
c0144ce0 d_validate_Rb88e170a
c0144df0 d_rehash_R84a7c390
c01444c0 d_invalidate_R8beb0b8e
c0144e40 d_move_R8243a262
c0144b60 d_instantiate_R88636de6
c01449e0 d_alloc_R43464955
c0144be0 d_lookup_Rd59afab7
c0144f30 __d_path_Re32d01ca
c0135890 mark_buffer_dirty_R08c23ad5
c0137ba0 set_buffer_async_io_R5c8323f3
c0135860 __mark_buffer_dirty_R63f86b49
c0145480 __mark_inode_dirty_R5875e291
c0132450 fd_install_Racd575ab
c0134630 get_empty_filp_R238d6264
c0134740 init_private_file_Rb2915bc4
c0133350 filp_open_R7aec8e24
c0133760 filp_close_R37c0e73d
c01348c0 put_filp_Rd4939186
c025807c files_lock_R4ce1a539
c0139690 check_disk_change_R11d4076d
c01352c0 __invalidate_buffers_R98f51538
c01351a0 invalidate_bdev_R65757b7e
c0145f60 invalidate_inodes_R000452e1
c0145fd0 invalidate_device_R25a4b0b2
c0126d70 invalidate_inode_pages_Rb1ebda7d
c0127030 truncate_inode_pages_R4aa9f6c7
c0134d30 fsync_dev_R8ea128e2
c0134d10 fsync_no_super_R57520644
c013c620 permission_R2b2d0859
c013c520 vfs_permission_R8ec25040
c0146b80 inode_setattr_Rb6733858
c0146a50 inode_change_ok_Ra494d602
c0145b10 write_inode_now_R8f8aeff8
c0146ca0 notify_change_R5bd43877
c0138df0 set_blocksize_Rc75d857c
c0135770 getblk_Rf96e8f17
c0139ba0 cdget_R51a9d8a7
c0139c60 cdput_R28180290
c0139240 bdget_Rc8f1e752
c0139390 bdput_R2a6b67c9
c01359a0 bread_R162efef9
c0135950 __brelse_Rd19ff615
c0135970 __bforget_R47a2ddb6
c01ac790 ll_rw_block_R304bce2c
c01ac720 submit_bh_R3f475d6a
c0134980 unlock_buffer_R7a4bc0f3
c01349c0 __wait_on_buffer_R790992db
c01276d0 ___wait_on_page_R512e7df9
c0136d80 generic_direct_IO_R1b169fa4
c0135d10 discard_bh_page_R05c2b1a5
c0136b90 block_write_full_page_Rd874b363
c0136390 block_read_full_page_R0e073c0b
c0136900 block_prepare_write_R2a5ccd9a
c0137930 block_sync_page_R7d53f8af
c01365b0 generic_cont_expand_R44125fda
c01366a0 cont_prepare_write_Rd5dde6fb
c0136970 generic_commit_write_R87522d88
c01369d0 block_truncate_page_R0c463d03
c0136d40 generic_block_bmap_R1860e554
c0128360 generic_file_read_R0cd46c54
c0127cf0 do_generic_file_read_Rae30750a
c0129a50 generic_file_write_Rdc501948
c0128d70 generic_file_mmap_R387f0034
c0257f20 generic_ro_fops_R086e27c2
c0127280 generic_buffer_fdatasync_R8cc98f7d
c02b517c page_hash_bits_R04925b4e
c02b5180 page_hash_table_Ra8df4ca5
c0258668 file_lock_list_R6e85119d
c0141d70 locks_init_lock_R4a9dad45
c0141e20 locks_copy_lock_R7c76b302
c0142a90 posix_lock_file_R1ddf0e35
c01426b0 posix_test_lock_R5e85ef46
c0143ef0 posix_block_lock_R997fe48b
c0143f10 posix_unblock_lock_R99edb18a
c01426f0 posix_locks_deadlock_R7d42e34e
c01427a0 locks_mandatory_area_R78dcd7e1
c0144390 dput_R49927314
c01448a0 have_submounts_Rb54b058c
c0144550 d_find_alias_R0bd2f32b
c01445b0 d_prune_aliases_R5f4eeff5
c0144620 prune_dcache_R6cf28f77
c0144760 shrink_dcache_sb_Rcc4dce0c
c0144980 shrink_dcache_parent_R3e0d046e
c0145280 find_inode_number_R7d2cdc40
c0145200 is_subdir_R938c3474
c0133540 get_unused_fd_R99bfbe39
c013d4f0 vfs_create_Re2ffa5d3
c013de80 vfs_mkdir_R1cda9f97
c013dbe0 vfs_mknod_Rad53cd16
c013e610 vfs_symlink_R5e2dbfca
c013e7e0 vfs_link_Rd934ffee
c013e080 vfs_rmdir_R5136b7a5
c013e370 vfs_unlink_R983d506f
c013f2d0 vfs_rename_R69f4ca33
c0132240 vfs_statfs_R62f9af4f
c01338a0 generic_read_dir_R6c60e55c
c01338b0 generic_file_llseek_R37da9bc6
c0133950 no_llseek_R7ab88b84
c0140e40 __pollwait_R27fc45e3
c0140df0 poll_freewait_R3fd02e58
c02a9520 ROOT_DEV_Rb32496e8
c01278e0 __find_get_page_Rccaa86a9
c01279d0 __find_lock_page_Rc76afa15
c0127ac0 grab_cache_page_R4c3f71d9
c0127ae0 grab_cache_page_nowait_R96f70fe6
c0129930 read_cache_page_R6d10e357
c0126d20 set_page_dirty_R24300e5e
c013f580 vfs_readlink_Rf0be3736
c013f5e0 vfs_follow_link_R0b2479f5
c013f7a0 page_readlink_R8446f691
c013f7f0 page_follow_link_Ra3be40e6
c02585a0 page_symlink_inode_operations_R697e8a84
c0137310 block_symlink_Ra0ff4766
c0140750 vfs_readdir_R04e14299
c0142f60 __get_lease_R5e3fc9e7
c0143160 lease_get_mtime_R9c08159b
c01442a0 lock_may_read_Raf4e22ed
c0144320 lock_may_write_R3d8c3e18
c01407d0 dcache_readdir_R983d6a6f
c0133960 default_llseek_R0c524b0a
c01333b0 dentry_open_R2e51551e
c0128960 filemap_nopage_Rbe5c2024
c0128b60 filemap_sync_R4105f29f
c0127370 filemap_fdatasync_Ree6077ab
c0127400 filemap_fdatawait_Rd729143a
c01278c0 lock_page_R11d6a56d
c0127790 unlock_page_R8d083191
c01343b0 register_chrdev_R1b0d5e52
c0134440 unregister_chrdev_Rc192d491
c01395b0 register_blkdev_R3206b36a
c0139630 unregister_blkdev_Reac1c4af
c019ae10 tty_register_driver_R6445a5cd
c019aec0 tty_unregister_driver_R4f5e685e
c02b9780 tty_std_termios_R89ac5254
c02cd960 blksize_size_R2f30b4b6
c02cdd60 hardsect_size_Rc5f560d8
c02cd560 blk_size_Ra2e0a082
c02c3de0 blk_dev_Rd51830fb
c01abc00 is_read_only_R740274ca
c01abc50 set_device_ro_Rdc036ebb
c0146870 bmap_R3ba37518
c0134d70 sync_dev_Rfc0b0f49
c0154b80 devfs_register_partitions_R86d4ef71
c0139970 blkdev_open_R6a634dd2
c01398f0 blkdev_get_Rb51d94cc
c01399a0 blkdev_put_R07e1b7f4
c0139750 ioctl_by_bdev_R11f24b73
c0154ca0 grok_partitions_R54c94a9d
c0154c70 register_disk_Rf60c5483
c025dd60 tq_disk_R5373dbb6
c0135340 init_buffer_R128ac389
c0135940 refile_buffer_R3d81bf5f
c02ce560 max_sectors_R6bf58e33
c02ce160 max_readahead_R3e5480a4
c0198a90 tty_hangup_Rdc7f0d30
c019d550 tty_wait_until_sent_R38bc7a5e
c0198700 tty_check_change_R4a3c9aea
c0198ac0 tty_hung_up_p_R6828f363
c019aae0 tty_flip_buffer_push_R4ec9db61
c019aa60 tty_get_baud_rate_Rca621da8
c019a950 do_SAK_R42052e51
c0137cb0 register_filesystem_Rcd2caa98
c0137d00 unregister_filesystem_R8573718e
c0138c10 kern_mount_Re91af56c
c0147c50 __mntput_R6e2e4f29
c0148090 may_umount_Rf29c4020
c013a5e0 register_binfmt_R4b981cc1
c013a630 unregister_binfmt_Rdc417102
c013b2e0 search_binary_handler_Rac0b2975
c013b000 prepare_binprm_Rc8bde825
c013b110 compute_creds_Rfd684e3a
c013b250 remove_arg_zero_R423f0db6
c013b640 set_binfmt_Ra9843760
c011c6f0 register_sysctl_table_R49da96f9
c011c770 unregister_sysctl_table_Rd2cc521d
c011d620 sysctl_string_R2c0669eb
c011d760 sysctl_intvec_Ra2e6131a
c011d7e0 sysctl_jiffies_Raeb710ce
c011ca40 proc_dostring_R1deffb3f
c011cf40 proc_dointvec_Rdb5651ef
c011d5f0 proc_dointvec_jiffies_R1e69c38a
c011cfc0 proc_dointvec_minmax_R9629e3eb
c011d5c0 proc_doulongvec_ms_jiffies_minmax_Rab91779c
c011d590 proc_doulongvec_minmax_R740dfa8b
c011e9d0 add_timer_Ra19eacf8
c011eb80 del_timer_Rfc62f16d
c0109de0 request_irq_R0c60f2e0
c0109e90 free_irq_Rf20dabd8
c02b3800 irq_stat_R9896a5ec
c0116290 add_wait_queue_Ra7b6ebc8
c01162c0 add_wait_queue_exclusive_R435fc5b4
c01162f0 remove_wait_queue_R0d83b0e0
c01155f0 wait_for_completion_R02032293
c0115550 complete_R61176015
c0109f10 probe_irq_on_Rb121390a
c010a080 probe_irq_off_Rab600421
c011eaa0 mod_timer_R1f13d309
c02572dc tq_timer_Rfa3e9acc
c02572e4 tq_immediate_R0da0dcd1
c0147420 alloc_kiovec_R83380873
c01474a0 free_kiovec_R0f43d405
c0147510 expand_kiobuf_R2f75f773
c0124830 map_user_kiobuf_R161ea623
c0124990 unmap_kiobuf_Re2892fbf
c01249e0 lock_kiovec_R75d82d0e
c0124ac0 unlock_kiovec_Rf3b53c53
c0136f50 brw_kiovec_Rd17b8b68
c01475d0 kiobuf_wait_for_io_R4768c0ba
c0116220 request_dma_R43435480
c0116260 free_dma_R72b243d4
c02562e0 dma_spin_lock_Re3fddd9c
c0106d60 disable_hlt_R794487ee
c0106d70 enable_hlt_R9c7077bd
c011c080 request_resource_R41685cfb
c011c0b0 release_resource_R814e8407
c011c1c0 allocate_resource_Ra715812b
c011c0c0 check_resource_Rd8d78aaa
c011c220 __request_region_R1a1a4f09
c011c2a0 __check_region_Rf1d0cdab
c011c2e0 __release_region_Rd49501d4
c02566f8 ioport_resource_R865ebccd
c0256714 iomem_resource_R9efed5af
c011a870 complete_and_exit_Rdf98dd15
c0115400 __wake_up_R2c77a2af
c01154a0 __wake_up_sync_R08c2a6b5
c0116180 wake_up_process_R90d88783
c0115730 sleep_on_R813ad4fb
c0115780 sleep_on_timeout_R7870fb73
c0115680 interruptible_sleep_on_R15e26425
c01156d0 interruptible_sleep_on_timeout_Re0838aee
c0115110 schedule_R4292364c
c0115060 schedule_timeout_R17d59d01
c02b3c24 jiffies_R0da02d67
c02b3c30 xtime_Rf31ddf83
c010cf30 do_gettimeofday_R72270e35
c010cf90 do_settimeofday_R19d7b1ff
c0254988 loops_per_jiffy_Rba497f13
c02ac6c0 kstat_Rf0241fbc
c02ade60 nr_running_Rca3c6d78
c01176b0 panic_R01075bf0
c0117800 out_of_line_bug_R6d289d2b
c0219ed0 sprintf_R1d26aa98
c0219e90 snprintf_R025da070
c021a280 sscanf_R859204af
c0219eb0 vsprintf_R13d9cea7
c0219a70 vsnprintf_Rb81a20a5
c0219ef0 vsscanf_Rd94a79a2
c01344f0 kdevname_Rc258c906
c0139ab0 bdevname_Rd04782e6
c0134520 cdevname_R9754741d
c0219440 simple_strtol_R0b742fd7
c0219390 simple_strtoul_R20000329
c0219470 simple_strtoull_R61b7b126
c02549a0 system_utsname_Rb12cdfe7
c025736c uts_sem_Ra610cd2e
c0254bd8 sys_call_table_Rdfdb18bd
c0106f00 machine_restart_Re6e3ef70
c0106f80 machine_halt_R9aa32630
c0106f90 machine_power_off_R091c824a
c0267180 _ctype_R8d3894f2
c01a0900 secure_tcp_sequence_number_R1e68841f
c019fcc0 get_random_bytes_R79aa04a2
c02562a0 securebits_Rabe77484
c02572cc cap_bset_R59ab4080
c0115fe0 reparent_to_init_Rec6158d0
c0116110 daemonize_Rd66a354a
c0218930 csum_partial_R9a3de8f8
c0149bf0 seq_escape_Re12c634d
c0149c90 seq_printf_R7bd5cd91
c0149630 seq_open_R5b159df8
c0149bd0 seq_release_R317ef357
c01496a0 seq_read_Reeaaeefe
c0149ac0 seq_lseek_R76f2db8c
c013aa30 setup_arg_pages_R8c4fdaa2
c013a970 copy_strings_kernel_R92bec977
c013b450 do_execve_R9c62098f
c013adb0 flush_old_exec_R33fc5b16
c013ac40 kernel_read_Rcd338287
c013ab70 open_exec_R6be60c68
c0114540 si_meminfo_Rb3a307c6
c02b37dc sys_tz_Rfe5d4bb2
c0134d90 file_fsync_Rc46d1ddb
c01353f0 fsync_inode_buffers_Re1d9455d
c0135520 fsync_inode_data_buffers_R89beca30
c0145d80 clear_inode_Rc76fc7c1
c02da2f0 ___strtok_R29805c13
c0134570 init_special_inode_Rce24e5a1
c02c39e0 read_ahead_R0abb7b07
c0135060 get_hash_table_Ra3fa54fe
c0146250 get_empty_inode_Rb5935d5c
c0146600 insert_inode_hash_Rdf102d78
c0146650 remove_inode_hash_Rf7319ed2
c01350f0 buffer_insert_inode_queue_R71e663a3
c0146e10 make_bad_inode_R9a2b6a8c
c0146e40 is_bad_inode_R4ff1cdaa
c02b3c00 event_R7b16c344
c0137270 brw_page_R8dd2d41a
c025733c overflowuid_R8b618d08
c0257340 overflowgid_R7171121c
c0257344 fs_overflowuid_R25820c64
c0257348 fs_overflowgid_Rdf929370
c0140300 fasync_helper_Re3fcbdc4
c0140440 kill_fasync_R34f18b8d
c01544d0 disk_name_Rd47e4f95
c013c650 get_write_access_R3c68bed4
c02191a0 strnicmp_R4e830a3e
c0219210 strspn_Rc7ec6c27
c0219300 strsep_R85df9b6c
c02a9240 tasklet_hi_vec_Rbb06575f
c02a9200 tasklet_vec_R41d3b367
c02b3840 bh_task_vec_R284177b8
c011bd80 init_bh_Rf6cf27cc
c011bda0 remove_bh_Rbc524a32
c011bc90 tasklet_init_Ra5808bbf
c011bcc0 tasklet_kill_R79ad224b
c011bdd0 __run_task_queue_R3889b11c
c011ba00 do_softirq_Rf0a529b7
c011bab0 raise_softirq_Rd8e4fa1c
c011bee0 cpu_raise_softirq_Rd01f3ee8
c011bb10 __tasklet_schedule_Red5c73bf
c011bb60 __tasklet_hi_schedule_R60ea5fe7
c0268000 init_task_union_R9ed390ed
c02a9140 tasklist_lock_R6b4b8ef8
c02ade80 pidhash_R03e254b3
c0123e20 pm_register_R027ebe5e
c0123ea0 pm_unregister_R94097bd6
c0123f00 pm_unregister_all_Rba4fe124
c0123f60 pm_send_R1abc3026
c0124020 pm_send_all_Recbf9cad
c01240b0 pm_find_Re7902a5f
c02b514c pm_active_Rebd387f6
c01246b0 get_user_pages_R71787f0e
c0257684 vm_max_readahead_Rf8c9aa3c
c0257688 vm_min_readahead_R41ef314d
c0127330 fail_writepage_R03bc2e94
c02b51cc zone_table_Ra661473e
c0132030 shmem_file_setup_R248a7aa6
c0133860 generic_file_open_Rdc951b55
c01358c0 set_buffer_flushtime_R565baf58
c0135a70 put_unused_buffer_head_Rd98ee327
c0135a80 get_unused_buffer_head_Rd1162819
c0135b00 set_bh_page_R91c90065
c0135d90 create_empty_buffers_R5a83400f
c0136ca0 writeout_one_page_R59d0eab2
c0136d00 waitfor_one_page_R7da61bed
c01377b0 try_to_free_buffers_R6932cd2f
c02b6ee0 bh_cachep_Rdcc0bb37
c02b7024 nfsd_linkage_Rb7a059a8
c02b7214 proc_sys_root_Re9efec00
c0151da0 proc_symlink_Re9fd4e19
c0151e20 proc_mknod_R1130bb10
c0151e60 proc_mkdir_R4e85bdfa
c0151ea0 create_proc_entry_R87956b5b
c0151f90 remove_proc_entry_Rb9be80ec
c0258be0 proc_root_R07f3c278
c02b7204 proc_root_fs_R5e7ab443
c02b7208 proc_net_Re96a50d1
c02b720c proc_bus_Rf0dbdade
c02b7210 proc_root_driver_R1cbea60f
c0160770 journal_start_Rdef4a920
c01609d0 journal_try_start_R05ecadea
c0160cd0 journal_restart_R544c065b
c0160b50 journal_extend_Rfa76694c
c0161cb0 journal_stop_Rde7e9a02
c0160dd0 journal_lock_updates_Re7106a42
c0160e60 journal_unlock_updates_R690402d7
c0161440 journal_get_write_access_Ree22c6c1
c01614a0 journal_get_create_access_R0cc610e1
c0161660 journal_get_undo_access_R5d698b47
c0161790 journal_dirty_data_R34c51b78
c0161940 journal_dirty_metadata_R3a343387
c0161b00 journal_forget_Rd48479ac
c0166e80 journal_flush_R128618cf
c01653a0 journal_revoke_Rcb4824eb
c0166400 journal_init_dev_R66bbd054
c01664a0 journal_init_inode_R403e09ee
c0166db0 journal_update_format_Raf9620d2
c0166c70 journal_check_used_features_Raacbaf1c
c0166cd0 journal_check_available_features_R7fd1d83b
c0166d20 journal_set_features_Reca29646
c01666b0 journal_create_Rc06eeef8
c0166a90 journal_load_Rfd6f0dde
c0166b10 journal_destroy_R544d31a3
c0163da0 journal_recover_R72de1dd1
c0166870 journal_update_superblock_R42b41236
c0167180 journal_abort_Rbcd76ac7
c01671c0 journal_errno_R7f5de034
c0167230 journal_ack_err_Rab0c5d77
c01671f0 journal_clear_err_R81fa5598
c0166070 log_wait_commit_R2a2c223d
c0165fe0 log_start_commit_R9a32fdd4
c0167030 journal_wipe_Raaf294a5
c0167260 journal_blocks_per_page_R119284ec
c01623b0 journal_flushpage_R5c735884
c0162120 journal_try_to_free_buffers_R80a67c8c
c01661b0 journal_bmap_Rb7970514
c0161f00 journal_force_commit_R40c9d916
c02b7870 journal_enable_debug_R866ef208
c016d850 devfs_put_R8406bae7
c016e420 devfs_register_Rbaadeea7
c016e810 devfs_unregister_R6be17e44
c016e9f0 devfs_mk_symlink_R899c947a
c016ea60 devfs_mk_dir_R6a2c900a
c016eb80 devfs_get_handle_R3a8265dd
c016ebc0 devfs_find_handle_R3da6ce15
c016ec00 devfs_get_flags_Ra508ac88
c016ec80 devfs_set_flags_Rc78c6569
c016ecf0 devfs_get_maj_min_Rc9e33dc8
c016ed50 devfs_get_handle_from_inode_Rc4a777b1
c016ed80 devfs_generate_path_R410150e1
c016ee60 devfs_get_ops_Rbd2978c7
c016ef40 devfs_set_file_size_Rabf4be39
c016ef90 devfs_get_info_R4bcec3f3
c016efb0 devfs_set_info_R428f3233
c016efd0 devfs_get_parent_R15ee7af7
c016eff0 devfs_get_first_child_R7747e160
c016f020 devfs_get_next_sibling_R48b65745
c016f040 devfs_auto_unregister_R5e10b256
c016f0b0 devfs_get_unregister_slave_Rbc7a5bbb
c016f0d0 devfs_get_name_R45172d1b
c016f0f0 devfs_register_chrdev_Radabb234
c016f120 devfs_register_blkdev_Rf04c8c5a
c016f150 devfs_unregister_chrdev_R77f3e0ce
c016f180 devfs_unregister_blkdev_R5ca0f0f0
c0170a90 devfs_register_tape_Rb8d618e8
c0170b50 devfs_register_series_Rf3efa40e
c0170bd0 devfs_alloc_major_R190e3bbc
c0170c30 devfs_dealloc_major_Rce9de41d
c0170c70 devfs_alloc_devnum_R0b35c57f
c0170e10 devfs_dealloc_devnum_R74e856e9
c0170ed0 devfs_alloc_unique_number_R8018e436
c0171060 devfs_dealloc_unique_number_R296d6ab4
c01712e0 register_nls_Rb75d5c98
c0171340 unregister_nls_Re636348f
c0171430 unload_nls_R36a16ffc
c01713c0 load_nls_Rafd2e7ee
c01714d0 load_nls_default_R535f6428
c0171130 utf8_mbtowc_R4ddc4b9f
c01711a0 utf8_mbstowcs_R7d850612
c0171200 utf8_wctomb_Rf82f1109
c0171280 utf8_wcstombs_R863cb91a
c01984b0 tty_register_ldisc_R8d9cbaeb
c019acf0 tty_register_devfs_Rbfe07a5f
c019adc0 tty_unregister_devfs_Reaaa410d
c019dc00 n_tty_ioctl_R13355859
c019f0b0 misc_register_R954a444a
c019f1e0 misc_deregister_R6ab7b99a
c019f780 add_keyboard_randomness_R74789c19
c019f7b0 add_mouse_randomness_R70507c97
c019f7d0 add_interrupt_randomness_R16dfbf36
c019f800 add_blkdev_randomness_Rd9cb21d1
c019f530 batch_entropy_store_R68d33fbe
c01a0380 generate_random_uuid_Ra681fe88
c025c63c color_table_Rf6bb4729
c025c64c default_red_R3147857d
c025c68c default_grn_R06fe3b14
c025c6cc default_blu_R10ee20bb
c02c205c video_font_height_R65e24198
c02c2064 video_scan_lines_Rafaf59dc
c01a5500 vc_resize_R12e7edfe
c02c21b0 fg_console_R4e6e8ea7
c02c26f0 console_blank_hook_Rd25d4f74
c02c1f60 vt_cons_R9dc5e4ad
c01a8a40 take_over_console_Rdea4e062
c01a8bd0 give_up_console_Rd52fff57
c01a9730 set_selection_R7f535065
c01a9c80 paste_selection_R2c9d9500
c01a9e70 handle_scancode_Rd3d6a2f1
c02c391c kbd_ledfunc_Rfa67cc5f
c025c88c keyboard_tasklet_R28aa0faa
c025dd68 io_request_lock_Rf0eb38cb
c01ac930 end_that_request_first_Rddbb7ab4
c01ac9f0 end_that_request_last_Rc669f897
c01ab910 blk_grow_request_list_R0e99708a
c01aba40 blk_init_queue_R35b349c9
c01aca20 blk_get_queue_R15f1b7a9
c01ab770 blk_cleanup_queue_R7036f40e
c01ab7b0 blk_queue_headactive_Rb994c9ab
c01ab7c0 blk_queue_make_request_R26335ca7
c01ac5f0 generic_make_request_Ra645e387
c01abea0 blkdev_release_request_R0d184be3
c01abe50 req_finished_io_Rc4b2a994
c01ab8e0 generic_unplug_device_Ra2b8075e
c01acef0 blk_ioctl_Re7800428
c02d0940 gendisk_head_R733db3fa
c01ad360 add_gendisk_R45c47849
c01ad3a0 del_gendisk_R4b200635
c01ad3e0 get_gendisk_Rb32604b6
c01ae140 init_etherdev_R20772929
c01ae160 alloc_etherdev_Rd50ed31a
c01ae1f0 ether_setup_R7940ef23
c01ae2a0 ltalk_setup_Rb9f0891b
c01ae310 register_netdev_Rc1644cbe
c01ae380 unregister_netdev_Re6fb46df
c01ae480 autoirq_setup_R5a5a2280
c01ae490 autoirq_report_R84530c53
c01af8b0 agp_free_memory_R48653576
c01af940 agp_allocate_memory_R47ba4b82
c01afa10 agp_copy_info_Rd0703865
c01afad0 agp_bind_memory_R28347b8b
c01afb30 agp_unbind_memory_R1888e773
c01b0200 agp_enable_R50eb8453
c01af770 agp_backend_acquire_Rfda71904
c01af7a0 agp_backend_release_R0d43fde1
c02d1060 ide_hwifs_R7a446317
c01b5070 ide_register_module_R8526704f
c01b50b0 ide_unregister_module_Rad381b18
c01b38e0 ide_spin_wait_hwgroup_R0cc7cd65
c02d1040 ide_probe_R0897fa69
c01b07a0 drive_is_flashcard_R958a2bc8
c01b2520 ide_timer_expiry_Ra7ac9f5b
c01b2760 ide_intr_Rc912a433
c025ed40 ide_fops_R22dfbcaa
c01b2440 ide_get_queue_R0f2b5be7
c01b3b00 ide_add_generic_settings_R3c1ac521
c02d3248 ide_devfs_handle_Reb53c0a2
c01b2470 do_ide_request_R7dc9c63a
c01b4e50 ide_scan_devices_Raa9757b2
c01b4f00 ide_register_subdriver_Rf2217df0
c01b5000 ide_unregister_subdriver_R68954dea
c01b2d40 ide_replace_subdriver_R4e8a7731
c01b0940 ide_input_data_Rbcf3a69e
c01b0a00 ide_output_data_R64c34d0b
c01b0ab0 atapi_input_bytes_R3cc627b0
c01b0b20 atapi_output_bytes_R4d0bfb46
c01b0b90 drive_is_ready_Re72a3439
c01b0c70 ide_set_handler_R59393095
c01b1480 ide_dump_status_Rcbfca118
c01b18a0 ide_error_Ra5ddf1c1
c01b4c00 ide_fixstring_R2eae4a19
c01b1c00 ide_wait_stat_R89d95dae
c01b1220 ide_do_reset_R8656bd46
c01b20f0 restart_request_R3ed9a16b
c01b28e0 ide_init_drive_cmd_Rf7a5ecba
c01b2900 ide_do_drive_cmd_R05d2fe57
c01b1230 ide_end_drive_cmd_R6ee4bafe
c01b0be0 ide_end_request_R1eee8964
c01b2a20 ide_revalidate_disk_R0e604442
c01b1a30 ide_cmd_R9491deae
c01b3d10 ide_wait_cmd_R2a289429
c01b3da0 ide_wait_cmd_task_R12654751
c01b3de0 ide_delay_50ms_R7f9ab554
c01b2130 ide_stall_queue_Re97071d5
c01b9960 ide_add_proc_entries_R020363ef
c01b99c0 ide_remove_proc_entries_R999beaae
c01b96c0 proc_ide_read_geometry_R50fed6f7
c01b9c30 create_proc_ide_interfaces_Rab2c600e
c01b9b00 recreate_proc_ide_device_Ra3e0188d
c01b9b90 destroy_proc_ide_device_R9aaf2964
c01b3670 ide_add_setting_R9022cc24
c01b3790 ide_remove_setting_Rf0722e62
c01b3490 ide_register_hw_Ra4dd2eae
c01b3610 ide_register_R3b5586d8
c01b2f00 ide_unregister_R0c486b72
c01b3420 ide_setup_ports_R089079a8
c01b2de0 hwif_unregister_Raf9bdf0d
c01b2880 get_info_ptr_R7f73c33d
c01b0cd0 current_capacity_R587b5389
c01b3e00 system_bus_clock_Ree5a11eb
c01b3e10 ide_reinit_drive_Rf4ebab31
c01b5350 ide_auto_reduce_xfer_Rf6c897ee
c01b53d0 ide_driveid_update_Rc9326d64
c01b5570 ide_ata66_check_Rb5de2575
c01b55e0 set_transfer_Raae85cb5
c01b5620 eighty_ninty_three_R68d88bf7
c01b5660 ide_config_drive_speed_R3ea564b8
c01b6ef0 task_read_24_Rc4cc774a
c01b5ba0 do_rw_taskfile_R922fb6fc
c01b5e40 do_taskfile_R4284d0da
c01b6000 set_multmode_intr_R57d4616b
c01b6060 set_geometry_intr_R690cd57e
c01b60c0 recal_intr_Rd2f58e50
c01b6100 task_no_data_intr_R1349e480
c01b6170 task_in_intr_Raa4baa9a
c01b6250 task_mulin_intr_Ra34fc964
c01b6370 pre_task_out_intr_R59881683
c01b6470 task_out_intr_R7a9eb203
c01b65a0 task_mulout_intr_R2092697b
c01b68c0 ide_init_drive_taskfile_R5f397a6f
c01b68e0 ide_wait_taskfile_R10760a3b
c01b6a00 ide_raw_taskfile_R9f205929
c01b6710 ide_pre_handler_parser_Ra41a6ea6
c01b6780 ide_handler_parser_R55b77cb4
c01b6810 ide_cmd_type_parser_R937d8f24
c01b6a60 ide_taskfile_ioctl_Rcf8c1da7
c01bb440 export_ide_init_queue_Rfdaf73b9
c01bb450 export_probe_for_drive_R27115207
c01be350 pci_read_config_byte_Rede9d9d2
c01be380 pci_read_config_word_R3e5c726f
c01be3c0 pci_read_config_dword_R2c1192c5
c01be400 pci_write_config_byte_R57220483
c01be430 pci_write_config_word_R2b36ae09
c01be470 pci_write_config_dword_R43bface4
c025f028 pci_devices_R7a84b102
c025f020 pci_root_buses_R082c3213
c01bdbf0 pci_enable_device_R6225e990
c01bdc10 pci_disable_device_Rff052e74
c01bd8e0 pci_find_capability_Rb073eaa1
c01bdd80 pci_release_regions_R2f79544c
c01bde00 pci_request_regions_R02896321
c01bd8b0 pci_find_class_Rbee3c2c6
c01bd890 pci_find_device_R2f35dc0f
c01bd7e0 pci_find_slot_R19f0f463
c01bd820 pci_find_subsys_R39b54a63
c01be4b0 pci_set_master_R71ceaeca
c01be580 pci_set_mwi_R5ba98bba
c01be5d0 pci_clear_mwi_R99568ec1
c01be500 pdev_set_mwi_Rce1be093
c01be610 pci_set_dma_mask_R98ebc076
c01be640 pci_dac_set_dma_mask_R1e2b01b1
c01c0a80 pci_assign_resource_R20bd4d9b
c01be030 pci_register_driver_R954e8c53
c01be090 pci_unregister_driver_Rf56513b9
c01be310 pci_dev_driver_R8ae9d3e1
c01bdf60 pci_match_device_R4a614d22
c01bd9a0 pci_find_parent_resource_R4a8fe05b
c01bed80 pci_setup_device_Rf4aa23dd
c01be240 pci_insert_device_R3d40aa79
c01be2c0 pci_remove_device_R5a96e8d3
c01be200 pci_announce_device_to_drivers_R79423b11
c01beb60 pci_add_new_bus_R19043496
c01bf070 pci_do_scan_bus_R34d43e74
c01befa0 pci_scan_slot_R047af74e
c01c0520 pci_proc_attach_device_R26c3a4e7
c01c05c0 pci_proc_detach_device_Rd711b74a
c01c0600 pci_proc_attach_bus_R6e03c8c6
c01c0650 pci_proc_detach_bus_R8602f228
c01bda20 pci_set_power_state_R70823a6e
c01bdb40 pci_save_state_Re1a91677
c01bdb80 pci_restore_state_Rbfd98c6b
c01bdc50 pci_enable_wake_Ra1d0e9af
c01bfba0 pcibios_present_R520a75b9
c01bfc70 pcibios_read_config_byte_Rd80115e1
c01bfcb0 pcibios_read_config_word_Raa9effd7
c01bfcf0 pcibios_read_config_dword_R38ae6689
c01bfd30 pcibios_write_config_byte_R719856ee
c01bfd80 pcibios_write_config_word_R4f1c2e33
c01bfdd0 pcibios_write_config_dword_R81b4f465
c01bfbc0 pcibios_find_class_Ref333f7b
c01bfc10 pcibios_find_device_R97d49c4d
c02d3298 isa_dma_bridge_buggy_Rf82abc1d
c02d3294 pci_pci_problems_Rdc14eda7
c01bf510 pci_pool_create_Rfe7d9f70
c01bf730 pci_pool_destroy_Rff6f5e1e
c01bf7c0 pci_pool_alloc_R2adfd09b
c01bf990 pci_pool_free_R12dd0912
c01c4980 register_pccard_driver_R583d4ed2
c01c4ab0 unregister_pccard_driver_Rdb348cd2
c01c6e00 pcmcia_lookup_bus_Ra5bc6505
c01c6730 pcmcia_access_configuration_register_R11ce86d9
c01c3bd0 pcmcia_adjust_resource_info_R26ef7f97
c01c67f0 pcmcia_bind_device_R980ac11c
c01c68c0 pcmcia_bind_mtd_R48373da7
c01c4710 pcmcia_check_erase_queue_R4798d074
c01c47f0 pcmcia_close_memory_R924248c2
c01c4930 pcmcia_copy_memory_R46f502d7
c01c6950 pcmcia_deregister_client_R2a4e1e51
c01c46a0 pcmcia_deregister_erase_queue_R4d7a897a
c01c8200 pcmcia_eject_card_R2796e35e
c01c6c30 pcmcia_get_first_client_Raef4b45b
c01c6c00 pcmcia_get_card_services_info_R3c39c871
c01c6a80 pcmcia_get_configuration_info_R29d624d7
c01c7030 pcmcia_get_mem_page_Rcf67ef9c
c01c6c80 pcmcia_get_next_client_R6499d87a
c01c44b0 pcmcia_get_first_region_Rf26a1314
c01c14c0 pcmcia_get_first_tuple_Radd329ce
c01c6da0 pcmcia_get_first_window_Rb4b4775d
c01c4550 pcmcia_get_next_region_Rcbc02c32
c01c1740 pcmcia_get_next_tuple_Rcfb971fd
c01c6dd0 pcmcia_get_next_window_R0647faa6
c01c6e40 pcmcia_get_status_Rd5a407fa
c01c1960 pcmcia_get_tuple_data_R10a9c9d0
c01c8260 pcmcia_insert_card_R79e8a9ae
c01c7060 pcmcia_map_mem_page_R27f2d85a
c01c70c0 pcmcia_modify_configuration_R7b6f1bbd
c01c71b0 pcmcia_modify_window_R7e499224
c01c4770 pcmcia_open_memory_R4b6b80d3
c01c2ab0 pcmcia_parse_tuple_Ree7f0de3
c01c4810 pcmcia_read_memory_R2e2a9182
c01c7220 pcmcia_register_client_Rbadb13d8
c01c4640 pcmcia_register_erase_queue_Rae42d011
c01c4580 pcmcia_register_mtd_Re1562738
c01c7430 pcmcia_release_configuration_Rd66d87a7
c01c7540 pcmcia_release_io_R8436cbc5
c01c7610 pcmcia_release_irq_R184c3109
c01c76e0 pcmcia_release_window_Re03e8d57
c01c1400 pcmcia_replace_cis_Ra248a6d8
c01c8370 pcmcia_report_error_Rb83ec557
c01c7770 pcmcia_request_configuration_R78fcf229
c01c7b50 pcmcia_request_io_Rcd728912
c01c7c90 pcmcia_request_irq_Read92b39
c01c7e90 pcmcia_request_window_Rc896704e
c01c80a0 pcmcia_reset_card_Rb0bc5318
c01c81b0 pcmcia_resume_card_R23732eef
c01c82f0 pcmcia_set_event_mask_R058fc202
c01c8140 pcmcia_suspend_card_R0a33de8e
c01c2cb0 pcmcia_validate_cis_R6a84ad2a
c01c48a0 pcmcia_write_memory_R85720008
c0260334 dead_socket_Rcf97f3bd
c01c5d60 register_ss_entry_Rad5c9196
c01c5e80 unregister_ss_entry_R77e8f017
c01c8430 CardServices_Re4eef0a4
c01c41b0 MTDHelperEntry_R92155580
c0260344 proc_pccard_R2d177422
c01c5c30 pcmcia_register_socket_R05e9f2df
c01c5d90 pcmcia_unregister_socket_Rb132ae82
c01c63a0 pcmcia_suspend_socket_Re502d163
c01c63d0 pcmcia_resume_socket_R0aee8574
c0260520 yenta_operations_R1ba37cf7
c01cc5a0 register_framebuffer_Rfd9287dc
c01cc6e0 unregister_framebuffer_R8e17446d
c02d3840 registered_fb_R0ca5b4bf
c02d3820 num_registered_fb_R6c61ce70
c01cc460 GET_FB_IDX_R5280c630
c01cc770 fb_alloc_cmap_R07a890c8
c01cc880 fb_copy_cmap_R3d68266c
c01ccb30 fb_get_cmap_R9283bb09
c01ccc80 fb_set_cmap_Ra33ad28d
c01ccd80 fb_default_cmap_Ra56557ea
c01ccdc0 fb_invert_cmaps_Rf195c682
c01cced0 __fb_try_mode_R4f8f526e
c02d3960 fb_display_R32ba4aca
c01ce860 fbcon_redraw_bmove_R1f123f5d
c01ce810 fbcon_redraw_clear_R94e4a330
c0264180 fbcon_dummy_R2418a06c
c0240980 fb_con_R00fa7f08
c01e9900 register_8022_client_Recd8a464
c01e9970 unregister_8022_client_R7acef15d
c01e9ac0 register_snap_client_Rc7d692df
c01e9b40 unregister_snap_client_R9abefc50
c01dfcb0 skb_over_panic_R920b651f
c01dfcf0 skb_under_panic_R566b5167
c01de710 sock_register_Rb2b33355
c01de760 sock_unregister_R2394a062
c01df520 __lock_sock_Rc53c97c6
c01df5d0 __release_sock_Rfe48fe85
c01e16f0 memcpy_fromiovec_R9fb3dd30
c01e1670 memcpy_tokerneliovec_Rc125e088
c01dd740 sock_create_Rbbd76889
c01dced0 sock_alloc_Re6521528
c01dcfa0 sock_release_R02d64ba7
c01de8f0 sock_setsockopt_R6141f6b1
c01ded20 sock_getsockopt_Rb221bfab
c01dcff0 sock_sendmsg_Rf052ad2d
c01dd080 sock_recvmsg_Rcc246247
c01df040 sk_alloc_R2fe54cb8
c01df0a0 sk_free_R8929c4d8
c01dd6c0 sock_wake_async_Re6c5ae75
c01df4f0 sock_alloc_send_skb_R51074412
c01df330 sock_alloc_send_pskb_R3989501e
c01dfb30 sock_init_data_R80fb1b5a
c01df7c0 sock_no_release_R0703327a
c01df7d0 sock_no_bind_R81e94387
c01df7e0 sock_no_connect_R8481a69a
c01df7f0 sock_no_socketpair_Rd6175b1c
c01df800 sock_no_accept_R8fa8a5c5
c01df810 sock_no_getname_Rf328a572
c01df820 sock_no_poll_R50e15d85
c01df830 sock_no_ioctl_Rd44da715
c01df840 sock_no_listen_R793d8d9d
c01df850 sock_no_shutdown_R764e43ff
c01df870 sock_no_getsockopt_R5923482f
c01df860 sock_no_setsockopt_R16e10b7a
c01df8f0 sock_no_sendmsg_R713b26f0
c01df900 sock_no_recvmsg_R518783f5
c01df910 sock_no_mmap_R0f35fc6a
c01df920 sock_no_sendpage_Rbca1c887
c01df120 sock_rfree_R0eb5bb2b
c01df0e0 sock_wfree_R6cca7a28
c01df130 sock_wmalloc_R208ba5e9
c01df190 sock_rmalloc_R27b8aa87
c01e0430 skb_linearize_Rb5791649
c01e0f70 skb_checksum_R4706f375
c01e2fe0 skb_checksum_help_R6d62c109
c01e1b20 skb_recv_datagram_R9b0ae048
c01e1bf0 skb_free_datagram_Rf121059d
c01e1c10 skb_copy_datagram_R7bd4f04c
c01e1c40 skb_copy_datagram_iovec_Rd475fdc4
c01e2130 skb_copy_and_csum_datagram_iovec_R435bb1f3
c01e0d50 skb_copy_bits_R67646224
c01e11b0 skb_copy_and_csum_bits_R0c5330dc
c01e1410 skb_copy_and_csum_dev_R3f767652
c01e0870 skb_copy_expand_R041ce847
c01e0920 ___pskb_trim_Re9d7f91a
c01e0a90 __pskb_pull_tail_Ra58f5092
c01e06b0 pskb_expand_head_R94fa412a
c01e0520 pskb_copy_R25f735af
c01e07f0 skb_realloc_headroom_R1ab68eb4
c01e2210 datagram_poll_R7a394f03
c01e2560 put_cmsg_Rf39bf4d9
c01df1e0 sock_kmalloc_R0d433a7f
c01df220 sock_kfree_s_Rb62e367e
c01e6f50 neigh_table_init_R485c91d4
c01e7050 neigh_table_clear_R86dc2495
c01e69e0 neigh_resolve_output_R6b611c81
c01e6b80 neigh_connected_output_R376dcdde
c01e6460 neigh_update_Rc2daed99
c01e59c0 neigh_create_R3e4d5ef8
c01e5940 neigh_lookup_R37a385bd
c01e62b0 __neigh_event_send_R6bdd75c0
c01e67e0 neigh_event_ns_R8cba2b67
c01e56c0 neigh_ifdown_R03b1b08e
c01e77d0 neigh_sysctl_register_R1033f200
c01e5b50 pneigh_lookup_R43efd90a
c01e6d40 pneigh_enqueue_R9d24fb42
c01e5e00 neigh_destroy_R2fc92955
c01e6e10 neigh_parms_alloc_Rc2a875bf
c01e6ec0 neigh_parms_release_Rdaf6cfbf
c01e5520 neigh_rand_reach_time_R4188d439
c01e6960 neigh_compat_output_R186e1a3e
c01e5230 dst_alloc_R5407f47c
c01e52b0 __dst_free_R017ac91a
c01e5350 dst_destroy_Rdc0f781c
c01e87b0 net_ratelimit_Rf6ebc03b
c01e8780 net_random_R1c66f64c
c01e87a0 net_srandom_Rff963ed8
c01e2390 __scm_destroy_R704aa290
c01e23d0 __scm_send_Rdba159e3
c01e2870 scm_fp_dup_R4f734fb1
c0258060 files_stat_R03cada27
c01e1600 memcpy_toiovec_R9ceb163c
c01e9790 make_8023_client_Rf0c9bf13
c01e97c0 destroy_8023_client_Ra18dfa35
c01e9710 make_EII_client_Rfbc33f3d
c01e9740 destroy_EII_client_Rcaff732a
c01df6d0 sklist_destroy_socket_Reae1c124
c01df680 sklist_insert_socket_Ra6227ff4
c01e2690 scm_detach_fds_R7081c857
c02646a8 br_handle_frame_hook_R45859046
c02d9e40 br_ioctl_hook_R1fb9705f
c0265cfc inetdev_lock_R39311aa7
c01ef580 inet_add_protocol_R3f70fe83
c01ef600 inet_del_protocol_R3f7ea322
c0210cd0 inet_register_protosw_Re73a28c1
c0210d90 inet_unregister_protosw_R605e3f59
c01ee160 ip_route_output_key_Rae89ffff
c01eda20 ip_route_input_R155da033
c020d4d0 icmp_send_R58af947d
c01f11c0 ip_options_compile_R7158781a
c01f1750 ip_options_undo_R9721f12f
c020c0a0 arp_send_Rfa15ba98
c02658a0 arp_broken_ops_R60327856
c01ec5f0 __ip_select_ident_R647900cb
c01f3370 ip_send_check_Ra37b7441
c01f2e40 ip_fragment_R8ae341e2
c02662c4 inet_family_ops_Rc0917699
c01ebac0 in_aton_R83e0a162
c0211010 ip_mc_inc_group_R02dcbe73
c02110e0 ip_mc_dec_group_R98c4f30c
c01f33c0 ip_finish_output_R85e39261
c0266220 inet_stream_ops_Rda357b35
c0266280 inet_dgram_ops_R6ce431a7
c01f3930 ip_cmsg_recv_Rb7e96c06
c02119b0 inet_addr_type_Re8cf3ae7
c020f120 inet_select_addr_Rbf250aca
c0211930 ip_dev_find_R9635a2c1
c020e5a0 inetdev_by_index_Rb024748c
c020df40 in_dev_finish_destroy_R80167eb2
c01f08b0 ip_defrag_R4d11bbe9
c0211c50 ip_rt_ioctl_R94208e84
c020e8f0 devinet_ioctl_R869c80ea
c020f1d0 register_inetaddr_notifier_R3e45e9ff
c020f1f0 unregister_inetaddr_notifier_R760b437a
c02d8e80 ip_statistics_Rb1579ebe
c01f7e40 tcp_read_sock_R84c76d68
c01eb000 netlink_set_err_Rcae8fc20
c01eae10 netlink_broadcast_R97c4754f
c01eab40 netlink_unicast_Re6d27ad0
c01eb3f0 netlink_kernel_create_R2631e0d8
c01eb630 netlink_dump_start_Rf0f70929
c01eb710 netlink_ack_R0a3f5835
c01eb810 netlink_attach_R384d5399
c01eb870 netlink_detach_R1d742495
c01eb8b0 netlink_post_R7a2ea324
c01e7b80 rtattr_parse_Re49414e9
c02d8200 rtnetlink_links_R5bb5718a
c01e7c10 __rta_fill_R7fa50f65
c01e81d0 rtnetlink_dump_ifinfo_R71543397
c01e7d10 rtnetlink_put_metrics_R60411cf5
c02d81e0 rtnl_R050f2a88
c01e70f0 neigh_delete_R12117aaf
c01e7200 neigh_add_R01ed9bb0
c01e7740 neigh_dump_info_Rc06753dc
c01e3d80 dev_set_allmulti_R7a96b877
c01e3d10 dev_set_promiscuity_Ra4a39158
c01df620 sklist_remove_socket_Ra6406752
c0264b60 rtnl_sem_R93ffbd01
c01e7b20 rtnl_lock_Rc7a4fbed
c01e7b40 rtnl_unlock_R6e720ff2
c01dcb80 move_addr_to_kernel_R5dfa4696
c01dcbc0 move_addr_to_user_R38c99093
c02d9e80 ipv4_config_R26b99782
c01e2de0 dev_open_R9cc6718a
c01eba90 in_ntoa_R20ce491b
c020d230 xrlim_allow_Reee039fb
c01ef990 ip_rcv_R27da939c
c020c720 arp_rcv_R6bb33d63
c02658c0 arp_tbl_Rf2d639bb
c020beb0 arp_find_Rb0c88709
c01e2ef0 register_netdevice_notifier_R63ecad53
c01e2f10 unregister_netdevice_notifier_Rfe769456
c025e940 loopback_dev_R40d4ac68
c01e4680 register_netdevice_R5928f89c
c01e4840 unregister_netdevice_R0f6c4a38
c01e2d20 netdev_state_change_R22199cb2
c01e4640 dev_new_index_R8fddc84c
c01e2b80 dev_get_by_index_R5dd66fc4
c01e2b60 __dev_get_by_index_Rfb063dde
c01e2b20 dev_get_by_name_R80679044
c01e2ac0 __dev_get_by_name_R340f3320
c01e47a0 netdev_finish_unregister_R9f82bffb
c01e3c50 netdev_set_master_R248ab483
c01e9500 eth_type_trans_R634544d7
c01dfd30 alloc_skb_R716f72da
c01dfff0 __kfree_skb_Rc3caf98c
c01e0110 skb_clone_R2fbe7b8c
c01e0370 skb_copy_R5029338e
c01e3320 netif_rx_R34757d7b
c01e28c0 dev_add_pack_R58088e54
c01e2920 dev_remove_pack_R21319d81
c01e2b40 dev_get_R79259fbc
c01e2cb0 dev_alloc_R5843e257
c01e2c20 dev_alloc_name_Rf3e60fd3
c01e9d30 __netdev_watchdog_up_R1dbfe1d2
c01e2d50 dev_load_Ra90fd3b7
c01e4240 dev_ioctl_R387c78a5
c01e3060 dev_queue_xmit_Rc44ad70f
c025ea88 dev_base_R2fb68bcb
c025ea8c dev_base_lock_Ra9e8925d
c01e2e80 dev_close_Rf274d008
c01e4d50 dev_mc_add_Rc4ce259f
c01e4c30 dev_mc_delete_R02cab305
c01e4bf0 dev_mc_upload_R81f48537
c01403e0 __kill_fasync_R50f8638f
c0264668 if_port_text_R9cf0c64f
c02643e0 sysctl_wmem_max_Rfac8865f
c02643e4 sysctl_rmem_max_Rb05fc310
c0265428 sysctl_ip_default_ttl_Rf6388c56
c01ea150 qdisc_destroy_R30163898
c01ea130 qdisc_reset_R9a07c7e4
c01e9b90 qdisc_restart_R1a028fd0
c01ea070 qdisc_create_dflt_R0621aaeb
c0264dc0 noop_qdisc_R4429201a
c0264d60 qdisc_tree_lock_Re0089c56
c01e8840 nf_register_hook_R7e05080a
c01e88b0 nf_unregister_hook_R39eb31b4
c01e88f0 nf_register_sockopt_Rb312a693
c01e89e0 nf_unregister_sockopt_R4c9a7945
c01e8f30 nf_reinject_Red5ca73d
c01e8c30 nf_register_queue_handler_Rdd608478
c01e8c90 nf_unregister_queue_handler_R4df6e6de
c01e8df0 nf_hook_slow_R6a1f1dea
c02d82a0 nf_hooks_R078b1fd2
c01e8b50 nf_setsockopt_R874a4ee5
c01e8b80 nf_getsockopt_R0c2319b6
c02d8aa0 ip_ct_attach_R822245e7
c01e90b0 ip_route_me_harder_R6d77d6f4
c01e37f0 register_gifconf_Ra150c2d0
c01e3540 net_call_rx_atomic_Rf23efb98
c02a93c0 softnet_data_Rf17ce44b
c021a340 memparse_R23f2d36f
c021a2a0 get_option_Rb0e10781
c021a2f0 get_options_R0fbff9b9
c021a410 rb_insert_color_Raa2b5a22
c021a660 rb_erase_Rda226a80
c021a740 rwsem_down_read_failed
c021a860 rwsem_down_write_failed
c021a980 rwsem_wake
bsd_comp                4032   1 (autoclean)
ppp_async               6560   1 (autoclean)
ppp_generic            15948   3 (autoclean) [bsd_comp ppp_async]
slhc                    4672   1 (autoclean) [ppp_generic]
serial                 45472   2 (autoclean)
isa-pnp                28616   0 (autoclean) [serial]
ipt_LOG                 3136   1
ipt_state                608   1
ip_conntrack_ftp        3232   0 (unused)
ip_conntrack           13708   2 [ipt_state ip_conntrack_ftp]
iptable_filter          1760   1
ip_tables              10624   3 [ipt_LOG ipt_state iptable_filter]
sg                     24644   0 (autoclean)
scanner                 8512   0
usb-ohci               17888   0 (unused)
usbcore                56128   1 [scanner usb-ohci]
rtc                     5592   0 (autoclean)
tuner                   8388   1 (autoclean)
tvaudio                11232   0 (autoclean) (unused)
bttv                   67520   0 (unused)
i2c-algo-bit            7180   1 [bttv]
i2c-core               12992   0 [tuner tvaudio bttv i2c-algo-bit]
videodev                5792   3 [bttv]
analog                  7520   0 (unused)
es1371                 27072   1
soundcore               3684   4 [es1371]
ac97_codec              9728   0 [es1371]
gameport                1564   0 [analog es1371]
joydev                  6848   0 (unused)
input                   3424   0 [analog joydev]
sisfb                  88372  63
fbcon-cfb8              3488   0 [sisfb]
fbcon-cfb32             3840   0 [sisfb]
fbcon-cfb16             4096   0 [sisfb]
floppy                 45920   0 (autoclean)
sr_mod                 11896   0 (autoclean) (unused)
ide-scsi                7648   0
ide-cd                 27232   0
cdrom                  29248   0 (autoclean) [sr_mod ide-cd]
scsi_mod               53564   3 (autoclean) [sg sr_mod ide-scsi]
appletalk              19212   0 (autoclean)
ipx                    15892   0 (autoclean)
apm                     9288   2

--------------070301030504010909070806--

