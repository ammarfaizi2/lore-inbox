Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTGFVk0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 17:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTGFVkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 17:40:25 -0400
Received: from kiuru.kpnet.fi ([193.184.122.21]:45010 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S262861AbTGFVkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 17:40:21 -0400
Subject: [BUG] Missing files in 2.5.74<
From: Midian <midian@ihme.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1057528492.15569.8.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 07 Jul 2003 00:54:52 +0300
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've tryed to compile the 2.5.74 kernel with pm2fb support, and never
got it working I get this error message:
  
    CC [M]  drivers/video/pm2fb.o
drivers/video/pm2fb.c:44:25: video/fbcon.h: No such file or directory
drivers/video/pm2fb.c:45:30: video/fbcon-cfb8.h: No such file or
directory
drivers/video/pm2fb.c:46:31: video/fbcon-cfb16.h: No such file or
directory
drivers/video/pm2fb.c:47:31: video/fbcon-cfb24.h: No such file or
directory
drivers/video/pm2fb.c:48:31: video/fbcon-cfb32.h: No such file or
directory
drivers/video/pm2fb.c:163: error: user_mode causes a section type
conflict
drivers/video/pm2fb.c:258: error: field `gen' has incomplete type
drivers/video/pm2fb.c:287: error: field `disp' has incomplete type
drivers/video/pm2fb.c:403: error: variable `pm2fb_hwswitch' has
initializer but incomplete type
drivers/video/pm2fb.c:404: warning: excess elements in struct
initializer
drivers/video/pm2fb.c:404: warning: (near initialization for
`pm2fb_hwswitch')
drivers/video/pm2fb.c:404: warning: excess elements in struct
initializer
drivers/video/pm2fb.c:404: warning: (near initialization for
`pm2fb_hwswitch')
drivers/video/pm2fb.c:404: warning: excess elements in struct
initializer
drivers/video/pm2fb.c:404: warning: (near initialization for
`pm2fb_hwswitch')
drivers/video/pm2fb.c:405: warning: excess elements in struct
initializer
drivers/video/pm2fb.c:405: warning: (near initialization for
`pm2fb_hwswitch')
drivers/video/pm2fb.c:405: warning: excess elements in struct
initializer
drivers/video/pm2fb.c:405: warning: (near initialization for
`pm2fb_hwswitch')
drivers/video/pm2fb.c:405: warning: excess elements in struct
initializer
drivers/video/pm2fb.c:405: warning: (near initialization for
`pm2fb_hwswitch')
drivers/video/pm2fb.c:406: warning: excess elements in struct
initializer
drivers/video/pm2fb.c:406: warning: (near initialization for
`pm2fb_hwswitch')
drivers/video/pm2fb.c:406: warning: excess elements in struct
initializer
drivers/video/pm2fb.c:406: warning: (near initialization for
`pm2fb_hwswitch')
drivers/video/pm2fb.c:407: warning: excess elements in struct
initializer
drivers/video/pm2fb.c:407: warning: (near initialization for
`pm2fb_hwswitch')
drivers/video/pm2fb.c:408: warning: excess elements in struct
initializer
drivers/video/pm2fb.c:408: warning: (near initialization for
`pm2fb_hwswitch')
drivers/video/pm2fb.c:417: error: unknown field `fb_get_fix' specified
in initializer
drivers/video/pm2fb.c:417: error: `fbgen_get_fix' undeclared here (not
in a function)
drivers/video/pm2fb.c:417: error: initializer element is not constant
drivers/video/pm2fb.c:417: error: (near initialization for
`pm2fb_ops.fb_open')
drivers/video/pm2fb.c:418: error: unknown field `fb_get_var' specified
in initializer
drivers/video/pm2fb.c:418: error: `fbgen_get_var' undeclared here (not
in a function)
drivers/video/pm2fb.c:418: error: initializer element is not constant
drivers/video/pm2fb.c:418: error: (near initialization for
`pm2fb_ops.fb_release')
drivers/video/pm2fb.c:419: error: unknown field `fb_set_var' specified
in initializer
drivers/video/pm2fb.c:419: error: `fbgen_set_var' undeclared here (not
in a function)
drivers/video/pm2fb.c:419: error: initializer element is not constant
drivers/video/pm2fb.c:419: error: (near initialization for
`pm2fb_ops.fb_read')
drivers/video/pm2fb.c:420: error: unknown field `fb_get_cmap' specified
in initializer
drivers/video/pm2fb.c:420: error: `fbgen_get_cmap' undeclared here (not
in a function)
drivers/video/pm2fb.c:420: error: initializer element is not constant
drivers/video/pm2fb.c:420: error: (near initialization for
`pm2fb_ops.fb_write')
drivers/video/pm2fb.c:421: error: unknown field `fb_set_cmap' specified
in initializer
drivers/video/pm2fb.c:421: error: `fbgen_set_cmap' undeclared here (not
in a function)
drivers/video/pm2fb.c:421: error: initializer element is not constant
drivers/video/pm2fb.c:421: error: (near initialization for
`pm2fb_ops.fb_check_var')
drivers/video/pm2fb.c:422: error: `fbgen_pan_display' undeclared here
(not in a function)
drivers/video/pm2fb.c:422: error: initializer element is not constant
drivers/video/pm2fb.c:422: error: (near initialization for
`pm2fb_ops.fb_pan_display')
drivers/video/pm2fb.c:424: error: `fbgen_blank' undeclared here (not in
a function)
drivers/video/pm2fb.c:424: error: initializer element is not constant
drivers/video/pm2fb.c:424: error: (near initialization for
`pm2fb_ops.fb_blank')
drivers/video/pm2fb.c: In function `pm2fb_pp_bmove':
drivers/video/pm2fb.c:1361: warning: implicit declaration of function
`fontwidthlog'
drivers/video/pm2fb.c:1367: warning: implicit declaration of function
`fontwidth'
drivers/video/pm2fb.c:1371: warning: implicit declaration of function
`fontheight'
drivers/video/pm2fb.c:1374: error: dereferencing pointer to incomplete
type
drivers/video/pm2fb.c: In function `pm2fb_bmove':
drivers/video/pm2fb.c:1394: error: dereferencing pointer to incomplete
type
drivers/video/pm2fb.c: In function `pm2fb_set_disp':
drivers/video/pm2fb.c:1970: error: dereferencing pointer to incomplete
type
drivers/video/pm2fb.c:2009: error: dereferencing pointer to incomplete
type
drivers/video/pm2fb.c:2009: error: `fbcon_dummy' undeclared (first use
in this function)
drivers/video/pm2fb.c:2009: error: (Each undeclared identifier is
reported only once
drivers/video/pm2fb.c:2009: error: for each function it appears in.)
drivers/video/pm2fb.c: In function `pm2fb_cleanup':
drivers/video/pm2fb.c:2227: error: `info' undeclared (first use in this
function)
drivers/video/pm2fb.c: In function `pm2fb_init':
drivers/video/pm2fb.c:2243: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:481)
drivers/video/pm2fb.c:2247: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:493)
drivers/video/pm2fb.c:2264: error: `SCROLL_YNOMOVE' undeclared (first
use in this function)
drivers/video/pm2fb.c:2272: error: `fbgen_switch' undeclared (first use
in this function)
drivers/video/pm2fb.c:2273: error: `fbgen_update_var' undeclared (first
use in this function)
drivers/video/pm2fb.c:2275: warning: implicit declaration of function
`fbgen_get_var'
drivers/video/pm2fb.c:2276: warning: implicit declaration of function
`fbgen_do_set_var'
drivers/video/pm2fb.c:2277: warning: implicit declaration of function
`fbgen_set_disp'
drivers/video/pm2fb.c:2278: warning: implicit declaration of function
`fbgen_install_cmap'
drivers/video/pm2fb.c:2282: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:493)
drivers/video/pm2fb.c: At top level:
drivers/video/pm2fb.c:403: error: storage size of `pm2fb_hwswitch' isn't
known
drivers/video/pm2fb.c:1359: warning: `pm2fb_pp_bmove' defined but not
used
drivers/video/pm2fb.c:1379: warning: `pm2fb_bmove' defined but not used
make[2]: *** [drivers/video/pm2fb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

I joined this mailing list today, so I don't know if this is a known bug
already.

Thanks.

Regards
-- 
Markus Hästbacka <midian@ihme.org>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

