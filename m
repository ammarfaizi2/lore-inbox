Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbTJJVZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 17:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbTJJVZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 17:25:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:60124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263136AbTJJVZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 17:25:47 -0400
Date: Fri, 10 Oct 2003 14:16:46 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com
Subject: patches for PROC_FS=n (2.6.0-test7)
Message-Id: <20031010141646.779f10bb.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/char/toshiba.c and
net/atm/clip.c don't build if PROC_FS=n.

Patches for them are available at:

http://developer.osdl.org/rddunlap/patches/toshiba_inline_260t7.patch
http://developer.osdl.org/rddunlap/patches/atmprocfs_260t7.patch

There are several other drivers/protocols that don't build
with PROC_FS=n, like arlan, siimage, ipx, llc, and bluetooth.

--
~Randy
