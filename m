Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbUDSIw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 04:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbUDSIw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 04:52:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:8370 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264304AbUDSIw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 04:52:56 -0400
Date: Mon, 19 Apr 2004 01:52:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Cc: danlee@informatik.uni-freiburg.de, b-gruber@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
Message-Id: <20040419015221.07a214b8.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0404191124220.21825@stekt37>
References: <Pine.GSO.4.58.0402271451420.11281@stekt37>
	<Pine.GSO.4.58.0404191124220.21825@stekt37>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tuukka Toivonen <tuukkat@ee.oulu.fi> wrote:
>
> psaux.c release 2004-04-19
> 
> This is psaux.c linux kernel driver for kernels 2.6.x,
> a direct PS/2 serial port (aka /dev/psaux) driver.
> 
> Available from:
> http://www.ee.oulu.fi/~tuukkat/rel/psaux-2004-04-19.tar.gz
> 
> (includes README with more information)
> 
> The driver was originally written by Lee Sau Dan
> http://www.informatik.uni-freiburg.de/~danlee/fun/psaux/
> but I fixed some bugs (most importantly SMP).
> 
> I've seen lots of discussions about different mouse behaviour (or
> completely non-functioning mouse). If you have one of those problems, this
> driver should restore the kernel 2.4.x behaviour.
> 
> Any suggestions/hopes to get it included into mainstream kernel?

I'd imagine that the input developers would regard that as a step in the
wrong direction.

Have you sent a report regarding the touchscreen problem?  Is it a
straightforward bug, or has real functionality been lost?


> P.S. is there any documentation about the serio interface (serio_open()
> etc...)? I couldn't find anywhere.

Always a good question ;)
