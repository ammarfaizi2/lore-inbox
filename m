Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274806AbRIUUE3>; Fri, 21 Sep 2001 16:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274808AbRIUUEK>; Fri, 21 Sep 2001 16:04:10 -0400
Received: from 66-2-81-28.customer.algx.net ([66.2.81.28]:44276 "EHLO
	wiley.ceo.com") by vger.kernel.org with ESMTP id <S274807AbRIUUEE>;
	Fri, 21 Sep 2001 16:04:04 -0400
Message-ID: <3BABA282.F9F855F@mindspring.com>
Date: Fri, 21 Sep 2001 16:26:42 -0400
From: Danny Cox <danscox@mindspring.com>
Reply-To: DCox@SnapServer.com
Organization: Snap
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre12-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-XFS <linux-xfs@oss.sgi.com>
Subject: 2.4.10-pre12 Missing EXPORT_SYMBOL?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	I updated my kernel to 2.4.10-pre12, and upon 'make modules_install',
depmod reported a missing symbol: tty_register_ldisc, from ppp_async.

	I added a 'EXPORT_SYMBOL(tty_register_ldisc)' just after the
tty_register_ldisc definition in drivers/char/tty_io.c, and all was
well.

	Just FYI.

-- 
"Men occasionally stumble over the truth, but most of them pick 
themselves up and hurry off as if nothing had happened." 
   -- Winston Churchill 

Danny
