Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277565AbRJLINd>; Fri, 12 Oct 2001 04:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277572AbRJLINY>; Fri, 12 Oct 2001 04:13:24 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:49038 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S277565AbRJLING>; Fri, 12 Oct 2001 04:13:06 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200110120812.JAA16775@mauve.demon.co.uk>
Subject: Re: Module read a file?
To: linux-kernel@vger.kernel.org
Date: Fri, 12 Oct 2001 09:12:15 +0100 (BST)
In-Reply-To: <20011011144637.C16452@kroah.com> from "Greg KH" at Oct 11, 2001 02:46:37 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thu, Oct 11, 2001 at 02:25:09PM -0700, Mark Atwood wrote:
> > 
> > Because the firmware is stored in volitile memory on the card, and
> > vanishes on a card reset or removal, and I would like to have it Just
> > Work with the pcmcia-cs package with minimal changes.
> 
> Then add a script in the proper place in the linux-hotplug [1] package,
> which will run everytime your card is inserted.  This is how USB
> firmware loads will be done in 2.5.

Or, the existing PCMCIA scripts from the pcmcia-cs package in
/etc/pcmcia
Assuming the card is recognised in some way, perhaps as a memory card,
you just stick the program to load the code into memory.opts
