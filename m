Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbSIZROR>; Thu, 26 Sep 2002 13:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSIZROQ>; Thu, 26 Sep 2002 13:14:16 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:20379 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261412AbSIZROP> convert rfc822-to-8bit; Thu, 26 Sep 2002 13:14:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: "Nathan" <etherwolf@sopris.net>
Subject: Re: Updated to kernel 2.4.19 and now ipchains and iptables are broke.
Date: Thu, 26 Sep 2002 19:19:19 +0200
User-Agent: KMail/1.4.3
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
References: <200209261901.17679.m.c.p@wolk-project.de> <004201c2657f$c1a1bed0$f101010a@nathan>
In-Reply-To: <004201c2657f$c1a1bed0$f101010a@nathan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209261919.19945.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 September 2002 19:11, Nathan wrote:

Hi Nathan,

> I saw the config option for netfilter that said if you use this it won't
> use ipchains, so I said no to that...
Yep, that's true if you build Netfilter into your kernel, not as Module(s). 
Build both, Netfilter + stuff and ipchains as modules and you are happy.

So you are able to use both (not at the same time for sure.
Just "modprobe ipchains" and use ipchains.
If you want to play with Netfilter, just "rmmod ipchains; modprobe ip_tables" 
and you can use iptables.


-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
