Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272571AbTHBKiu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 06:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272572AbTHBKiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 06:38:50 -0400
Received: from smtp1.libero.it ([193.70.192.51]:43910 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S272571AbTHBKie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 06:38:34 -0400
Subject: [PATCH] lirc for 2.5/2.6 kernels - 20030802
From: Flameeyes <dgp85@users.sourceforge.net>
To: LKML <linux-kernel@vger.kernel.org>,
       LIRC list <lirc-list@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1059820741.3116.24.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 02 Aug 2003 12:39:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This is the fourth version of my patch for use LIRC drivers under
2.5/2.6 kernels.

As usual, you can find it at
http://flameeyes.web.ctonet.it/lirc/patch-lirc-20030802.diff.bz2

I changed the naming scheme, because I tried and the patch applies also
in earliers and (probably) futures kernels, and call it only
"patch-lirc.diff" will confuse about the versions. I think a datestamp
is the best choice for now.

This version includes minor changes, but an important one, Koos Vriezen
sent me another fixes for lirc_serial driver (thanks, at the moment I
haven't a serial device, and the electronic shops are closed, so I can't
test it directly).
Also I removed the .Makefile.swp present in the last patch (I forgot to
close KVim before do the diff).

This is also the first patch I post to the official lirc mailing list,
HTH other lirc users that want to pass to 2.5/2.6 kernels.

-- 
Flameeyes <dgp85@users.sf.net>

