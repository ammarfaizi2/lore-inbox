Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTGFQCY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTGFQCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:02:23 -0400
Received: from [213.39.233.138] ([213.39.233.138]:41688 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262464AbTGFQCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:02:22 -0400
Date: Sun, 6 Jul 2003 18:16:54 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: top stack users for 2.5.74
Message-ID: <20030706161654.GA25901@wohnheim.fh-wedel.de>
References: <20030625163322.GB1770@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030625163322.GB1770@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

44 functions for 2.5.67
45 functions for 2.5.68
41 functions for 2.5.69
36 functions for 2.5.70
32 functions for 2.5.71
29 functions for 2.5.73
32 functions for 2.5.74

Basically unchanged.  In 2.5.73, most functions lost a few bytes and a
couple dropped below the 1k limit, this time most functions gained a
few bytes.  sha512_transform and arlan_sysctl_info both improved a
great deal, but others filled the gaps.

0xc02318b6 presto_get_fileid:                            sub    $0x119c,%esp
0xc0230076 presto_copy_kml_tail:                         sub    $0x1028,%esp
0xc0935a08 ide_unregister:                               sub    $0x96c,%esp
0xc0e8c413 snd_emu10k1_fx8010_ioctl:                     sub    $0x830,%esp
0xc0880616 w9966_v4l_read:                               sub    $0x828,%esp
0xc0e1cfab snd_cmipci_ac3_silence:                       sub    $0x7c0,%esp
0xc0e1c9f6 snd_cmipci_ac3_copy:                          sub    $0x7b8,%esp
0xc0105650 huft_build:                                   sub    $0x59c,%esp
0xc01073d0 huft_build:                                   sub    $0x59c,%esp
0xc02e4396 dohash:                                       sub    $0x594,%esp
0xc0108256 inflate_dynamic:                              sub    $0x554,%esp
0xc01064a6 inflate_dynamic:                              sub    $0x538,%esp
0xc0226096 presto_ioctl:                                 sub    $0x504,%esp
0xc0e866ba snd_emu10k1_add_controls:                     sub    $0x4dc,%esp
0xc0eae4d6 snd_trident_mixer:                            sub    $0x4c0,%esp
0xc0106307 inflate_fixed:                                sub    $0x4ac,%esp
0xc01080b7 inflate_fixed:                                sub    $0x4ac,%esp
0xc094ca11 ide_config:                                   sub    $0x4a8,%esp
0xc05e9f7c parport_config:                               sub    $0x490,%esp
0xc0c6ffb3 ixj_config:                                   sub    $0x484,%esp
0xc0ba9ae0 isd200_action:                                sub    $0x454,%esp
0xc109a21e gss_pipe_downcall:                            sub    $0x44c,%esp
0xc03c1a68 ciGetLeafPrefixKey:                           sub    $0x428,%esp
0xc0468c73 befs_error:                                   sub    $0x418,%esp
0xc0468ce3 befs_warning:                                 sub    $0x418,%esp
0xc0468d53 befs_debug:                                   sub    $0x418,%esp
0xc07dbde6 wv_hw_reset:                                  sub    $0x418,%esp
0xc16e0915 root_nfs_name:                                sub    $0x414,%esp
0xc0c93a12 bt3c_config:                                  sub    $0x410,%esp
0xc0c97b32 btuart_config:                                sub    $0x410,%esp
0xc0c91fef dtl1_config:                                  sub    $0x408,%esp
0xc0c95e06 bluecard_config:                              sub    $0x408,%esp

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
