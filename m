Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTIILrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 07:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTIILrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 07:47:18 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:40431
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S264043AbTIILrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 07:47:17 -0400
Message-ID: <3F5DBDC3.917073E2@eyal.emu.id.au>
Date: Tue, 09 Sep 2003 21:47:15 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test5: ufs build fails
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

allmodconfig on i386:

  CC [M]  fs/ufs/namei.o
fs/ufs/namei.c: In function `ufs_mknod':
fs/ufs/namei.c:119: parse error before `int'
fs/ufs/namei.c:127: `err' undeclared (first use in this function)
fs/ufs/namei.c:127: (Each undeclared identifier is reported only once
fs/ufs/namei.c:127: for each function it appears in.)
fs/ufs/namei.c:131: warning: control reaches end of non-void function
make[2]: *** [fs/ufs/namei.o] Error 1
make[1]: *** [fs/ufs] Error 2
make: *** [fs] Error 2

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
