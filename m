Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbTHZWeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTHZWcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:32:25 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:33542 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262971AbTHZWaS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:30:18 -0400
Date: Wed, 27 Aug 2003 00:29:47 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <aradorlinux@yahoo.es>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: retes_simbad@yahoo.es, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.22 released
Message-Id: <20030827002947.078cbdc8.aradorlinux@yahoo.es>
In-Reply-To: <20030826215544.GI7038@fs.tum.de>
References: <200308251148.h7PBmU8B027700@hera.kernel.org>
	<20030825132358.GC14108@merlin.emma.line.org>
	<1061818535.1175.27.camel@debian>
	<20030825211307.GA3346@werewolf.able.es>
	<20030825222215.GX7038@fs.tum.de>
	<1061857293.15168.3.camel@debian>
	<20030826234901.1726adec.aradorlinux@yahoo.es>
	<20030826215544.GI7038@fs.tum.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 26 Aug 2003 23:55:44 +0200 Adrian Bunk <bunk@fs.tum.de> escribió:


> I must have missed the date when Debian's market share dropped under 
> 0.1 % ...

Well, there're alsa packages. A lot of people use them.

> - ALSA is big and there are still some bugs in ALSA; there are more
>   urgent things to be fixed in 2.4

Like the one in drivers/sound/adlib_card.c/opl3.c; which doesn't release
its io region when the module is removed (sent a workaround twice,
got ignored ;(  )

> - it's easy to use ALSA even when it's not inside the kernel
> - within a few months 2.6.0 will be released with ALSA included -
>   together with the point above I don't see a reason why ALSA would be
>   badly needed in 2.4

Those are valid points. Still I'd love to see ALSA in 2.4. I guess this is a
matter of opinion....the VM bits from Andrea are far more important (I've read
several bug reports from people who can't get big machines working ie: kswapd decides
to take all the cpu for 1 minute)

