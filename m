Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVDGWmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVDGWmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 18:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVDGWmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 18:42:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:31399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262279AbVDGWmk (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 18:42:40 -0400
Date: Thu, 7 Apr 2005 15:42:34 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: derek.cheung@sympatico.ca, akpm@osdl.org, greg@kroah.com,
       Linux-kernel@vger.kernel.org
Subject: [PATCH] Add dontdiff file
Message-Id: <20050407154234.09ccccea.rddunlap@osdl.org>
In-Reply-To: <20050407223751.GL25554@waste.org>
References: <003901c53a51$0093b7d0$1501a8c0@Mainframe>
	<42535323.8040403@osdl.org>
	<20050407223751.GL25554@waste.org>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005 15:37:51 -0700 Matt Mackall wrote:

| On Tue, Apr 05, 2005 at 08:10:27PM -0700, Randy.Dunlap wrote:
| > There is a fairly up-to-date dontdiff file available at
| > http://developer.osdl.org/rddunlap/doc/dontdiff-osdl
| 
| Can we stash a copy in Documentation?

certainly.


Add a current 'dontdiff' file for use with 'diff -X dontdiff'.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 Documentation/dontdiff |  137 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 137 insertions(+)

diff -Naurp ./Documentation/dontdiff~add_dontdiff ./Documentation/dontdiff
--- ./Documentation/dontdiff~add_dontdiff	2005-04-07 15:39:51.000000000 -0700
+++ ./Documentation/dontdiff	2005-03-01 16:07:56.000000000 -0800
@@ -0,0 +1,137 @@
+.*
+*~
+53c8xx_d.h*
+*.a
+aic7*reg.h*
+aic7*seq.h*
+aic7*reg_print.c*
+53c700_d.h
+aicasm
+aicdb.h*
+asm
+asm_offsets.*
+autoconf.h*
+*.aux
+bbootsect
+*.bin
+bin2c
+binkernel.spec
+BitKeeper
+bootsect
+bsetup
+btfixupprep
+build
+bvmlinux
+bzImage*
+ChangeSet
+classlist.h*
+compile.h*
+comp*.log
+config
+config-*
+config_data.h*
+conmakehash
+consolemap_deftbl.c*
+COPYING
+CREDITS
+.cscope
+*cscope*
+cscope.*
+*.out
+*.css
+CVS
+defkeymap.c*
+devlist.h*
+docproc
+dummy_sym.c*
+*.dvi
+*.eps
+filelist
+fixdep
+fore200e_mkfirm
+fore200e_pca_fw.c*
+gen-devlist
+gen_init_cpio
+gen_crc32table
+crc32table.h*
+*.cpio
+gen-kdb_cmds.c*
+gentbl
+genksyms
+*.gif
+*.gz
+*.html
+ikconfig.h*
+initramfs_list
+*.jpeg
+kconfig
+kconfig.tk
+Kerntypes
+keywords.c*
+ksym.c*
+ksym.h*
+kallsyms
+mk_elfconfig
+elfconfig.h*
+modpost
+pnmtologo
+logo_*.c
+*.log
+lex.c*
+logo_*_clut224.c
+logo_*_mono.c
+lxdialog
+make_times_h
+map
+mkdep
+*_MODULES
+MODS.txt
+modversions.h*
+Module.symvers
+*.mod.c
+*.o
+*.ko
+*.orig
+*.lst
+*.grp
+*.grep
+oui.c*
+mktables
+raid6tables.c
+raid6int*.c
+raid6altivec*.c
+wanxlfw.inc
+maui_boot.h
+pss_boot.h
+trix_boot.h
+*.pdf
+parse.c*
+parse.h*
+PENDING
+ppc_defs.h*
+promcon_tbl.c*
+*.png
+*.ps
+*.rej
+SCCS
+setup
+*.s
+*.so
+*.sgml
+sim710_d.h*
+sm_tbl*
+split-include
+System.map*
+tags
+TAGS
+*.tex
+times.h*
+tkparse
+*.ver
+version.h*
+*_vga16.c
+vmlinux
+vmlinux.lds
+vmlinux-*
+vsyscall.lds
+zImage



---
