Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTLDW3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTLDW3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:29:43 -0500
Received: from fep22-0.kolumbus.fi ([193.229.0.60]:46299 "EHLO
	fep22-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S263618AbTLDW3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:29:42 -0500
Date: Thu, 4 Dec 2003 22:28:50 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Peter Bergmann <bergmann.peter@gmx.net>
cc: Jens Axboe <axboe@suse.de>, maze@cela.pl, linux-kernel@vger.kernel.org
Subject: Re: oom killer in 2.4.23
In-Reply-To: <956.1070570308@www27.gmx.net>
Message-ID: <Pine.LNX.4.58.0312042205160.2330@ua178d119.elisa.omakaista.fi>
References: <20031204184248.GJ1086@suse.de> <956.1070570308@www27.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Dec 2003, Peter Bergmann wrote:

> I would be really glad if someone (aa may be :) could
> provide the information where/how to place the call for a custom
> (or the old) oom killer -  if it's really that simple ...

In the 2.2 backport I called it from the page fault handler,

  http://mlf.linux.rulez.org/mlf/ezaz/reserved_root_memory.html

It worked fine for 2.2 but I don't know the current 2.4 VM state (without
the oom killer it's just running amok, as you experienced).

	Szaka
