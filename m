Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbTLJTvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 14:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTLJTvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 14:51:15 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:50352 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S263909AbTLJTvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 14:51:09 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>, "'Larry McVoy'" <lm@bitmover.com>
Cc: "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, <Valdis.Kletnieks@vt.edu>,
       "'Kendall Bennett'" <KendallB@scitechsoft.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause?
Date: Wed, 10 Dec 2003 11:51:05 -0800
Organization: Cisco Systems
Message-ID: <00bf01c3bf56$f2cbefd0$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <Pine.LNX.4.58.0312100959180.29676@home.osdl.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No it wouldn't.
> 
> Microsoft very much _has_ a binary API to their drivers, in a way that
> Linux doesn't.
> 
> MS has to have that binary API exactly because they live in a 
> binary-only world. They've basically put that requirement on
themselves 
> by having binary-only distributions.
> 
> So your argument doesn't fly. To Microsoft, a "driver" is just another
> external entity, with documented API's, and they indeed ship 
> their _own_ drivers that way too. And all third-party drivers do the
same 
> thing.
> 
> So there is no analogy to the Linux case. In Linux, no fixed 
> binary API exists, and the way normal drivers are distributed are as 
> GPL'd source code.

With all due respect, I find the above hardly convincing.

With your own argument, how would you convince a judge to believe it
without understanding all the subtle technical differences? (and we're
just taking what you said about "one offers stable ABI the other not"
for granted for now)

Both Windows and Linux are operating systems, that's the first thing.
Whether they are open source or not is just a secondary difference. How
could this fundamentally change the question "if a driver is a derived
work of the OS or not"?

In either case the driver would not work "without the host OS". In
either case, the same driver binary would probably not work across
versions. Both are pretty strong points in your argument. Moreover, in
the Windows world, a non-trivial user space application very possibly
havs different binaries for different versions - hey, Windows may have a
less stable user space ABI than Linux, so they could very well claim
more rights over user space applications, can't they?

I'm not arguing because I am afraid of being sued, just to clarify. To
be frank the chance that I'm sued by kernel copyright holders for
writing a binary only module is slimer than being sued by SCO for using
Linux freely. The chance that I would lose is also slimer than IBM would
lose to SCO.

Hua




