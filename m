Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268702AbTCCS1Y>; Mon, 3 Mar 2003 13:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268703AbTCCS1X>; Mon, 3 Mar 2003 13:27:23 -0500
Received: from bitmover.com ([192.132.92.2]:24544 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S268702AbTCCS1V>;
	Mon, 3 Mar 2003 13:27:21 -0500
Date: Mon, 3 Mar 2003 10:37:34 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arador <diegocg@teleline.es>, "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz, hch@infradead.org
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
Message-ID: <20030303183734.GB21701@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	pavel@janik.cz, pavel@ucw.cz, hch@infradead.org
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030302014915.34a6de37.diegocg@teleline.es> <1046571336.24903.0.camel@irongate.swansea.linux.org.uk> <3E615C38.7030609@pobox.com> <20030302014039.GC1364@dualathlon.random> <3E616224.6040003@pobox.com> <20030302020907.GE1364@dualathlon.random> <3E623F37.6060005@pobox.com> <20030302181615.GA25902@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030302181615.GA25902@dualathlon.random>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How close is http://www.bitmover.com/EXPORT to what you want (3MB file).

Note that this is very coarse granularity, it's very 2.5.62 up to 2.5.63,
in practice the granularity would be as least as fine as each of Linus'
pushes and finer if possible.  We can't capture all the branching structure
in patches, there is too much parallelism, but what we can do is capture
each push that Linus does and if he did more than one merge in that push,
we can break it up into each merge.  

We can also provide this as a BK url on bkbits for any cset or range of
csets (we'll have to get another T1 line but I don't see way around that).

This should give enough information that anyone could build their own 
BK 2 SVN gateway (or whatever, we're doing the CVS one).

Also, here's what Linus' recent pushes look like WITHOUT breaking it into
each merge, we're still working on that code:

     57 csets on 2003/03/03 08:49:44 
      5 csets on 2003/03/02 21:30:31 
     28 csets on 2003/03/02 21:04:02 
      1 csets on 2003/03/02 10:19:24 
     49 csets on 2003/03/01 19:03:58 
      2 csets on 2003/03/01 11:04:04 
      5 csets on 2003/03/01 09:19:24 
      1 csets on 2003/02/28 19:34:30 
     37 csets on 2003/02/28 15:30:29 
      8 csets on 2003/02/28 15:18:12 
     23 csets on 2003/02/28 15:05:08 
     31 csets on 2003/02/27 23:30:05 
     16 csets on 2003/02/27 09:15:07 
     11 csets on 2003/02/27 07:45:06 
     47 csets on 2003/02/26 23:09:53 
     32 csets on 2003/02/25 21:35:34 
     24 csets on 2003/02/25 18:34:41 
     22 csets on 2003/02/25 15:49:41 
     14 csets on 2003/02/24 21:23:34 
      3 csets on 2003/02/24 15:19:44 
      1 csets on 2003/02/24 11:16:14 
     15 csets on 2003/02/24 11:00:36 
      4 csets on 2003/02/24 10:48:49 
      1 csets on 2003/02/24 10:03:36 
     15 csets on 2003/02/24 09:49:34 
      1 csets on 2003/02/23 20:33:00 
      3 csets on 2003/02/23 11:15:28 
      8 csets on 2003/02/23 11:01:10 
      6 csets on 2003/02/23 10:49:14 
      2 csets on 2003/02/22 19:32:35 
      4 csets on 2003/02/22 16:17:27 
      1 csets on 2003/02/22 12:45:28 
     76 csets on 2003/02/22 12:34:13 
      1 csets on 2003/02/21 20:18:19 
      6 csets on 2003/02/21 19:49:32 
     86 csets on 2003/02/21 18:03:23 
      3 csets on 2003/02/21 16:18:24 
     30 csets on 2003/02/21 14:14:48 
      1 csets on 2003/02/21 10:18:19 
      1 csets on 2003/02/21 09:49:15 
etc.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
