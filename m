Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318375AbSGYJiY>; Thu, 25 Jul 2002 05:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318381AbSGYJiY>; Thu, 25 Jul 2002 05:38:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46532 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318375AbSGYJiY>;
	Thu, 25 Jul 2002 05:38:24 -0400
Date: Thu, 25 Jul 2002 11:40:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cli-sti-removal.txt fixup
In-Reply-To: <Pine.LNX.4.44.0207250115120.3347-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0207251139050.20754-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Jul 2002, Thunder from the hill wrote:

> > > Ah, sorry, I didn't get that from cli-sti-removal.txt.  Actually it
> > > looks like cli-sti-removal.txt is a bit wrong, as there is no
> > > local_irq_save_off() function.  I'll send a patch for that next.
> 
> In my understanding things look rather like this:

indeed - the document did not fully survive some of the cleanups.

> +  local_irq_disable(), local_irq_enable(), local_save_flags(flags),
> +  local_irq_save(flags), local_irq_restore(flags)

yes.

	Ingo

