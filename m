Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275484AbTHJJKP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 05:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275486AbTHJJKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 05:10:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2989 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S275484AbTHJJKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 05:10:08 -0400
Date: Sun, 10 Aug 2003 02:04:44 -0700
From: "David S. Miller" <davem@redhat.com>
To: Matt Mackall <mpm@selenic.com>
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org
Subject: Re: virt_to_offset() (Re: [RFC][PATCH] Make cryptoapi
 non-optional?)
Message-Id: <20030810020444.48cb740b.davem@redhat.com>
In-Reply-To: <20030810090556.GY31810@waste.org>
References: <20030809194627.GV31810@waste.org>
	<20030809131715.17a5be2e.davem@redhat.com>
	<20030810081529.GX31810@waste.org>
	<20030810.173215.102258218.yoshfuji@linux-ipv6.org>
	<20030810013041.679ddc4c.davem@redhat.com>
	<20030810090556.GY31810@waste.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Aug 2003 04:05:56 -0500
Matt Mackall <mpm@selenic.com> wrote:

> > With some name like "virt_to_pageoff()" it sounds like a great
> > idea.
> 
> Had the same thought. Nowhere good to stick it, so I put it in mm.

That looks fine to me.

Yoshfuji, feel free to do your conversions, and use this
linux/mm.h placement of the virt_to_pageoff() macro instead
of having to put it into every asm header.
