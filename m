Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTI2REQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263791AbTI2REQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:04:16 -0400
Received: from buerotecgmbh.de ([217.160.181.99]:18922 "EHLO buerotecgmbh.de")
	by vger.kernel.org with ESMTP id S263788AbTI2REN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:04:13 -0400
Date: Mon, 29 Sep 2003 19:04:12 +0200
From: Kay Sievers <lkml001@vrfy.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zombies
Message-ID: <20030929170412.GA9391@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > PID TTY      STAT   TIME COMMAND
> > 1 ?        S      0:04 init [3]
> > 2 ?        SWN    0:00 [ksoftirqd/0]
> > 3 ?        SW<    0:00 [events/0]
> > 3158 ?        Z<     0:00  \_ [events/0] <defunct>
> > 3162 ?        Z<     0:00  \_ [events/0] <defunct>

> ah, OK.  What happens if you do a `patch -R -p1' using
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-\
> mm1/broken-out/call_usermodehelper-retval-fix-2.patch ? 

This fixes it.

Thanks
Kay
