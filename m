Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265427AbSJXNYc>; Thu, 24 Oct 2002 09:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265433AbSJXNYc>; Thu, 24 Oct 2002 09:24:32 -0400
Received: from user19.okena.com ([65.196.32.19]:6773 "EHLO
	gatemaster.okena.com") by vger.kernel.org with ESMTP
	id <S265427AbSJXNYb>; Thu, 24 Oct 2002 09:24:31 -0400
From: Slavcho Nikolov <snikolov@okena.com>
To: "David S. Miller" <davem@rth.ninka.net>
Cc: jt@hpl.hp.com, Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-ID: <000c01c27b61$86c903c0$800a140a@SLNW2K>
References: <20021023003959.GA23155@bougret.hpl.hp.com> <004c01c27a99$927b8a30$800a140a@SLNW2K> <1035432805.9626.4.camel@rth.ninka.net>
Subject: Re: feature request - why not make netif_rx() a pointer?
Date: Thu, 24 Oct 2002 09:30:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote
 
| While more hooks may be in your interest, they are not in the interest
| of free software.
| 
| I really hope you have competant legal advice for the things you are
| doing, because binary-only derivative works of a GPL work are illegal.


Thanks for the heads-up. What I propose to do is NOT to re-implement
some existing linux routine by reusing all or some of its code.
That is not only illegal, it's immoral.
In other words, the new routine will not be a derivative of the old one
or some other part of the kernel.
Instead, I'll create my own (cleanroom) handler that doesn't reuse any
existing code, which in the end will either pass control to the GPL routine
being replaced or destroy the parameters and return.
I can't see how that is a violation of GPL. If it is, then hundreds of
Linux startups had better go bankrupt now instead of fighting losing 
legal battles later.
S.N.

