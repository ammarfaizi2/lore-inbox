Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132907AbRAJUnH>; Wed, 10 Jan 2001 15:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133099AbRAJUms>; Wed, 10 Jan 2001 15:42:48 -0500
Received: from logger.gamma.ru ([194.186.254.23]:65036 "EHLO logger.gamma.ru")
	by vger.kernel.org with ESMTP id <S132907AbRAJUmf>;
	Wed, 10 Jan 2001 15:42:35 -0500
To: linux-kernel@vger.kernel.org
Path: pccross!not-for-mail
From: crosser@average.org (Eugene Crosser)
Newsgroups: linux.kernel
Subject: 2.4.0 tcp over firewall - no connection
Date: 10 Jan 2001 23:25:26 +0300
Organization: Average
Message-ID: <93igfm$ooc$1@pccross.average.org>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed rather strange behavior: stock 2.4.0 with old ISA 3Com
on UP compiled as UP cannot open TCP connection to hosts behind a
firewall.  E.g. it is impossible to go to http://www.etrade.com/ -
connect just never finishes.  2.2.17 on the same hardware works
right.  2.4.0 on SMP over PPP connection works right too.  MTU
is 1500 in both cases.  In both cases, kernel is compiled with
netfilter as modules, but those are not loaded.

I did not investigate further yet, just wanted to bring this to
attention of those whom it may concern...

Eugene
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
