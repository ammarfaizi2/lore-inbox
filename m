Return-Path: <linux-kernel-owner+w=401wt.eu-S1750942AbXADSr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbXADSr7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbXADSr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:47:59 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:44049 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbXADSr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:47:59 -0500
Subject: BUG, 2.6.20-rc3 raid autodetection
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 19:47:45 +0100
Message-Id: <1167936465.6594.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

i just attempted to test .20-rc3-git4 on a box, which has 6 drives in
raid5. it uses raid autodetection, and 2 ide controllers (via and
promise 20269).

there are two problems.

first, and most importantly, it doesent autodetect, i attempted with
both the old ide drivers, and the new pata on libata drivers, the drives
appears to be found, but the raid autoassembling just doesent happen.

this is .17, which works:
http://sh.nu/p/8001

this is .20-rc3-git4 which doesent work, in pata-on-libata mode:
http://sh.nu/p/8000

this is .20-rc3-git4 which doesent work, in old ide mode:
http://sh.nu/p/8002


second bug:
notice on these pastes the lines at bottom, the keyboard stuff, these
are repeated constantly, and caps/scrolllock button on keyboard is
blinking.


mvh.
Kasper Sandberg

