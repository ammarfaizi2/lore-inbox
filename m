Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265440AbTHFPGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 11:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbTHFPGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 11:06:31 -0400
Received: from smtp0.libero.it ([193.70.192.33]:57297 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S265440AbTHFPGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 11:06:30 -0400
Subject: [PATCH] Lirc Drivers for 2.5/6 20030806 [devfs enabled]
From: Flameeyes <dgp85@users.sourceforge.net>
To: LKML <linux-kernel@vger.kernel.org>,
       LIRC list <lirc-list@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1060182394.7828.8.camel@defiant.flameeyes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 06 Aug 2003 17:06:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fifth try for the lirc patch, and fixes a big problem, the
missing of devfs suppor in the previous patches.
Download it from here
http://flameeyes.is-a-geek.org/lirc/patch-lirc-20030806.diff.bz2 .

I have switched to gentoo this week (after a rootfs failure on my debian
box), so the devfs suport was the priority.
I also merged another change to lirc_dev from lirc cvs.
Please note that using devfs you need to provide lircd the path to the
device (-d /dev/lirc/lirc0).

Thanks,
-- 
Flameeyes <dgp85@users.sf.net>

