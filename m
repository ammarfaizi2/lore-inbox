Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131820AbRDQLDa>; Tue, 17 Apr 2001 07:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132042AbRDQLDU>; Tue, 17 Apr 2001 07:03:20 -0400
Received: from quechua.inka.de ([212.227.14.2]:10817 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131887AbRDQLDM>;
	Tue, 17 Apr 2001 07:03:12 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
In-Reply-To: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan> <01041708461209.00352@workshop> <20010416020732.30431.qmail@logi.cc> <20010416104310.A29075@flint.arm.linux.org.uk>
Date: Tue, 17 Apr 2001 12:29:30 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14pSji-0000Ng-00@hunte.bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Umm, no.  Counters can be resetable - you just specify that accounting
> programs should not reset them, ever.
>
> The ability to reset counters is extremely useful if you're a human
> looking at the output of iptables -L -v.  (I thus far know of no one
> who can memorise the counter values for around 40 rules).

You'll get bogus accounting results unless you stop/restart the
accounting programs every time you manually deal with the counters.
This sounds dangerously easy to make mistakes to me.

Olaf

