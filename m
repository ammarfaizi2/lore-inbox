Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTKXDop (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 22:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTKXDop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 22:44:45 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:62138 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262030AbTKXDoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 22:44:44 -0500
Subject: Re: ionice kills vanilla 2.6.0-test9 was [Re: [PATCH] cfq + io
	priorities (fwd)]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031121201408.GF6616@suse.de>
References: <20031113124510.GZ643@openzaurus.ucw.cz>
	 <20031121153900.GA193@elf.ucw.cz>  <20031121201408.GF6616@suse.de>
Content-Type: text/plain
Message-Id: <1069645441.876.132.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 24 Nov 2003 14:44:01 +1100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I saw that on ppc too, btw, didn't trace it yet. But there definitely is
> a problem with calling syscalls that don't exist.
> 
> > [What is needed to start using cfq? Is your patch, this utility and
> > elevator=cfq enough?]

We had an additional bug on PPC with signals above NR_signal that
paulus recent patches should have fixed

Ben.


