Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319307AbSH3Ca4>; Thu, 29 Aug 2002 22:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319331AbSH3Ca4>; Thu, 29 Aug 2002 22:30:56 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:1733 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319307AbSH3Caz>;
	Thu, 29 Aug 2002 22:30:55 -0400
Date: Thu, 29 Aug 2002 19:35:05 -0700
To: "B. Joshua Rosen" <bjrosen@polybus.com>, hch@lst.de
Cc: jgarzik@mandrakesoft.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Compilation errors in 2.4.20.rc5
Message-ID: <20020830023504.GC14559@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <1030673385.30059.4.camel@yorktown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030673385.30059.4.camel@yorktown>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 10:09:45PM -0400, B. Joshua Rosen wrote:
> -o wavelan_cs.o wavelan_cs.c
> In file included from wavelan_cs.c:66:
> /home/tmp/linux/include/linux/ethtool.h:18: parse error before `u32'
> /home/tmp/linux/include/linux/ethtool.h:18: warning: no semicolon at end
> of struct or union
> /home/tmp/linux/include/linux/ethtool.h:19: warning: type defaults to
> `int' in declaration of `supported'

	Ok, I'll forward...

	hch@lst.de (or whoever did that) :
	1) I don't really think that a wireless driver will get much
benefit from ethtool (try setting full duplex ;-)
	2) Headers are added in the file wavelan_cs.h, to keep
wavelan.c clean and tidy. And this would have avoided the bug.
	3) It take only 2 second to try to compile before submitting
your changes. Even the best of us do it.
	4) A MAINTAINER is not someone that clean up after the mess of
other people. I usually answer my e-mail, and I could have both answer
your question and reviewed the patch.

	So, please clean up your mess...

	Jean
