Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbSKOEYe>; Thu, 14 Nov 2002 23:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265757AbSKOEYe>; Thu, 14 Nov 2002 23:24:34 -0500
Received: from ns.suse.de ([213.95.15.193]:37389 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265754AbSKOEYd>;
	Thu, 14 Nov 2002 23:24:33 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] early printk for x86
References: <3DD3FCB3.40506@us.ibm.com.suse.lists.linux.kernel> <3DD40719.5030108@pobox.com.suse.lists.linux.kernel> <3DD428C3.4030700@us.ibm.com.suse.lists.linux.kernel> <20021115044300.C20764@wotan.suse.de.suse.lists.linux.kernel> <ar1sdm$gfe$1@cesium.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Nov 2002 05:31:27 +0100
In-Reply-To: "H. Peter Anvin"'s message of "15 Nov 2002 05:18:56 +0100"
Message-ID: <p73u1ijv4gw.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > That's overkill. Most architectures have an early_printk equivalent in 
> > firmware. Only i386 and x86-64 are not lucky enough to have one 
> > that is usable from the CPU mode linux uses.
> > 
> 
> That's a pretty big assumption.  I wouldn't hold that to be
> necessarily true.

But then assuming they have PC style VGA/serial is a pretty big
assumption too.

It is probably better hidden in arch/

-Andi
