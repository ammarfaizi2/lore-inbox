Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbSJIINK>; Wed, 9 Oct 2002 04:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbSJIINK>; Wed, 9 Oct 2002 04:13:10 -0400
Received: from ns.suse.de ([213.95.15.193]:47377 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261504AbSJIINI>;
	Wed, 9 Oct 2002 04:13:08 -0400
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make do_signal static on i386
References: <20021009181003.022da660.sfr@canb.auug.org.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 09 Oct 2002 10:18:49 +0200
In-Reply-To: Stephen Rothwell's message of "9 Oct 2002 10:13:26 +0200"
Message-ID: <p73vg4cowie.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> I am not sure whether we need the FASTCALL() or whether the change

The FASTCALL was only needed when it was still called from entry.S
(= in 2.4) 

> in the comment in asm-um/signal.h makes sense.  (Does UML work on
> x86_64, yet?)

I doubt that it works. At least I never tried it.

-Andi

