Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265949AbTGHA22 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 20:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbTGHA22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 20:28:28 -0400
Received: from [66.212.224.118] ([66.212.224.118]:18 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265949AbTGHA21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 20:28:27 -0400
Date: Mon, 7 Jul 2003 20:31:45 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>, Nick Sanders <sandersn@btinternet.com>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
In-Reply-To: <200307071343.26318.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.53.0307072028440.1288@montezuma.mastecende.com>
References: <200307070317.11246.kernel@kolivas.org> <200307071319.57511.kernel@kolivas.org>
 <200307071151.12553.sandersn@btinternet.com> <200307071343.26318.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003, Marc-Christian Petersen wrote:

> On Monday 07 July 2003 12:51, Nick Sanders wrote:
> 
> - An Xterm needs ~30 seconds to open up while "make -j16 bzImage modules"
> - An Xterm needs ~15 seconds to open up while "make -j8 bzImage modules"
> - XMMS does _not_ skip mp3's while above.

How fast is your box? RAM? disks? I'm personally more interested in 1-2 
make -j2 bzImage going

> - Kmail is almost unusable while above (stops for about 5 secs every 15-20
>   secs). KMail is also very slow while the machine is doing nothing.
> - X runs with nice 0, prio 15 (nice -11 is prio 4, does not make difference)

Looking at above load i'm not entirely surprised, but i presume you're 
going to name a kernel which can handle that and still complete the builds 
withing a sane time frame.

-- 
function.linuxpower.ca
