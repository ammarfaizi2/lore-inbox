Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264036AbTIILub (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 07:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTIILub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 07:50:31 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:40687
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S264036AbTIILua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 07:50:30 -0400
Message-ID: <3F5DBE83.3121A495@eyal.emu.id.au>
Date: Tue, 09 Sep 2003 21:50:27 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test5: ps2esdi (CONFIG_BLK_DEV_PS2) build fails
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

allmodconfig. i386:

  CC [M]  drivers/block/ps2esdi.o
In file included from include/linux/mca.h:140,
                 from drivers/block/ps2esdi.c:42:
include/linux/mca-legacy.h:10: warning: #warning "MCA legacy - please
move your 
driver to the new sysfs api"
drivers/block/ps2esdi.c:186: redefinition of `init_module'
drivers/block/ps2esdi.c:172: `init_module' previously defined here
drivers/block/ps2esdi.c: In function `init_module':
drivers/block/ps2esdi.c:190: warning: initialization from incompatible
pointer t
ype
drivers/block/ps2esdi.c:193: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:193: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:194: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:197: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:198: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:200: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c: In function `cleanup_module':
drivers/block/ps2esdi.c:216: `i' undeclared (first use in this function)
drivers/block/ps2esdi.c:216: (Each undeclared identifier is reported
only once
drivers/block/ps2esdi.c:216: for each function it appears in.)
{standard input}: Assembler messages:
{standard input}:238: Error: symbol `init_module' is already defined
make[2]: *** [drivers/block/ps2esdi.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2


--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
