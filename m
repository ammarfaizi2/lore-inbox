Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263189AbTCLOMA>; Wed, 12 Mar 2003 09:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbTCLOMA>; Wed, 12 Mar 2003 09:12:00 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:34722 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263189AbTCLOL6>; Wed, 12 Mar 2003 09:11:58 -0500
Date: Wed, 12 Mar 2003 15:22:43 +0100
From: =?unknown-8bit?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: top stack (l)users for 2.5.64
Message-ID: <20030312142243.GC27966@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

51 functions using >=1k of kernel stack on i386.

The top two somehow got lost in my 2.5.63 posting, the rest is largely
unchanged.

0xc0205db6 presto_get_fileid:                            sub    $0x1168,%esp
0xc0204986 presto_copy_kml_tail:                         sub    $0x101c,%esp
0xc07baab8 isp2x00_make_portdb:                          sub    $0xc38,%esp
0xc0822c36 i2o_proc_read_ddm_table:                      sub    $0xb48,%esp
0xc087b295 cdromread:                                    sub    $0xa84,%esp
0xc0768008 ide_unregister:                               sub    $0x978,%esp
0xc07254eb v4l_compat_translate_ioctl:                   sub    $0x924,%esp
0xc0b4f686 snd_emu10k1_fx8010_ioctl:                     sub    $0x82c,%esp
0xc06d4746 writerids:                                    sub    $0x828,%esp
0xc0827ab6 i2o_proc_read_lan_alt_addr:                   sub    $0x820,%esp
0xc0826c96 i2o_proc_read_lan_mcast_addr:                 sub    $0x820,%esp
0xc0823616 i2o_proc_read_groups:                         sub    $0x814,%esp
0xc06d4596 readrids:                                     sub    $0x810,%esp
0xc0af14e6 snd_cmipci_ac3_copy:                          sub    $0x7b0,%esp
0xc0af1a4b snd_cmipci_ac3_silence:                       sub    $0x7b0,%esp
0xc088a906 amd_flash_probe:                              sub    $0x708,%esp
0xc01055ae huft_build:                                   sub    $0x5ac,%esp
0xc01071ae huft_build:                                   sub    $0x5ac,%esp
0xc02a903b dohash:                                       sub    $0x58c,%esp
0xc0aaa74b snd_pcm_oss_change_params:                    sub    $0x584,%esp
0xc0558166 ida_ioctl:                                    sub    $0x540,%esp
0xc0108016 inflate_dynamic:                              sub    $0x540,%esp
0xc01063c6 inflate_dynamic:                              sub    $0x524,%esp
0xc0c9a1b6 device_new_if:                                sub    $0x51c,%esp
0xc01fc276 presto_ioctl:                                 sub    $0x500,%esp
0xc0b4b32a snd_emu10k1_add_controls:                     sub    $0x4e4,%esp
0xc0b698f6 snd_trident_mixer:                            sub    $0x4a8,%esp
0xc01a8b23 elf_core_dump:                                sub    $0x4a4,%esp
0xc077c5c2 ide_config:                                   sub    $0x494,%esp
0xc0107e80 inflate_fixed:                                sub    $0x490,%esp
0xc0106230 inflate_fixed:                                sub    $0x490,%esp
0xc0c8853b br_ioctl_device:                              sub    $0x490,%esp
0xc09b0ad1 uinput_alloc_device:                          sub    $0x480,%esp
0xc044fd82 parport_config:                               sub    $0x480,%esp
0xc09aa806 sw_connect:                                   sub    $0x480,%esp
0xc040a10e sha512_transform:                             sub    $0x458,%esp
0xc0d85676 sctp_hash_digest:                             sub    $0x458,%esp
0xc0d1a4c0 gss_pipe_downcall:                            sub    $0x440,%esp
0xc036c4b0 ciGetLeafPrefixKey:                           sub    $0x424,%esp
0xc0990de6 emi26_load_firmware:                          sub    $0x418,%esp
0xc06b6116 wv_hw_reset:                                  sub    $0x410,%esp
0xc12f4f32 root_nfs_name:                                sub    $0x408,%esp
0xc02ee669 jffs2_rtime_compress:                         sub    $0x404,%esp
0xc02ee757 jffs2_rtime_decompress:                       sub    $0x404,%esp
0xc03f8a35 befs_debug:                                   sub    $0x400,%esp
0xc03f89ee befs_warning:                                 sub    $0x400,%esp
0xc09dd4fc dtl1_config:                                  sub    $0x400,%esp
0xc09dec52 bt3c_config:                                  sub    $0x400,%esp
0xc03f899e befs_error:                                   sub    $0x400,%esp
0xc09e27a2 btuart_config:                                sub    $0x400,%esp
0xc06797e1 hex_dump:                                     sub    $0x400,%esp

Jörn

-- 
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu
