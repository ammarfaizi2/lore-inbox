Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTKUWsd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 17:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTKUWsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 17:48:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:42153 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261500AbTKUWsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 17:48:32 -0500
Date: Fri, 21 Nov 2003 14:48:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: pinotj@club-internet.fr
cc: akpm@osdl.org, <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
In-Reply-To: <mnet1.1069438363.27768.pinotj@club-internet.fr>
Message-ID: <Pine.LNX.4.44.0311211446130.13789-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Nov 2003 pinotj@club-internet.fr wrote:
>
> Summary: Oops reproductible when heavy load, bug in mm/slab.c

Do you have CONFIG_PREEMPT on, and if so, does it go away if you compile
without PREEMPT? We have at least one other bug that seems to be dependent
on CONFIG_PREEMPT.

		Linus


