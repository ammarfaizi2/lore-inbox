Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbTI1TVs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 15:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTI1TVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 15:21:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:64007 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262686AbTI1TVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 15:21:47 -0400
Date: Sun, 28 Sep 2003 21:21:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Russell King <rmk@arm.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_I8042
In-Reply-To: <20030928194511.C1428@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0309282119430.17548-100000@serv>
References: <20030928161059.B1428@flint.arm.linux.org.uk>
 <Pine.LNX.4.44.0309281136141.15408-100000@home.osdl.org>
 <20030928194511.C1428@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 28 Sep 2003, Russell King wrote:

> > Well, it does require us to have at least SERIO. Also, we need to have 
> > some way to make sure that I8042 does get selected on a PC.
> >
> > Apart from that, it doesn't matter how it's solved..
> 
> It appears that "select" doesn't accept conditionals as the kconfig
> language stands - jejb also ran into this issue, and tried various
> ways around.  The only solution which seems to work is to remove this
> select line entirely.

What did you try? E.g. "select SERIO_I8042 if !EMBEDDED && X86" works fine 
here.

bye, Roman

