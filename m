Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131417AbRABUtL>; Tue, 2 Jan 2001 15:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbRABUtB>; Tue, 2 Jan 2001 15:49:01 -0500
Received: from p3E9EEB2B.dip.t-dialin.net ([62.158.235.43]:10368 "EHLO
	gate2.private.net") by vger.kernel.org with ESMTP
	id <S131329AbRABUsr>; Tue, 2 Jan 2001 15:48:47 -0500
Message-Id: <200101022018.f02KIVR00865@gate2.private.net>
From: "Otto Meier" <gf435@gmx.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 02 Jan 2001 21:18:41 +0100
Reply-To: "otto meier" <gf435@gmx.net>
X-Mailer: PMMail 2000 Professional (2.10.2010) For Windows 98 (4.10.2222)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: kernel freeze on 2.4.0.prerelease (smp,raid5)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Perhaps a deadlock with a normal (not irq) spinlock.

Could you enable SysRQ and press <Alt>+<SysRq>+<P> ("showPc")
Then write down the EIP values (including the [< >] brackets) and
translate them with ksymoops.

Ksymoops repeats only the EIP values.

But searching through the System.map file has only Labels from
the raid5 staff around.

As stated in my first mail I run actually my raid5 devices in degrated mode
and as I remenber there has been some raid5 stuff changed between 
test13p3 and newer kernels.

Hope this gives someone an idea?

Bye Otto
 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
