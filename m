Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129506AbRCSHvF>; Mon, 19 Mar 2001 02:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbRCSHuz>; Mon, 19 Mar 2001 02:50:55 -0500
Received: from csl.Stanford.EDU ([171.64.66.149]:18110 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S129506AbRCSHuq>;
	Mon, 19 Mar 2001 02:50:46 -0500
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200103190749.XAA24359@csl.Stanford.EDU>
Subject: [CHECKER] 10 additional >= 1K stack variables
To: linux-kernel@vger.kernel.org
Date: Sun, 18 Mar 2001 23:49:52 -0800 (PST)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after some config problems were fixed, there were 10 additional stack
variables found that were >= 1K in size.   (Though the two tty_io* ones 
are already known.)

Dawson

/u2/engler/mc/oses/linux/2.4.1/drivers/char/tty_io.c:2030:tty_unregister_devfs: ERROR:VAR:2030:2030: suspicious var 'tty' = 3112 bytes
/u2/engler/mc/oses/linux/2.4.1/drivers/char/tty_io.c:1995:tty_register_devfs: ERROR:VAR:1995:1995: suspicious var 'tty' = 3112 bytes
/u2/engler/mc/oses/linux/2.4.1/drivers/i2o/i2o_proc.c:2492:i2o_proc_read_lan_alt_addr: ERROR:VAR:2492:2492: suspicious var 'result' = 2060 bytes
/u2/engler/mc/oses/linux/2.4.1/net/irda/af_irda.c:1743:irda_setsockopt: ERROR:VAR:1743:1743: suspicious var 'ias_opt' = 1356 bytes
/u2/engler/mc/oses/linux/2.4.1/net/irda/af_irda.c:1981:irda_getsockopt: ERROR:VAR:1981:1981: suspicious var 'ias_opt' = 1356 bytes
/u2/engler/mc/oses/linux/2.4.1/drivers/block/../../lib/inflate.c:750:inflate_dynamic: ERROR:VAR:750:750: suspicious var 'll' = 1264 bytes
/u2/engler/mc/oses/linux/2.4.1/drivers/block/../../lib/inflate.c:301:huft_build: ERROR:VAR:301:301: suspicious var 'v' = 1152 bytes
/u2/engler/mc/oses/linux/2.4.1/drivers/block/../../lib/inflate.c:688:inflate_fixed: ERROR:VAR:688:688: suspicious var 'l' = 1152 bytes
/u2/engler/mc/oses/linux/2.4.1/fs/devfs/base.c:3156:devfsd_read: ERROR:VAR:3156:3156: suspicious var 'info' = 1056 bytes
/u2/engler/mc/oses/linux/2.4.1/drivers/net/wan/cycx_x25.c:983:hex_dump: ERROR:VAR:983:983: suspicious var 'hex' = 1024 bytes
