Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVFFVeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVFFVeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVFFVeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:34:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:27528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261679AbVFFVeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:34:02 -0400
Date: Mon, 6 Jun 2005 14:36:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
In-Reply-To: <20050606211849.GK2230@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0506061433480.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
 <20050606192654.GA3155@elf.ucw.cz> <Pine.LNX.4.58.0506061310500.1876@ppc970.osdl.org>
 <20050606201441.GG2230@elf.ucw.cz> <Pine.LNX.4.58.0506061411410.1876@ppc970.osdl.org>
 <20050606211849.GK2230@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Jun 2005, Pavel Machek wrote:
> 
> I thought you are taking "first From: in the body", not "From: only if
> it is first line in the body". [Could you perhaps modify your scripts
> to take "first From: in the body"? It seems logical to put From "near"
> Signed-of-by: lines...

I really don't want to, for a number of reasons. Most notably because I
don't want to mix things up with the sign-off, because authorship and
sign-off are really separate things (sign-offs accumulate, authorship
stays), but also because it's not entirely unambiguous to parse these
things. With the "first line only" rule, it ends up being pretty clear 
what's going on when the script suddenly ate one line..

		Linus
