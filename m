Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUCHRfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 12:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbUCHRfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 12:35:23 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:62835 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262360AbUCHRfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 12:35:19 -0500
Subject: amd64-agp strangeness
From: Redeeman <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078767316.5804.15.camel@redeeman.linux.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Mar 2004 18:35:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi.

i believe there is some problems with amd64-agp driver.

on vanilla kernels, i have tried (2.6.0-test4 - 2.6.4-rc2) it doesent
work, the X just freezes before the wm start, and i cant stop X or
anything, but i can ssh into it, restart box, if i kill X, the box locks
up, so even magic sysrq key doesent work.
BUT
in 2.6.4-rc1-mm2 it worked... almost... sometimes the box could freeze
and X used 100% cpu, but i could still ssh into it. and restart.
now with 2.6.4-rc2-mm1 it doesent work either.

without the amd64-agp i have alot slower graphics, and whenever i start
anything that uses opengl, X goes to 100% cpu usage. but with amd64-agp
like 1-10%

any ideas? or known fixes

my system specs:
asus k8v deluxe with via k8t800 chipset
amd64 3200+
gf4 mx 440 agp8x
-- 
Regards, Redeeman
redeeman@metanurb.dk

