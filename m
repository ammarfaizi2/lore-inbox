Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270980AbTG1US4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270880AbTG1US4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:18:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:7118 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270827AbTG1USw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:18:52 -0400
Date: Mon, 28 Jul 2003 13:07:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Ethernet falls into deep sleep.
Message-Id: <20030728130719.33e14be6.akpm@osdl.org>
In-Reply-To: <200307281323.47013.fsdeveloper@yahoo.de>
References: <200307281323.47013.fsdeveloper@yahoo.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <fsdeveloper@yahoo.de> wrote:
>
> I've a problem with my server/router, that I've seen on
> various kernels. currently I'm running 2.4.21, but I've
> seen the problem on 2.4.20 and 2.5.70, too.
> I'm using a 3com 3c509 ISA ethernet card.
> 
> When this server stays a longer time (about one night, 12 hours)
> without network-traffic, it seems like the whole network-interface
> falls into a very deep sleep. It's very hard to wake the machine
> up.

This could be a router problem: some routers (Cisco?) decide that a host has
died if no traffic has been seen for a long time.  Google for "vortex
sleepy nic" for some discussion.

I haven't seen any reports of this in a looong time.  IIRC it was worked
around by pinging some remote host once per minute.


