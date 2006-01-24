Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWAXV47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWAXV47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWAXV47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:56:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14259 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750763AbWAXV4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:56:54 -0500
Date: Tue, 24 Jan 2006 13:58:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-Id: <20060124135843.739481e7.akpm@osdl.org>
In-Reply-To: <20060124213010.GA1602@elf.ucw.cz>
References: <200601240929.37676.rjw@sisk.pl>
	<20060124131312.0545262d.akpm@osdl.org>
	<20060124213010.GA1602@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> > > This patch introduces a user space interface for swsusp.
> > 
> > How will we know if/when this feature is ready for mainline?  What criteria
> > can we use to judge that?
> 
> It was stable for me last time I tested. I do not think it needs
> longer -mm testing than usual patches.

One we've shipped the interface we're kinda stuck with it for ever, so it
does want to be pretty mature.

> > 
> > whee, what does the mystery barrier do?  It'd be nice to comment this
> > (please always comment open-coded barriers).
> 
> It is probably relic from very early code, should not be needed, but
> everyone is scared of removing it.

rofl.
