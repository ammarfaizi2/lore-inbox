Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264634AbTFYQTQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 12:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbTFYQTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 12:19:16 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:59032 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264634AbTFYQTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 12:19:11 -0400
Date: Wed, 25 Jun 2003 18:33:22 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: top stack users for 2.5.73
Message-ID: <20030625163322.GB1770@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

44 functions for 2.5.67.
45 functions for 2.5.68
41 functions for 2.5.69
36 functions for 2.5.70
32 functions for 2.5.71
29 functions for 2.5.73

Mostly harmless. :)

Five functions dropped below the threshold of 1k, two grew a bit above
it.  Most functions tended to loose a couple of bytes, so in general
there was some improvement.

P 0xc0204c1b presto_get_fileid:                            sub    $0x116c,%esp
P 0xc020378b presto_copy_kml_tail:                         sub    $0x1018,%esp
0xc07ffd83 ide_unregister:                               sub    $0x95c,%esp
0xc07699bb w9966_v4l_read:                               sub    $0x81c,%esp
0xc0c8096b snd_emu10k1_fx8010_ioctl:                     sub    $0x818,%esp
0xc0c25a57 snd_cmipci_ac3_copy:                          sub    $0x7a4,%esp
0xc0c25ffb snd_cmipci_ac3_silence:                       sub    $0x79c,%esp
0xc029b90b dohash:                                       sub    $0x5c4,%esp
0xc0105543 huft_build:                                   sub    $0x5b0,%esp
0xc01070d3 huft_build:                                   sub    $0x5b0,%esp
0xc0107f27 inflate_dynamic:                              sub    $0x538,%esp
0xc0106387 inflate_dynamic:                              sub    $0x528,%esp
0xc0c7c5b3 snd_emu10k1_add_controls:                     sub    $0x4dc,%esp
0xc01fb563 presto_ioctl:                                 sub    $0x4cc,%esp
0xc0c9d2cf snd_trident_mixer:                            sub    $0x4a4,%esp
0xc0106217 inflate_fixed:                                sub    $0x490,%esp
0xc0107dbb inflate_fixed:                                sub    $0x490,%esp
0xc081319b ide_config:                                   sub    $0x47c,%esp
0xc0534693 parport_config:                               sub    $0x460,%esp
0xc0abbccf ixj_config:                                   sub    $0x460,%esp
0xc0e39d03 gss_pipe_downcall:                            sub    $0x42c,%esp
0xc0a16c73 isd200_action:                                sub    $0x428,%esp
0xc03f9ce3 sha512_transform:                             sub    $0x418,%esp
0xc06d7053 arlan_sysctl_info:                            sub    $0x414,%esp
0xc035b51b ciGetLeafPrefixKey:                           sub    $0x410,%esp
0xc163bc9f root_nfs_name:                                sub    $0x408,%esp
0xc03e96b3 befs_error:                                   sub    $0x400,%esp
0xc03e96ff befs_warning:                                 sub    $0x400,%esp
0xc03e974b befs_debug:                                   sub    $0x400,%esp


Jörn

-- 
"Security vulnerabilities are here to stay."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001
