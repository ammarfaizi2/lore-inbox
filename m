Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310249AbSCFW1F>; Wed, 6 Mar 2002 17:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310243AbSCFW0t>; Wed, 6 Mar 2002 17:26:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19342 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310241AbSCFW0f>;
	Wed, 6 Mar 2002 17:26:35 -0500
Date: Wed, 06 Mar 2002 14:24:13 -0800 (PST)
Message-Id: <20020306.142413.73653162.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: [BETA-0.96] Seventh test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not much changed, just one biggie.  Get it at:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/TIGON3/tg3-0.96.patch.gz

Changes:

[PERFORMANCE] Don't mess with DMA read/write boundary settings on X86
	      Should result in significant performance increases on
	      this platform.  I'm rather confident our driver performs
	      better than Broadcom's driver on all platforms now.
[PATCH-ERROR] Some parts of 0.95 didn't apply directly due to some
	      botched up hand patch editing on my part, sorry :-)

Please test and benchmark, and I'll be away until Saturday to look
into reports.

And you Aussies, you know what you need to do :-))))
