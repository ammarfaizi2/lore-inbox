Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTIIM1r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 08:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTIIM1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 08:27:47 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:40432
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S264054AbTIIM1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 08:27:46 -0400
Message-ID: <3F5DC73F.69916959@eyal.emu.id.au>
Date: Tue, 09 Sep 2003 22:27:43 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test5: CONFIG_ATM_BR2684 build fails
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

allmodconfig, i386:

  CC [M]  net/atm/br2684.o
net/atm/br2684.c: In function `br2684_seq_show':
net/atm/br2684.c:735: `pos' undeclared (first use in this function)
net/atm/br2684.c:735: (Each undeclared identifier is reported only once
net/atm/br2684.c:735: for each function it appears in.)
net/atm/br2684.c:736: `buf' undeclared (first use in this function)
make[2]: *** [net/atm/br2684.o] Error 1
make[1]: *** [net/atm] Error 2
make: *** [net] Error 2

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
