Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274037AbRISLqb>; Wed, 19 Sep 2001 07:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274040AbRISLqV>; Wed, 19 Sep 2001 07:46:21 -0400
Received: from alex.intersurf.net ([216.115.129.11]:30986 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S274037AbRISLqL>; Wed, 19 Sep 2001 07:46:11 -0400
Date: Wed, 19 Sep 2001 06:46:34 -0500
From: Mark Orr <markorr@intersurf.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10pre12 -- PPP compile problem;  tty_register_ldisc hanging
Message-Id: <20010919064634.6d9cb22d.markorr@intersurf.com>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.8; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just compiled up 2.4.10pre12 (w/ the wakeup_bdflush fix)
and once modules are finished, on install+depmod it's telling
me that ppp_async.c has an unresolved symbol
tty_register_ldisc.

The pre12 patch shows it was removed from an EXPORT_SYMBOL
line in net/netsyms.c.

--
Mark Orr
markorr@intersurf.com
