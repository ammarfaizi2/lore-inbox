Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268315AbUIGPrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268315AbUIGPrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268273AbUIGPnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:43:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:41963 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268304AbUIGPmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:42:25 -0400
Subject: 6 New compile/sparse warnings (over the weekend)
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1094571421.28147.20.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 07 Sep 2004 08:37:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compiler: gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
Arch: i386


Summary:
   New warnings = 6
   Fixed warnings = 1

New warnings:
-------------
drivers/media/video/bttv-cards.c:4148:38: warning: Using plain integer
as NULL pointer

drivers/net/cs89x0.c:1709: warning: `use_dma' defined but not used

drivers/net/cs89x0.c:1710: warning: `dma' defined but not used

drivers/net/cs89x0.c:1711: warning: `dmasize' defined but not used

fs/coda/file.c:298:14: warning: incorrect type in initializer
(incompatible argument 5 (different address spaces))
fs/coda/file.c:298:14:    expected int [usertype] ( *sendfile )( ... )
fs/coda/file.c:298:14:    got int [usertype] ( static [addressable]
[toplevel] *<noident> )( ... )

fs/coda/file.c:61:66: warning: incorrect type in argument 5 (different
address spaces)
fs/coda/file.c:61:66:    expected void *<noident>
fs/coda/file.c:61:66:    got void [noderef] *target<asn:1>

Fixed warnings:
---------------
drivers/net/wan/pc300_tty.c:763: warning: `new' might be used
uninitialized in this function



