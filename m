Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbTJQIEq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 04:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTJQIEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 04:04:46 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:39402 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S263335AbTJQIEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 04:04:43 -0400
Message-ID: <01e601c39484$f3fa31c0$890010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Larry McVoy" <lm@bitmover.com>,
       "Albert Cahalan" <albert@users.sourceforge.net>
Cc: "linux-kernel mailing list" <linux-kernel@vger.kernel.org>
References: <1066356438.15931.125.camel@cube> <20031017023437.GB28158@work.bitmover.com>
Subject: Re: /proc reliability & performance
Date: Fri, 17 Oct 2003 10:01:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Larry McVoy" <lm@bitmover.com>
>
> And your real need for 360,000 threads is?
>
> I tend to believe that there are hundreds, nay, thousands, nay, 360
thousand
> better things to work on in the kernel.

Same problem here on some servers (real application), but with 280.000 tcp
sockets active.

A "cat /proc/net/tcp" takes too much time to even try it. :(

tools like "netstat" or "lsof", (even with -n flag) are just unusable.

Eric Dumazet

