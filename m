Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263659AbTIHUIT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263651AbTIHUIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:08:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54927 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263659AbTIHUIQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:08:16 -0400
Date: Mon, 8 Sep 2003 21:07:41 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, hugh@veritas.com,
       drepper@redhat.com, lk@tantalophile.demon.co.uk, shemminger@osdl.org,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: today's futex changes
Message-ID: <20030908200741.GH27097@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain> <20030908102309.0AC4E2C013@lists.samba.org> <20030908120234.5d05cda9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908120234.5d05cda9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> > D: 4) Andrew Morton says spurious wakeup is a bug.  Catch it.
> 
> Yes, but going BUG() is a bit rude.  We can detect the error, we can
> recover from it and it doesn't cause any user data corruption or anything.
> A rude printk is all that is needed here.

Well, it should really _never_ happen.  We are very careful.  Is
there something like BUG() which doesn't terminate the process?

-- Jamie
