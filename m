Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286103AbRLIAWz>; Sat, 8 Dec 2001 19:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286104AbRLIAWp>; Sat, 8 Dec 2001 19:22:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12043 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286103AbRLIAW2>; Sat, 8 Dec 2001 19:22:28 -0500
Subject: Re: Linux 2.4.17-pre5
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Sun, 9 Dec 2001 00:31:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), anton@samba.org, davej@suse.de,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <20011208214631.75573e9a.rusty@rustcorp.com.au> from "Rusty Russell" at Dec 08, 2001 09:46:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Crs9-0003Gc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The sched.c change is also useless (ie. only harmful).  Anton and I looked at
> adapting the scheduler for hyperthreading, but it looks like the recent 
> changes have had the side effect of making hyperthreading + the current

I trust Intels own labs over you on this one. In fact there is still 
additional work to do to get mm pairing per chip not per cpu unit. Thats
intels patch based on intels work. I suspect they know what their chip
needs.

Alan
