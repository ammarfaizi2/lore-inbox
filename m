Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbSLOKvb>; Sun, 15 Dec 2002 05:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbSLOKva>; Sun, 15 Dec 2002 05:51:30 -0500
Received: from d3-262.dialup.ncport.ru ([213.134.222.3]:45060 "EHLO ask-me.ru")
	by vger.kernel.org with ESMTP id <S266347AbSLOKv0>;
	Sun, 15 Dec 2002 05:51:26 -0500
Date: Sun, 15 Dec 2002 13:58:07 +0300
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PCMCIA 3CCFE575 Card bugs
Message-ID: <20021215105807.GA2343@ask-me.ru>
Mail-Followup-To: =?koi8-r?B?0JzQsNC60YHQuNC8INCb0LDQv9GI0LjQvQ==?= <max@ask-me.ru>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.18
From: Max Lapshin <max@ask-me.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


   After long transmission, card blocks with the applied messages.
What's the matter with it? 

uname -a:
Linux armada 2.4.20 #1 Срд Ноя 27 16:34:58 MSK 2002 i586 unknown

ksyms: applied

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename=3c59x_report

eth0: transmit timed out, tx_status 00 status e000.
diagnostics: net 0cc2 media a800 dma 000000a0.
Flags; bus-master 1, dirty 24645(5) current 24661(5)
Transmit list 009f7340 vs. c09f7340.
0: @c09f7200  length 8000009e status 0000009e
1: @c09f7240  length 8000009e status 0000009e
2: @c09f7280  length 8000009e status 0000009e
3: @c09f72c0  length 8000009e status 8000009e
4: @c09f7300  length 8000004a status 8000004a
5: @c09f7340  length 8000009e status 0001009e
6: @c09f7380  length 8000009e status 0001009e
7: @c09f73c0  length 8000009e status 0000009e
8: @c09f7400  length 8000009e status 0000009e
9: @c09f7440  length 8000009e status 0000009e
10: @c09f7480  length 8000009e status 0000009e
11: @c09f74c0  length 8000009e status 0000009e
12: @c09f7500  length 8000009e status 0000009e
13: @c09f7540  length 8000009e status 0000009e
14: @c09f7580  length 8000009e status 0000009e
15: @c09f75c0  length 8000009e status 0000009e


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ksyms

Address   Symbol                            Defined by
c48575ec  sb_dev                            [sb]
c48575f4  opl_dev                           [sb]
c48575f0  mpu_dev                           [sb]
c4857000  __insmod_sb_O/lib/modules/2.4.20/kernel/drivers/sound/sb.o_M3DE4DACE_V132116  [sb]
c4857320  __insmod_sb_S.rodata_L395         [sb]
c4857060  __insmod_sb_S.text_L695           [sb]
c4857620  __insmod_sb_S.bss_L164            [sb]
c48575c0  __insmod_sb_S.data_L68            [sb]
c484e980  sb_dsp_init_Re986438b             [sb_lib]
c484e6ac  sb_dsp_detect_Rd8a2731c           [sb_lib]
c484eed4  sb_dsp_unload_Rc4884969           [sb_lib]
c484eecc  sb_dsp_disable_midi_R732f38df     [sb_lib]
c48555e4  sb_be_quiet_R42424109             [sb_lib]
c484f41c  probe_sbmpu_Rddc8ad00             [sb_lib]
c484f56c  unload_sbmpu_R74afd69c            [sb_lib]
c48555f0  smw_free_R450f9aea                [sb_lib]
c484e000  __insmod_sb_lib_O/lib/modules/2.4.20/kernel/drivers/sound/sb_lib.o_M3DE4DACE_V132116  [sb_lib]
c484e060  __insmod_sb_lib_S.text_L19352     [sb_lib]
c4852c20  __insmod_sb_lib_S.rodata_L3650    [sb_lib]
c4853c80  __insmod_sb_lib_S.data_L6496      [sb_lib]
c48555e0  __insmod_sb_lib_S.bss_L2222       [sb_lib]
c484b394  probe_uart401_R63d781ea           [uart401]
c484b678  unload_uart401_Recfdd9c9          [uart401]
c484b108  uart401intr_R6391d066             [uart401]
c484b000  __insmod_uart401_O/lib/modules/2.4.20/kernel/drivers/sound/uart401.o_M3DE4DACE_V132116  [uart401]
c484b060  __insmod_uart401_S.text_L1827     [uart401]
c484b7a0  __insmod_uart401_S.rodata_L864    [uart401]
c484bc60  __insmod_uart401_S.data_L2780     [uart401]
c484c740  __insmod_uart401_S.bss_L68        [uart401]
c4833000  __insmod_3c59x_O/lib/modules/2.4.20/kernel/drivers/net/3c59x.o_M3DE4DACC_V132116  [3c59x]
c4839108  __insmod_3c59x_S.bss_L40          [3c59x]
c4836d80  __insmod_3c59x_S.rodata_L6867     [3c59x]
c4838960  __insmod_3c59x_S.data_L1960       [3c59x]
c4833060  __insmod_3c59x_S.text_L15621      [3c59x]
c4824000  __insmod_ipchains_O/lib/modules/2.4.20/kernel/net/ipv4/netfilter/ipchains.o_M3DE4DAD6_V132116  [ipchains]
c4824060  __insmod_ipchains_S.text_L30070   [ipchains]
c482b5e0  __insmod_ipchains_S.rodata_L3526  [ipchains]
c482c4c0  __insmod_ipchains_S.data_L1756    [ipchains]
c482cb9c  __insmod_ipchains_S.bss_L40       [ipchains]

--bg08WKrSYDhXBjb5--
