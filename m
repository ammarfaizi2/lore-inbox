Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbTH2T0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTH2T0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:26:03 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:20158 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S261474AbTH2T0B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:26:01 -0400
Subject: Re: Linux 2.4.22-ac1 - VIA C3 cpufreq probs
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200308291237.h7TCbYc12849@devserv.devel.redhat.com>
References: <200308291237.h7TCbYc12849@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1062185134.1488.9.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Fri, 29 Aug 2003 21:25:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just tried 2.4.22-ac1 on my VIA C3 EPIA 800 system. Cpufreq
(longhaul) fails both while compiled as a module and compiled in.

I first tried to build it as a module but somehow the module isn't build
at all. Next thing I tried was building it straight in the
kernel....with a direct oops when booting as a result.

The system doesn't have a keyboard or monitor..it did cost me some
fiddling to get it back up running...that's life for a tester...

There also seems to be some problem with the longhaul detection. Normaly
it would print something like:
longhaul: VIA CPU detected. Longhaul version 2 supported
longhaul: CPU currently at 798MHz (133 x 6.0)
longhaul: MinMult(x10)=30 MaxMult(x10)=60
longhaul: Lowestspeed=399000 Highestspeed=798000

But 2.4.22-ac1 printed MinMult and MaxMult to be 0.

Greetings,

Jurgen

