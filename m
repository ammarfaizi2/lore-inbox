Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272989AbTHKTmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274903AbTHKTky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:40:54 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:10173 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S274904AbTHKTjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:39:55 -0400
Date: Mon, 11 Aug 2003 21:40:06 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: M M <mokomull@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.0-test3: make modules; make modules_install problems
Message-ID: <20030811194006.GA1189@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: M M <mokomull@yahoo.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030811192453.51395.qmail@web41811.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030811192453.51395.qmail@web41811.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 12:24:53PM -0700, M M wrote:
> I have downloaded kernel 2.6.0-test3 sources twice (in
> case of error) and the problem still persists.  'make
> modules' compiles the modules to *.o, but 'make
> modules_install' expects them to be *.ko.  Am I the
> only one with this problem or does everyone have this
> problem?

make modules

should show some lines like the following ...

  CC      drivers/block/loop.mod.o
  LD [M]  drivers/block/loop.ko

where the last line is the conversion to .ko 

if your build doesn't do that, I would verify
your utilities ... maybe they are not recent enough?

HTH,
Herbert


> 
> -MrM
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! SiteBuilder - Free, easy-to-use web site design software
> http://sitebuilder.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
