Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTDHRye (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 13:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTDHRye (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 13:54:34 -0400
Received: from AStrasbourg-204-1-4-222.abo.wanadoo.fr ([81.53.128.222]:58848
	"EHLO kalman") by vger.kernel.org with ESMTP id S261994AbTDHRyd (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 13:54:33 -0400
Date: Tue, 8 Apr 2003 20:06:04 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.5.67 compile problem...
Message-ID: <20030408180604.GA3709@adlp.org>
Reply-To: bboett@adlp.org
Mail-Followup-To: bboett@bboett.dyndns.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: bboett@bboett.dyndns.org (Bruno Boettcher)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

after the yesterday cramfs problem, (BTW thanks for those who helped me
    iron that out) here another compile problem, with
the patched 2.5.66 thus mathing a 67 kernel:

In file included from include/linux/mca.h:132,
                 from drivers/block/ps2esdi.c:42:
include/linux/mca-legacy.h:10:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
drivers/block/ps2esdi.c:182: redefinition of `init_module'
drivers/block/ps2esdi.c:168: `init_module' previously defined here
drivers/block/ps2esdi.c: In function `init_module':
drivers/block/ps2esdi.c:186: warning: initialization from incompatible pointer type
drivers/block/ps2esdi.c:189: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:189: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:190: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:193: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:194: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:196: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c: In function `cleanup_module':
drivers/block/ps2esdi.c:212: `i' undeclared (first use in this function)
drivers/block/ps2esdi.c:212: (Each undeclared identifier is reported only once
drivers/block/ps2esdi.c:212: for each function it appears in.)
drivers/block/ps2esdi.c: In function `do_ps2esdi_request':
drivers/block/ps2esdi.c:502: warning: long long unsigned int format, different type arg (arg 3)
drivers/block/ps2esdi.c: In function `ps2esdi_out_cmd_blk':
drivers/block/ps2esdi.c:623: warning: comparison of distinct pointer types lacks a cast
drivers/block/ps2esdi.c:646: warning: comparison of distinct pointer types lacks a cast
make[2]: *** [drivers/block/ps2esdi.o] Fehler 1


again if someone has a suggestion....
and please add me as CC to any reply

-- 
ciao bboett
==============================================================
bboett@adlp.org
http://inforezo.u-strasbg.fr/~bboett
===============================================================
