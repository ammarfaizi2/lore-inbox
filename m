Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263394AbTCNRRn>; Fri, 14 Mar 2003 12:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263397AbTCNRRn>; Fri, 14 Mar 2003 12:17:43 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:25760 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263394AbTCNRRi>; Fri, 14 Mar 2003 12:17:38 -0500
Date: Fri, 14 Mar 2003 18:28:21 +0100
From: Joern Engel <joern@wohnheim.fh-wedel.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Top stack (l)users for 2.5.64-ac4
Message-ID: <20030314172820.GH23161@wohnheim.fh-wedel.de>
References: <200303141509.h2EF9R017016@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200303141509.h2EF9R017016@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

47 functions using >=1k of kernel stack on i386.

One improvement over 2.5.64, i2o_proc_* is gone. 4 down, 47 to go. :)

0xc02063f6 presto_get_fileid:                            sub    $0x1168,%esp
0xc0204fc6 presto_copy_kml_tail:                         sub    $0x101c,%esp
0xc07b92c8 isp2x00_make_portdb:                          sub    $0xc38,%esp
0xc0879c05 cdromread:                                    sub    $0xa84,%esp
0xc0766a08 ide_unregister:                               sub    $0x978,%esp
0xc07240db v4l_compat_translate_ioctl:                   sub    $0x924,%esp
0xc0b4e2e6 snd_emu10k1_fx8010_ioctl:                     sub    $0x82c,%esp
0xc06d3396 writerids:                                    sub    $0x828,%esp
0xc06d31e6 readrids:                                     sub    $0x810,%esp
0xc0af06ab snd_cmipci_ac3_silence:                       sub    $0x7b0,%esp
0xc0af0146 snd_cmipci_ac3_copy:                          sub    $0x7b0,%esp
0xc0889206 amd_flash_probe:                              sub    $0x708,%esp
0xc01055ae huft_build:                                   sub    $0x5ac,%esp
0xc01071ae huft_build:                                   sub    $0x5ac,%esp
0xc02a96ab dohash:                                       sub    $0x58c,%esp
0xc0aa93ab snd_pcm_oss_change_params:                    sub    $0x584,%esp
0xc0108016 inflate_dynamic:                              sub    $0x540,%esp
0xc0557fc6 ida_ioctl:                                    sub    $0x540,%esp
0xc01063c6 inflate_dynamic:                              sub    $0x524,%esp
0xc0c98e36 device_new_if:                                sub    $0x51c,%esp
0xc01fc8b6 presto_ioctl:                                 sub    $0x500,%esp
0xc0b49f8a snd_emu10k1_add_controls:                     sub    $0x4e4,%esp
0xc0b68556 snd_trident_mixer:                            sub    $0x4a8,%esp
0xc01a8d93 elf_core_dump:                                sub    $0x4a4,%esp
0xc077b002 ide_config:                                   sub    $0x494,%esp
0xc0107e80 inflate_fixed:                                sub    $0x490,%esp
0xc0c871bb br_ioctl_device:                              sub    $0x490,%esp
0xc0106230 inflate_fixed:                                sub    $0x490,%esp
0xc0450482 parport_config:                               sub    $0x480,%esp
0xc09a9116 sw_connect:                                   sub    $0x480,%esp
0xc09af3e1 uinput_alloc_device:                          sub    $0x480,%esp
0xc040a77e sha512_transform:                             sub    $0x458,%esp
0xc0d84296 sctp_hash_digest:                             sub    $0x458,%esp
0xc0d19040 gss_pipe_downcall:                            sub    $0x440,%esp
0xc036cb20 ciGetLeafPrefixKey:                           sub    $0x424,%esp
0xc098f6f6 emi26_load_firmware:                          sub    $0x418,%esp
0xc06b4d66 wv_hw_reset:                                  sub    $0x410,%esp
0xc12f2f82 root_nfs_name:                                sub    $0x408,%esp
0xc02eedc7 jffs2_rtime_decompress:                       sub    $0x404,%esp
0xc02eecd9 jffs2_rtime_compress:                         sub    $0x404,%esp
0xc0678431 hex_dump:                                     sub    $0x400,%esp
0xc09dbe1c dtl1_config:                                  sub    $0x400,%esp
0xc09dd572 bt3c_config:                                  sub    $0x400,%esp
0xc03f90a5 befs_debug:                                   sub    $0x400,%esp
0xc03f905e befs_warning:                                 sub    $0x400,%esp
0xc03f900e befs_error:                                   sub    $0x400,%esp
0xc09e10c2 btuart_config:                                sub    $0x400,%esp


Jörn

-- 
"Error protection by error detection and correction."
-- from a university class
