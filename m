Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265100AbUFVXFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUFVXFA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUFVXDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:03:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:56491 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265053AbUFVXB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 19:01:27 -0400
Subject: Re: [PATCH] ppc32: Cleanups & warning fixes of traps.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040622223453.GB9342@smtp.west.cox.net>
References: <1087931251.1861.8.camel@gaston>
	 <20040622223453.GB9342@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1087944876.1854.127.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 17:54:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-22 at 17:34, Tom Rini wrote:
> On Tue, Jun 22, 2004 at 02:07:32PM -0500, Benjamin Herrenschmidt wrote:
> 
> > Hi !
> > 
> > This patch cleans up arch/ppc/kernel/traps.c and vecemu.c to use the same
> > formatting style for all functions,
> 
> Isn't that undoing what Lindent does?  Which is at least possibly why
> it's done that way now..

I don't know if that has anything to do with lindent. I used to format
that way myself but changed my mind, and paulus seemed to do both, but I
remember a recent discussion where Linus clearly explained his
preference having the return type on the same line as the function name.

It's also more handy with grep.

Ben.



