Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287040AbRL2AXx>; Fri, 28 Dec 2001 19:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287038AbRL2AXp>; Fri, 28 Dec 2001 19:23:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8462 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287031AbRL2AWB>; Fri, 28 Dec 2001 19:22:01 -0500
Subject: Re: 2.5.1-dj7 -- fdomain.c: In function `do_fdomain_16x0_intr':
To: miles@megapathdsl.net (Miles Lane)
Date: Sat, 29 Dec 2001 00:32:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (LKML), davej@suse.de (Dave Jones)
In-Reply-To: <1009584742.22848.2.camel@stomata.megapathdsl.net> from "Miles Lane" at Dec 28, 2001 04:12:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K7QM-0002Qi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ../fdomain.c: In function `do_fdomain_16x0_intr':
> ../fdomain.c:1268: `io_request_lock' undeclared (first use in this
> function)
> ../fdomain.c:1268: (Each undeclared identifier is reported only once
> ../fdomain.c:1268: for each function it appears in.)
> ../fdomain.c: In function `fdomain_16x0_release':
> ../fdomain.c:2045: warning: control reaches end of non-void function

Its not been ported to the new block layer yet. Thats a non trivial
challenge for such an old code and grungy driver
