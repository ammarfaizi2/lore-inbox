Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTGCN5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 09:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTGCN5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 09:57:01 -0400
Received: from franka.aracnet.com ([216.99.193.44]:37838 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263152AbTGCN44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 09:56:56 -0400
Date: Thu, 03 Jul 2003 07:11:13 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 868] New: Files missing?
Message-ID: <45000000.1057241473@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=868

           Summary: Files missing?
    Kernel Version: 2.5.73,2.5.74
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: midian@ihme.org


Distribution: Debian
Hardware Environment: AMD Athlon 2000+, 512 SDRAM
Software Environment:
Problem Description: Missing files in kernel?

Steps to reproduce: wget http://www.kernel.org/pub/linux/kernel/v2.5/linux-2.5.
74.tar.bz2 && tar xjvf linux-2.5.74.tar.bz2 && cp linux-2.4.22-pre2/.config 
linux-2.5.74/. && cd linux-2.5.74/ && make oldconfig && make menuconfig && make 
all (And the same with 2.5.73, I have not tested the earlier versions.)

Error message: CC [M]  drivers/video/pm2fb.o
drivers/video/pm2fb.c:44:25: video/fbcon.h: No such file or directory
drivers/video/pm2fb.c:45:30: video/fbcon-cfb8.h: No such file or directory
drivers/video/pm2fb.c:46:31: video/fbcon-cfb16.h: No such file or directory
drivers/video/pm2fb.c:47:31: video/fbcon-cfb24.h: No such file or directory
drivers/video/pm2fb.c:48:31: video/fbcon-cfb32.h: No such file or directory
drivers/video/pm2fb.c:163: error: user_mode causes a section type conflict
drivers/video/pm2fb.c:258: error: field `gen' has incomplete type
drivers/video/pm2fb.c:287: error: field `disp' has incomplete type
drivers/video/pm2fb.c:403: error: variable `pm2fb_hwswitch' has initializer but 
incomplete type
drivers/video/pm2fb.c:404: warning: excess elements in struct initializer
drivers/video/pm2fb.c:404: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:404: warning: excess elements in struct initializer
drivers/video/pm2fb.c:404: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:404: warning: excess elements in struct initializer
drivers/video/pm2fb.c:404: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:405: warning: excess elements in struct initializer
drivers/video/pm2fb.c:405: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:405: warning: excess elements in struct initializer
drivers/video/pm2fb.c:405: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:405: warning: excess elements in struct initializer
drivers/video/pm2fb.c:405: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:406: warning: excess elements in struct initializer
drivers/video/pm2fb.c:406: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:406: warning: excess elements in struct initializer
drivers/video/pm2fb.c:406: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:407: warning: excess elements in struct initializer
drivers/video/pm2fb.c:407: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:408: warning: excess elements in struct initializer
drivers/video/pm2fb.c:408: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:417: error: unknown field `fb_get_fix' specified in 
initializer
drivers/video/pm2fb.c:417: error: `fbgen_get_fix' undeclared here (not in a 
function)
drivers/video/pm2fb.c:417: error: initializer element is not constant
drivers/video/pm2fb.c:417: error: (near initialization for `pm2fb_ops.fb_open')
drivers/video/pm2fb.c:418: error: unknown field `fb_get_var' specified in 
initializer
drivers/video/pm2fb.c:418: error: `fbgen_get_var' undeclared here (not in a 
function)
drivers/video/pm2fb.c:418: error: initializer element is not constant
drivers/video/pm2fb.c:418: error: (near initialization for `pm2fb_ops.
fb_release')
drivers/video/pm2fb.c:419: error: unknown field `fb_set_var' specified in 
initializer
drivers/video/pm2fb.c:419: error: `fbgen_set_var' undeclared here (not in a 
function)
drivers/video/pm2fb.c:419: error: initializer element is not constant
drivers/video/pm2fb.c:419: error: (near initialization for `pm2fb_ops.fb_read')
drivers/video/pm2fb.c:420: error: unknown field `fb_get_cmap' specified in 
initializer
drivers/video/pm2fb.c:420: error: `fbgen_get_cmap' undeclared here (not in a 
function)
drivers/video/pm2fb.c:420: error: initializer element is not constant
drivers/video/pm2fb.c:420: error: (near initialization for `pm2fb_ops.fb_write')
drivers/video/pm2fb.c:421: error: unknown field `fb_set_cmap' specified in 
initializer
drivers/video/pm2fb.c:421: error: `fbgen_set_cmap' undeclared here (not in a 
function)
drivers/video/pm2fb.c:421: error: initializer element is not constant
drivers/video/pm2fb.c:421: error: (near initialization for `pm2fb_ops.
fb_check_var')
drivers/video/pm2fb.c:422: error: `fbgen_pan_display' undeclared here (not in a 
function)
drivers/video/pm2fb.c:422: error: initializer element is not constant
drivers/video/pm2fb.c:422: error: (near initialization for `pm2fb_ops.
fb_pan_display')
drivers/video/pm2fb.c:424: error: `fbgen_blank' undeclared here (not in a 
function)
drivers/video/pm2fb.c:424: error: initializer element is not constant
drivers/video/pm2fb.c:424: error: (near initialization for `pm2fb_ops.fb_blank')
drivers/video/pm2fb.c: In function `pm2fb_pp_bmove':
drivers/video/pm2fb.c:1361: warning: implicit declaration of function 
`fontwidthlog'
drivers/video/pm2fb.c:1367: warning: implicit declaration of function 
`fontwidth'
drivers/video/pm2fb.c:1371: warning: implicit declaration of function 
`fontheight'
drivers/video/pm2fb.c:1374: error: dereferencing pointer to incomplete type
drivers/video/pm2fb.c: In function `pm2fb_bmove':
drivers/video/pm2fb.c:1394: error: dereferencing pointer to incomplete type
drivers/video/pm2fb.c: In function `pm2fb_set_disp':
drivers/video/pm2fb.c:1970: error: dereferencing pointer to incomplete type
drivers/video/pm2fb.c:2009: error: dereferencing pointer to incomplete type
drivers/video/pm2fb.c:2009: error: `fbcon_dummy' undeclared (first use in this 
function)
drivers/video/pm2fb.c:2009: error: (Each undeclared identifier is reported only 
once
drivers/video/pm2fb.c:2009: error: for each function it appears in.)
drivers/video/pm2fb.c: In function `pm2fb_cleanup':
drivers/video/pm2fb.c:2227: error: `info' undeclared (first use in this 
function)
drivers/video/pm2fb.c: In function `pm2fb_init':
drivers/video/pm2fb.c:2243: warning: `MOD_INC_USE_COUNT' is deprecated (declared 
at include/linux/module.h:481)
drivers/video/pm2fb.c:2247: warning: `MOD_DEC_USE_COUNT' is deprecated (declared 
at include/linux/module.h:493)
drivers/video/pm2fb.c:2264: error: `SCROLL_YNOMOVE' undeclared (first use in 
this function)
drivers/video/pm2fb.c:2272: error: `fbgen_switch' undeclared (first use in this 
function)
drivers/video/pm2fb.c:2273: error: `fbgen_update_var' undeclared (first use in 
this function)
drivers/video/pm2fb.c:2275: warning: implicit declaration of function 
`fbgen_get_var'
drivers/video/pm2fb.c:2276: warning: implicit declaration of function 
`fbgen_do_set_var'
drivers/video/pm2fb.c:2277: warning: implicit declaration of function 
`fbgen_set_disp'
drivers/video/pm2fb.c:2278: warning: implicit declaration of function 
`fbgen_install_cmap'
drivers/video/pm2fb.c:2282: warning: `MOD_DEC_USE_COUNT' is deprecated (declared 
at include/linux/module.h:493)
drivers/video/pm2fb.c: At top level:
drivers/video/pm2fb.c:403: error: storage size of `pm2fb_hwswitch' isn't known
drivers/video/pm2fb.c:1359: warning: `pm2fb_pp_bmove' defined but not used
drivers/video/pm2fb.c:1379: warning: `pm2fb_bmove' defined but not used
make[2]: *** [drivers/video/pm2fb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2


