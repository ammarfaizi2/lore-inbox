Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267789AbTBKNCR>; Tue, 11 Feb 2003 08:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbTBKNCR>; Tue, 11 Feb 2003 08:02:17 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:21460 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id <S267789AbTBKNCP>;
	Tue, 11 Feb 2003 08:02:15 -0500
Date: Tue, 11 Feb 2003 14:11:51 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [2.5.60] swsuspend -> BUG at drivers/ide/ide-disk.c:1557
Message-ID: <20030211131151.GA1262@k3.hellgate.ch>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.60 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is software suspend in Vanilla 2.5.60 supposed to work? A modified shutdown
(using the reboot(2) magic) triggers the BUG_ON in idedisk_suspend. A quick
check with older 2.5.x indicates this problem has been around for a while.

I can provide additional information incl. call trace if anyone's
interested.

Roger
