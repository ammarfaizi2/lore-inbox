Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267542AbUIJQLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbUIJQLk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267551AbUIJQIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:08:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:25289 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S267370AbUIJQGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:06:01 -0400
Subject: 6 New compile/sparse warnings (overnight build)
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1094832133.2364.0.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 10 Sep 2004 09:05:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler: gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
Arch: i386


Summary:
   New warnings = 6

New warnings:
-------------
drivers/net/tulip/dmfe.c:1808:42: warning: incorrect type in argument 1
(different type sizes)
drivers/net/tulip/dmfe.c:1808:42:    expected unsigned short const
[usertype] *p
drivers/net/tulip/dmfe.c:1808:42:    got char *srom

drivers/net/tulip/dmfe.c:1808: warning: passing arg 1 of
`__le16_to_cpup' from incompatible pointer type

drivers/net/tulip/dmfe.c:1820:33: warning: incorrect type in argument 1
(different type sizes)
drivers/net/tulip/dmfe.c:1820:33:    expected unsigned int const
[usertype] *p
drivers/net/tulip/dmfe.c:1820:33:    got char *srom

drivers/net/tulip/dmfe.c:1820:59: warning: incorrect type in argument 1
(different type sizes)
drivers/net/tulip/dmfe.c:1820:59:    expected unsigned int const
[usertype] *p
drivers/net/tulip/dmfe.c:1820:59:    got char *srom

drivers/net/tulip/dmfe.c:1820: warning: passing arg 1 of
`__le32_to_cpup' from incompatible pointer type

fs/reiserfs/do_balan.c:463:8: warning: too long token expansion

John


