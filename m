Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136673AbRAJVlL>; Wed, 10 Jan 2001 16:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAJVlB>; Wed, 10 Jan 2001 16:41:01 -0500
Received: from logger.gamma.ru ([194.186.254.23]:48653 "EHLO logger.gamma.ru")
	by vger.kernel.org with ESMTP id <S136673AbRAJVkv>;
	Wed, 10 Jan 2001 16:40:51 -0500
To: linux-kernel@vger.kernel.org
Path: pccross!not-for-mail
From: crosser@average.org (Eugene Crosser)
Newsgroups: linux.kernel
Subject: Re: 2.4.0 tcp over firewall - no connection
Date: 11 Jan 2001 00:38:36 +0300
Organization: Average
Message-ID: <93ikos$p6r$1@pccross.average.org>
In-Reply-To: <m3itnnru8n.fsf@belphigor.mcnaught.org>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
X-Comment-To: Doug McNaught <doug@wireboard.com>
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m3itnnru8n.fsf@belphigor.mcnaught.org>,
        Doug McNaught <doug@wireboard.com> writes:

>> I noticed rather strange behavior: stock 2.4.0 with old ISA 3Com
>> on UP compiled as UP cannot open TCP connection to hosts behind a
>> firewall.  E.g. it is impossible to go to http://www.etrade.com/ -
>> connect just never finishes.  2.2.17 on the same hardware works
>> right.  2.4.0 on SMP over PPP connection works right too.  MTU
>> is 1500 in both cases.  In both cases, kernel is compiled with
>> netfilter as modules, but those are not loaded.
> 
> Known problem, exhaustively discussed on the list, and not related
> to your NIC.  Disable ECN (explicit congestion notification), either
> in your kernel compile or in /proc/sys/<something>.

This really was ECN, sorry for noise in this list...

Eugene
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
