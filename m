Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTIBHXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 03:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTIBHXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 03:23:11 -0400
Received: from [62.241.33.80] ([62.241.33.80]:34823 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263580AbTIBHXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 03:23:09 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>, Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: 2.4.22pre7aa1: unresolved in sk98lin
Date: Tue, 2 Sep 2003 09:20:08 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, cgoos@syskonnect.de, mlindner@syskonnect.de,
       linux@syskonnect.de
References: <20030719013223.GA31330@dualathlon.random> <3F1C763E.78D67BC3@eyal.emu.id.au> <20030901234600.GA11503@dualathlon.random>
In-Reply-To: <20030901234600.GA11503@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309020920.08259.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 September 2003 01:46, Andrea Arcangeli wrote:

Hi Andrea,

> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.22-pre7-aa1/kernel/drivers/net/sk98lin/sk98lin.o
> > depmod:         __udivdi3
> There are several functions triggering this problem, and it's a mainline
> 2.4 problem (I don't see anything specific to my tree).
> I'm CCing the authors of the driver, is there a new version or are we the
> first triggering it? I can fix it myself but I'd prefer to avoid any
> duplication since it's not a one liner.

the problem is _was_ the sk98lin driver, but this problem is gone for a very 
long time now. 2.4.23-pre* will get an update in the next days with sk98lin 
v6.17 (current 6.02 is in mainline) and the problem is gone with it.

Or at least, I don't get the unresolved symbols problem with it ;)

ciao, Marc

