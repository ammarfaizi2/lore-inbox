Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261557AbSJIKUP>; Wed, 9 Oct 2002 06:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbSJIKUO>; Wed, 9 Oct 2002 06:20:14 -0400
Received: from mnh-1-17.mv.com ([207.22.10.49]:24324 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S261557AbSJIKUO>;
	Wed, 9 Oct 2002 06:20:14 -0400
Message-Id: <200210091130.GAA01533@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Linus <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make do_signal static on i386 
In-Reply-To: Your message of "Wed, 09 Oct 2002 18:10:03 +1000."
             <20021009181003.022da660.sfr@canb.auug.org.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Oct 2002 06:30:19 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sfr@canb.auug.org.au said:
> This patch makes do_signal static in arch/i386/kernel/signal.c which
> means its declaration can be removed from asm-i386/signal.h which may
> help Jeff out with UML. 

Cool, anything which makes the other arch headers more UML-friendly is
good.

> (Does UML work on x86_64, yet?)

Not yet.

				Jeff

