Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbTFSLeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 07:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbTFSLeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 07:34:12 -0400
Received: from first.knowledge.no ([193.212.174.4]:62442 "EHLO knowledge.no")
	by vger.kernel.org with ESMTP id S265772AbTFSLeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 07:34:09 -0400
Date: Thu, 19 Jun 2003 13:48:07 +0200
From: Magnus Solvang <magnus@solvang.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: isdn compile-errors (Linux 2.5.72)
Message-ID: <20030619114807.GD3991@first.knowledge.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.70, justed patched to 2.5.71 (not compiled) and to 2.5.72:

# make
[...]
  CC [M]  drivers/isdn/capi/kcapi.o
drivers/isdn/capi/kcapi.c: In function `notify_push':
drivers/isdn/capi/kcapi.c:212: warning: `MOD_INC_USE_COUNT' is deprecated (decla
red at include/linux/module.h:478)
drivers/isdn/capi/kcapi.c:215: warning: `MOD_DEC_USE_COUNT' is deprecated (decla
red at include/linux/module.h:490)
drivers/isdn/capi/kcapi.c:229: warning: `MOD_INC_USE_COUNT' is deprecated (decla
red at include/linux/module.h:478)
drivers/isdn/capi/kcapi.c:231: warning: `MOD_DEC_USE_COUNT' is deprecated (decla
red at include/linux/module.h:490)
drivers/isdn/capi/kcapi.c: In function `notify_handler':
drivers/isdn/capi/kcapi.c:289: warning: `MOD_DEC_USE_COUNT' is deprecated (decla
red at include/linux/module.h:490)
drivers/isdn/capi/kcapi.c:291: warning: `MOD_DEC_USE_COUNT' is deprecated (decla
red at include/linux/module.h:490)
  CC [M]  drivers/isdn/capi/capiutil.o
  CC [M]  drivers/isdn/capi/capilib.o
  CC [M]  drivers/isdn/capi/kcapi_proc.o
  LD [M]  drivers/isdn/capi/kernelcapi.o
  CC [M]  drivers/isdn/hisax/config.o
  CC [M]  drivers/isdn/hisax/isdnl1.o
  CC [M]  drivers/isdn/hisax/tei.o
  CC [M]  drivers/isdn/hisax/isdnl2.o
  CC [M]  drivers/isdn/hisax/isdnl3.o
  CC [M]  drivers/isdn/hisax/lmgr.o
  CC [M]  drivers/isdn/hisax/q931.o
  CC [M]  drivers/isdn/hisax/callc.o
  CC [M]  drivers/isdn/hisax/fsm.o
  CC [M]  drivers/isdn/hisax/cert.o
  CC [M]  drivers/isdn/hisax/diva.o
drivers/isdn/hisax/diva.c:656: warning: `diva_ipacx_pci_probe' defined but not u
sed
  CC [M]  drivers/isdn/hisax/isac.o
  CC [M]  drivers/isdn/hisax/arcofi.o
  CC [M]  drivers/isdn/hisax/hscx.o
  CC [M]  drivers/isdn/hisax/ipac.o
  CC [M]  drivers/isdn/hisax/ipacx.o
  LD [M]  drivers/isdn/hisax/hisax.o
  CC [M]  drivers/isdn/i4l/isdn_net_lib.o
  CC [M]  drivers/isdn/i4l/isdn_fsm.o
  CC [M]  drivers/isdn/i4l/isdn_tty.o
drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_write':
drivers/isdn/i4l/isdn_tty.c:1198: warning: unused variable `m'
drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_open':
drivers/isdn/i4l/isdn_tty.c:1733: warning: `MOD_INC_USE_COUNT' is deprecated (de
clared at include/linux/module.h:478)
drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_close':
drivers/isdn/i4l/isdn_tty.c:1862: warning: `MOD_DEC_USE_COUNT' is deprecated (de
clared at include/linux/module.h:490)
drivers/isdn/i4l/isdn_tty.c: In function `modem_write_profile':
drivers/isdn/i4l/isdn_tty.c:1986: warning: implicit declaration of function `gro
up_send_sig_info'
drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_init':
drivers/isdn/i4l/isdn_tty.c:2099: invalid type argument of `->'
drivers/isdn/i4l/isdn_tty.c:2101: invalid type argument of `->'
drivers/isdn/i4l/isdn_tty.c:2102: invalid type argument of `->'
drivers/isdn/i4l/isdn_tty.c:2098: warning: label `err_unregister_tty' defined bu
t not used
drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_exit':
drivers/isdn/i4l/isdn_tty.c:2121: invalid type argument of `->'
drivers/isdn/i4l/isdn_tty.c:2122: invalid type argument of `->'
drivers/isdn/i4l/isdn_tty.c:2123: invalid type argument of `->'
drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_check_esc':
drivers/isdn/i4l/isdn_tty.c:2572: warning: comparison of distinct pointer types 
lacks a cast
drivers/isdn/i4l/isdn_tty.c:2575: warning: comparison of distinct pointer types 
lacks a cast
make[3]: *** [drivers/isdn/i4l/isdn_tty.o] Error 1
make[2]: *** [drivers/isdn/i4l] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2

- M
