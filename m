Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbTDCRMI 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261510AbTDCRMI 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:12:08 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1664 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261505AbTDCRL5 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 12:11:57 -0500
From: root@81-2-122-30.bradfords.org.uk
Message-Id: <200304031725.h33HPCZK000160@81-2-122-30.bradfords.org.uk>
Subject: Re: I compiled the kernel but it doesn't do any thing, its a bit like typing "halt
To: dean.mcewan@eudoramail.com
Date: Thu, 3 Apr 2003 18:25:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <LKIAPKGOJEIOACAA@whowhere.com> from "Dean McEwan" at Apr 03, 2003 04:49:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > init=/bin/sh is already defined in init/main.c isn't 
> > it?
> >
> >Once the kernel has booted, it usually passed control to init.  The
> >kernel usually looks for init in /sbin /etc and /bin, but if there is
> >no init in those locations, /bin/sh is looked for as a last resort.
> 
> 
> >I am assuming that you have an init on your system, but something is
> >wrong.
> 
> Perhaps. It may be the kernel.
> 
>   Using init=/bin/sh will allow you to use the shell as the init
> >process, which proves it's an init problem.
> 
> I did it but to no avail... Alas Mandrake sucks :-)

So, does the shell run successfully, or does the kernel still hang?

If the shell runs successfully, it's an init problem.  If the kernel hangs,
it's probably a kernel problem.

> >> I accidentally compiled initrd in, but ive got it off
> >> with "noinitrd".
> >
> >I don't really understand what you're trying to do.
> 
> Ok John, I'll put it simply, Im trying to compile a 2.5.* kernel. ;-) 

OK...

> Once ive got a 2.5.* series kernel to work on my machine, I've
> decided to download .66 when I can get the one Ive got now to compile.

So, if your init works fine with 2.4.x, why are you assuming that it's
likely to be an init problem when a 2.5.x kernel doesn't boot?  I thought
maybe you were having specific problems that suggested that init might be to
blame.

> Ok John, calm down you seem a bit agitated :-)

Eh?  What are you basing that on!?  I'm not agitated at all.

> Maybe you've been talking to Andre ;-)

Errr, no.

John.
