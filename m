Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbSKDQqa>; Mon, 4 Nov 2002 11:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbSKDQqa>; Mon, 4 Nov 2002 11:46:30 -0500
Received: from ns.suse.de ([213.95.15.193]:18962 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263026AbSKDQq2>;
	Mon, 4 Nov 2002 11:46:28 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lkcd-general] Re: What's left over.
References: <Pine.LNX.4.44.0211040727330.771-100000@home.transmeta.com.suse.lists.linux.kernel> <1036429035.1718.99.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Nov 2002 17:53:02 +0100
In-Reply-To: Alan Cox's message of "4 Nov 2002 17:39:41 +0100"
Message-ID: <p73smyhqntd.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Let me ask another question here
> 
> Other than "register_reboot_notifier()" and adding a 
> "register_exception_notifier()" chain what else does a dump tool need.
> Register_exception_notifier seems to solve about 90% of the insmod gdb 
> problem space as well ?

A memory dumper needs some infrastructure to find out what page is ram
and what is hole etc.
Basically an iterate_over_memmap_and_give_me_type() function.

-Andi
