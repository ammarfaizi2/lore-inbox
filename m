Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTLJPSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 10:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTLJPSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 10:18:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:60562 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263638AbTLJPS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 10:18:29 -0500
Date: Wed, 10 Dec 2003 07:18:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andre Hedrick <andre@linux-ide.org>
cc: Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.58.0312100714390.29676@home.osdl.org>
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Dec 2003, Andre Hedrick wrote:
>
> So why not do the removal of the inlines to real .c files and quit playing
> games with bogus attempts to bleed taint into the inprotectable api?

The inlines have nothing to do with _anything_.

Trust me, a federal judge couldn't care less about some very esoteric
technical detail. I don't know who brought up inline functions, but they
aren't what would force the GPL.

What has meaning for "derived work" is whether it stands on its own or
not, and how tightly integrated it is. If something works with just one
particular version of the kernel - or depends on things like whether the
kernel was compiled with certain options etc - then it pretty clearly is
very tightly integrated.

Don't think that copyright would depend on any technicalities.

		Linus
