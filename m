Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUEPR1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUEPR1x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUEPR1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:27:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:32396 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263736AbUEPR1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:27:51 -0400
Date: Sun, 16 May 2004 10:25:16 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: GOTO Masanori <gotom@debian.or.jp>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [patch] kill off PC9800
Message-Id: <20040516102516.06befd27.rddunlap@osdl.org>
In-Reply-To: <818yfsz6sy.wl@omega.webmasters.gr.jp>
References: <20040515232155.134a76be.rddunlap@osdl.org>
	<20040515232858.022abe77.akpm@osdl.org>
	<818yfsz6sy.wl@omega.webmasters.gr.jp>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2004 01:16:13 +0900 GOTO Masanori <gotom@debian.or.jp> wrote:

| At Sat, 15 May 2004 23:28:58 -0700,
| Andrew Morton wrote:
| > "Randy.Dunlap" <rddunlap@osdl.org> wrote:
| > >
| > >  PC9800 sub-arch is incomplete, hackish (at least in IDE), maintainers
| > >  don't reply to emails and haven't touched it in awhile.
| > 
| > And the hardware is obsolete, isn't it?  Does anyone know when they were
| > last manufactured, and how popular they are?
| 
| Well NEC PC9800 serires were stopped to manufacture a few years
| before.  But even so, it seems there're users to use this type of
| hardware.  There were one Japanese distribution which supported
| PC9800.  So I wonder it should be really needed to remove.

Well, it's just not usable at all in its current from in the
maintained Linux tree, so if it's used by someone, it requires
lots of other patches (approx. 136 KB patch), which should be
submitted for review/evaluation and possible merging.

It needs to be fixed and maintained (which is not a one-time thing,
but a continuing job), or it should go away, and people who might
use it can use an even larger out-of-kernel-tree patch.

--
~Randy
