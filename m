Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbTIZH1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 03:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbTIZH1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 03:27:43 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:32968 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261971AbTIZH1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 03:27:42 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frank v Waveren <fvw@var.cx>
Cc: Kernel Developer List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030926052636.GA15006@var.cx>
References: <20030925160351.E26493@one-eyed-alien.net>
	 <20030926052636.GA15006@var.cx>
Message-Id: <1064561225.28616.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 26 Sep 2003 09:27:05 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: How do I access ioports from userspace?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-26 at 07:26, Frank v Waveren wrote:
> On Thu, Sep 25, 2003 at 04:03:51PM -0700, Matthew Dharm wrote:
> > I'd like to be able to access some ioports to some custom hardware directly
> > from userspace, without creating a specialized kernel-level driver.  Is
> > there a way to do that?
> Either use /dev/port, or if it's performance critical (but not performance
> critical enough to do in kernelspace), use ioperm/iopl and inb/outb.

Simple note: the above will work on x86 only...

Ben.



