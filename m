Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbTF3K7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 06:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbTF3K7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 06:59:36 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:32215 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265835AbTF3K7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 06:59:30 -0400
Message-Id: <5.1.0.14.2.20030630102438.00af53d0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 30 Jun 2003 13:14:08 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.4.22pre2 + cset1040 compile errors/warnings
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: XRcZAsZGYeale95hWQHCeeJs5oHwyuKitn82KtcyS4U0aBNjQQZPwZ@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

         Per subject with GCC 3.3
         I don't know if the comparison warning is false or not.


vt.c: In function `do_kdsk_ioctl':
vt.c:166: warning: comparison is always false due to limited range of data type
vt.c: In function `do_kdgkb_ioctl':
vt.c:283: warning: comparison is always false due to limited range of data type

keyboard.c: In function `do_fn':
keyboard.c:644: warning: comparison is always true due to limited range of 
data type

efi.c: In function `is_gpt_valid':
efi.c:347: warning: integer constant is too large for "long" type

svcsock.c: In function `svc_tcp_recvfrom':
svcsock.c:830: warning: int format, long unsigned int arg (arg 3)

ma600.c:51:22: warning: extra tokens at end of #undef directive
ma600.c: In function `ma600_init':
ma600.c:89: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
ma600.c: In function `ma600_cleanup':
ma600.c:95: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
ma600.c: In function `ma600_open':
ma600.c:108: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
ma600.c: In function `ma600_close':
ma600.c:126: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
ma600.c: In function `ma600_change_speed':
ma600.c:187: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
ma600.c:189:40: pasting ";" and "return" does not give a valid 
preprocessing token
ma600.c:192: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
ma600.c:218: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
ma600.c:249: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
ma600.c:257: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
ma600.c:276: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
ma600.c: In function `ma600_reset':
ma600.c:301: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
ma600.c:303:40: pasting ";" and "return" does not give a valid 
preprocessing token
ma600.c:306: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
ma600.c:329: warning: concatenation of string literals with __FUNCTION__ is 
deprecated
ma600.c: At top level:
/home/linux-2.4.21/include/linux/module.h:299: warning: 
`__module_kernel_version' defined
  but not used
ma600.c:339: warning: `__module_license' defined but not used
make[3]: *** [ma600.o] Error 1



horizon.c: In function `hrz_check_args':
horizon.c:2926: warning: comparison is always false due to limited range of 
data type

cciss.c: In function `cciss_ioctl':
cciss.c:756: warning: comparison is always false due to limited range of 
data type
cciss.c: In function `cciss_init_one':
cciss.c:2838: warning: integer constant is too large for "long" type

cpqphp_pci.c:394: warning: comparison is always true due to limited range 
of data type
cpqphp_pci.c:406: warning: comparison is always true due to limited range 
of data type

isdn_ppp.c:617: warning: comparison is always true due to limited range of 
data type

fourbri.c:361: warning: comparison is always true due to limited range of 
data type
fourbri.c:374: warning: comparison is always false due to limited range of 
data type

cpia.c:1686: warning: comparison is always false due to limited range of 
data type
cpia.c:1688: warning: comparison is always false due to limited range of 
data type
cpia.c:1690: warning: comparison is always false due to limited range of 
data type
cpia.c:1692: warning: comparison is always false due to limited range of 
data type

ftl.c:286: warning: comparison is always false due to limited range of data 
type

ppp_generic.c:662: warning: comparison is always true due to limited range 
of data type

bond_alb.c:1267: warning: comparison is always true due to limited range of 
data type

iph5526.c:3599: warning: comparison is always true due to limited range of 
data type

applicom.c:268:2: warning: #warning "LEAK"
applicom.c:532:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"

sdla_chdlc.c:594:43: missing terminating " character
sdla_chdlc.c: In function `wpc_init':
sdla_chdlc.c:595: error: parse error before "Failed"
sdla_chdlc.c:595: error: stray '\' in program
sdla_chdlc.c:595:68: missing terminating " character
/home/linux-2.4.21/include/asm/io.h: At top level:
/home/linux-2.4.21/include/linux/module.h:299: warning: 
`__module_kernel_version' defined
  but not used
sdla_chdlc.c:4747: warning: `__module_license' defined but not used
make[3]: *** [sdla_chdlc.o] Error


3c359.c:468: warning: comparison is always true due to limited range of 
data type

sbni.c: In function `calc_crc32':
sbni.c:1558: error: asm-specifier for variable `_crc' conflicts with asm 
clobber list
make[3]: *** [sbni.o] Error 1

cs46xx.c:950: error: long, short, signed or unsigned used invalidly for `off'
cs46xx.c:951: error: long, short, signed or unsigned used invalidly for `val'
cs46xx.c: In function `cs_ac97_init':
cs46xx.c:4263: warning: comparison is always false due to limited range of 
data type
make[2]: *** [cs46xx.o] Error 1

scc.c: In function `t_tail':
scc.c:1206: warning: comparison is always true due to limited range of data 
type
scc.c: In function `t_idle':
scc.c:1286: warning: comparison is always true due to limited range of data 
type

i82365.c: In function `i365_set_io_map':
i82365.c:1290: warning: comparison is always false due to limited range of 
data type
i82365.c:1290: warning: comparison is always false due to limited range of 
data type

i82092.c: In function `i82092aa_set_io_map':
i82092.c:791: warning: comparison is always false due to limited range of 
data type
i82092.c:791: warning: comparison is always false due to limited range of 
data type

tcic.c: In function `tcic_set_io_map':
tcic.c:847: warning: comparison is always false due to limited range of 
data type
tcic.c:847: warning: comparison is always false due to limited range of 
data type

AM53C974.c: In function `AM53C974_information_transfer':
AM53C974.c:1615: warning: comparison is always true due to limited range of 
data type

ali5455.c: In function `ali_ac97_init':
ali5455.c:3280: warning: comparison is always false due to limited range of 
data type

ad1889.c: In function `ad1889_ac97_init':
ad1889.c:850: warning: comparison is always false due to limited range of 
data type

ymfpci.c: In function `ymf_ac97_init':
ymfpci.c:2463: warning: comparison is always false due to limited range of 
data type

i810_audio.c: In function `i810_ac97_init':
i810_audio.c:2924: warning: comparison is always false due to limited range 
of data type

ir.c: In function `coda_venus_readdir':
dir.c:588: warning: comparison is always false due to limited range of data 
type

ioctl.c: In function `smb_ioctl':
ioctl.c:35: warning: comparison is always false due to limited range of 
data type
ioctl.c:35: warning: comparison is always false due to limited range of 
data type
ioctl.c:35: warning: comparison is always false due to limited range of 
data type
ioctl.c:35: warning: comparison is always false due to limited range of 
data type

af_irda.c: In function `irda_setsockopt':
af_irda.c:1913: warning: comparison is always false due to limited range of 
data type


depmod: *** Unresolved symbols in 
/lib/modules/2.4.22-pre2/kernel/fs/hfsplus/hfsplus.o
depmod:         mark_page_accessed


         Margit

