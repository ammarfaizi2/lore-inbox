Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTIHUMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTIHUMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:12:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:3036 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263638AbTIHUMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:12:08 -0400
Date: Mon, 8 Sep 2003 13:11:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       <hugh@veritas.com>, <drepper@redhat.com>, <lk@tantalophile.demon.co.uk>,
       <shemminger@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: today's futex changes
In-Reply-To: <20030908200741.GH27097@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309081310380.1666-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Sep 2003, Jamie Lokier wrote:
> 
> Well, it should really _never_ happen.  We are very careful.  Is
> there something like BUG() which doesn't terminate the process?

That's exactly what WARN() does.

		Linus

