Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbULXNyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbULXNyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 08:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbULXNyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 08:54:46 -0500
Received: from albireo.enyo.de ([212.9.189.169]:26827 "EHLO albireo.enyo.de")
	by vger.kernel.org with ESMTP id S261323AbULXNyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 08:54:45 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix inlining related build failures in mxser.c
References: <Pine.LNX.4.61.0412240155070.3504@dragon.hygekrogen.localhost>
	<Pine.LNX.4.61.0412241306340.19395@yvahk01.tjqt.qr>
	<Pine.LNX.4.61.0412241431580.3707@dragon.hygekrogen.localhost>
Date: Fri, 24 Dec 2004 14:54:43 +0100
In-Reply-To: <Pine.LNX.4.61.0412241431580.3707@dragon.hygekrogen.localhost>
	(Jesper Juhl's message of "Fri, 24 Dec 2004 14:33:37 +0100 (CET)")
Message-ID: <87zn03u7h8.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jesper Juhl:

>> Add -funit-at-a-time to the CFLAGS, and the compiler is happy.
>> 
> But, does unit-at-a-time work reliably for all compilers on all archs back 
> to and including gcc 2.95.3 ? 

Unit-at-a-time is only available in GCC 3.4 and above.
Function-at-a-time will still be supported in GCC 4.0, but this
version will use unit-at-a-time by default (if optimization is
enable).
