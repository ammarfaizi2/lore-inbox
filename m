Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTHXOrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 10:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbTHXOrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 10:47:11 -0400
Received: from p508B57B3.dip.t-dialin.net ([80.139.87.179]:13770 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP id S261168AbTHXOrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 10:47:09 -0400
Date: Sun, 24 Aug 2003 16:46:39 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-rc3 - unresolved
Message-ID: <20030824144639.GB23354@linux-mips.org>
References: <Pine.LNX.4.55L.0308231429530.19769@freak.distro.conectiva> <3F480BAB.DD644074@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F480BAB.DD644074@eyal.emu.id.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 10:49:47AM +1000, Eyal Lebedinsky wrote:

> > Here goes -rc3
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.22-rc3/kernel/drivers/net/tc35815.o
> depmod:         tc_readl
> depmod:         tc_writel

This driver only works for JMR3927 boards, disable it.  I'll send Marcelo
a fix.

  Ralf

--
"Embrace, Enhance, Eliminate" - it worked for the pope, it'll work for Bill.
