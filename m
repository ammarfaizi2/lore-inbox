Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbTADLvH>; Sat, 4 Jan 2003 06:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266898AbTADLvH>; Sat, 4 Jan 2003 06:51:07 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:21719 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266888AbTADLvF>;
	Sat, 4 Jan 2003 06:51:05 -0500
Date: Sat, 4 Jan 2003 11:57:24 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: odd phenomenon.
Message-ID: <20030104115724.GA3876@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030103103816.GA2567@codemonkey.org.uk> <1041677313.642.2.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041677313.642.2.camel@zion.wanadoo.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 11:48:33AM +0100, Benjamin Herrenschmidt wrote:

 > > It's almost 100% reproducable here.  Only seen it do it on this box
 > > though which is a P4 with HT, so it could be SMP related..
 > 
 > Happens all the time here too (ppc32), and did so for ages, with 2.4
 > (didn't specifically notice it with 2.5 yet, but I rarely use galeon
 > when testing 2.5 ;)

Ha! Conclusive proof I'm not losing my marbles.

 > Typically happens with any kind of intense disk activity slowing down
 > galeon's launch process. (Not only bk, but also for example updatedb
 > running in the background).

Maybe, but bk was the only disk-thrashing type app I regularly
have running when I've tried to reproduce this.

Is your PPC32 box SMP ?  I'm wondering why I don't see it on my
athlon/P3 boxes, just on my dual P4.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
