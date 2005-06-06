Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVFFVlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVFFVlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVFFVlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:41:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35555 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261697AbVFFVlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:41:39 -0400
Date: Mon, 6 Jun 2005 23:41:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
Message-ID: <20050606214124.GL2230@elf.ucw.cz>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050606192654.GA3155@elf.ucw.cz> <Pine.LNX.4.58.0506061310500.1876@ppc970.osdl.org> <20050606201441.GG2230@elf.ucw.cz> <Pine.LNX.4.58.0506061411410.1876@ppc970.osdl.org> <20050606211849.GK2230@elf.ucw.cz> <Pine.LNX.4.58.0506061433480.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506061433480.1876@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I thought you are taking "first From: in the body", not "From: only if
> > it is first line in the body". [Could you perhaps modify your scripts
> > to take "first From: in the body"? It seems logical to put From "near"
> > Signed-of-by: lines...
> 
> I really don't want to, for a number of reasons. Most notably because I
> don't want to mix things up with the sign-off, because authorship and
> sign-off are really separate things (sign-offs accumulate, authorship
> stays), but also because it's not entirely unambiguous to parse these
> things. With the "first line only" rule, it ends up being pretty clear 
> what's going on when the script suddenly ate one line..

Okay, I see. I'm little afraid that during forwards blank line will be
inserted before "From: " and break this, but lets see how it works.

								Pavel
