Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422802AbWJNSuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422802AbWJNSuY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 14:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422805AbWJNSuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 14:50:23 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:21469 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1422802AbWJNSuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 14:50:23 -0400
Date: Sat, 14 Oct 2006 12:50:22 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Amol Lad <amol@verismonetworks.com>,
       kernel Janitors <kernel-janitors@lists.osdl.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [KJ] [PATCH] drivers/char/riscom8.c: save_flags()/cli()/sti()	removal
Message-ID: <20061014185022.GO11633@parisc-linux.org>
References: <1160739628.19143.376.camel@amol.verismonetworks.com> <1160835602.5732.30.camel@localhost.localdomain> <20061014174936.GN11633@parisc-linux.org> <1160851280.5732.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160851280.5732.34.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 07:41:20PM +0100, Alan Cox wrote:
> Ar Sad, 2006-10-14 am 11:49 -0600, ysgrifennodd Matthew Wilcox:
> > Only broken on SMP ...
> > 
> > I wouldn't mind writing a new driver (using the serial core) if someone
> > wants to send me one.  I need a multiport serial card anyway ...
> 
> You still have ISA bus ?

Oh ... well ... not really.  My only remaining ISA motherboard was a
casualty of my last move (15 months ago).  I have a pair of PA-RISC
machines with EISA slots, but if this thing does DMA, I have to track
down some docs and write some code to get that working.
