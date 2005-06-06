Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVFFVTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVFFVTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVFFVTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:19:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23507 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261667AbVFFVTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:19:03 -0400
Date: Mon, 6 Jun 2005 23:18:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
Message-ID: <20050606211849.GK2230@elf.ucw.cz>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050606192654.GA3155@elf.ucw.cz> <Pine.LNX.4.58.0506061310500.1876@ppc970.osdl.org> <20050606201441.GG2230@elf.ucw.cz> <Pine.LNX.4.58.0506061411410.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506061411410.1876@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There is "From: Dmitry..." in the changelog. Do your script move first
> > "From:" into author header and delete it from changelog? That would
> > explain it...
> 
> Yes. But note how it doesn't even take the "first" From: line, it 
> literally takes the From: line _only_ if that line is the first line in 
> the email body.
> 
> See the "git-tools" archive if you want to see all the ugly details (start 
> from http://www.kernel.org/git)

Aha, okay, it was going to you through andrew, and it was me who
posted the changelog in form

Description

From: XXX
Signed-off-by: YYY

I thought you are taking "first From: in the body", not "From: only if
it is first line in the body". [Could you perhaps modify your scripts
to take "first From: in the body"? It seems logical to put From "near"
Signed-of-by: lines...
								Pavel
