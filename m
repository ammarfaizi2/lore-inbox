Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264789AbTFLIvE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 04:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbTFLIvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 04:51:04 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:33797 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S264789AbTFLIu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 04:50:59 -0400
Date: Thu, 12 Jun 2003 11:05:03 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: need help with oaknet.c
Message-ID: <20030612090503.GA24365@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

I'm trying to cross compile a linux 2.5.70 kernel to ppc, and after
removing a few obstacles I'm now stuck in oaknet.c, which bears your
email address.

Here are the compile errors.  I have no idea where I can get an
asm/board.h and a grep did not find the missing defines.

drivers/net/oaknet.c:24:23: asm/board.h: No such file or directory
drivers/net/oaknet.c: In function `oaknet_init':
drivers/net/oaknet.c:102: error: `OAKNET_IO_BASE' undeclared (first use
in this function)
drivers/net/oaknet.c:102: error: (Each undeclared identifier is reported
only once
drivers/net/oaknet.c:102: error: for each function it appears in.)
drivers/net/oaknet.c:102: error: `OAKNET_IO_SIZE' undeclared (first use
in this function)
drivers/net/oaknet.c:102: warning: initialization makes integer from
pointer without a cast
drivers/net/oaknet.c:104: error: cannot convert to a pointer type
drivers/net/oaknet.c:123: warning: implicit declaration of function
`ei_ibp'
drivers/net/oaknet.c:132: warning: implicit declaration of function
`ei_obp'
drivers/net/oaknet.c:165: error: `OAKNET_INT' undeclared (first use in
this function)
drivers/net/oaknet.c:228: warning: passing arg 1 of `iounmap' makes
pointer from integer without a cast
drivers/net/oaknet.c: In function `oaknet_reset_8390':
drivers/net/oaknet.c:303: error: `E8390_BASE' undeclared (first use in
this function)
drivers/net/oaknet.c: In function `oaknet_get_8390_hdr':
drivers/net/oaknet.c:355: error: `OAKNET_CMD' undeclared (first use in
this function)
drivers/net/oaknet.c:364: error: `OAKNET_DATA' undeclared (first use in
this function)
drivers/net/oaknet.c: In function `oaknet_block_input':
drivers/net/oaknet.c:384: error: `OAKNET_BASE' undeclared (first use in
this function)
drivers/net/oaknet.c:398: error: `flags' undeclared (first use in this
function)
drivers/net/oaknet.c:410: warning: implicit declaration of function
`ei_isw'
drivers/net/oaknet.c:410: error: `E8390_DATA' undeclared (first use in
this function)
drivers/net/oaknet.c:412: warning: implicit declaration of function
`ei_ib'
drivers/net/oaknet.c:414: error: `bytes' undeclared (first use in this
function)
drivers/net/oaknet.c:418: warning: implicit declaration of function
`ei_isb'
drivers/net/oaknet.c: In function `oaknet_block_output':
drivers/net/oaknet.c:477: error: `E8390_BASE' undeclared (first use in
this function)
drivers/net/oaknet.c:584: warning: implicit declaration of function
`ei_osw'
drivers/net/oaknet.c:584: error: `E8390_DATA' undeclared (first use in
this function)
drivers/net/oaknet.c:586: warning: implicit declaration of function
`ei_osb'
drivers/net/oaknet.c: In function `oaknet_dma_error':
drivers/net/oaknet.c:661: error: structure has no member named
`interrupt'
drivers/net/oaknet.c: In function `oaknet_cleanup_module':
drivers/net/oaknet.c:687: error: `OAKNET_IO_SIZE' undeclared (first use
in this function)
drivers/net/oaknet.c:688: warning: passing arg 1 of `iounmap' makes
pointer from integer without a cast
drivers/net/oaknet.c:689: error: `oaknet_dev' undeclared (first use in
this function)
make[2]: *** [drivers/net/oaknet.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2


Can you help me?

Felix
