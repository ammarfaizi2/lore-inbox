Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbTL3WUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265880AbTL3WUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:20:18 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:55480 "EHLO
	omta08.mta.everyone.net") by vger.kernel.org with ESMTP
	id S263692AbTL3WTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:19:00 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Tue, 30 Dec 2003 14:18:58 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: Slab allocator . . . cache?  WTF is it?
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20031230221859.15F503956@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mem:    775616k total,   747740k used,    27876k free,    96584k buffers
Swap:   250480k total,    71340k used,   179140k free,   298852k cached


This is somewhat distressing.  Last time this happened, I started opening every
program I had (including every OpenOffice.org product and every browser I had
installed), and the "cached" value dropped quickly.

I'm wondering, what IS cache?  It seems to increase even when swap is not used,
and sometimes when there's no swap partition enabled.  It also seems to cause
me to run into swap when I have ample ram available, assuming that cache is just
some sort of cache that is copied from and mirrors another portion of ram for
some sort of speed increase.  It's wasteful to me, and I want to more understand
its implimentation and its purpose, and in all honesty limit its impact if possible.
I got this RAM upgrade because I was using about 676M of RAM total, including swap,
at peak; and now I find myself using 820M RAM at peak and about 750-800 continually.

As always, i'm not on the list, so I'd prefer to be CC'd replies.

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
