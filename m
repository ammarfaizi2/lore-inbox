Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132649AbQLQOuT>; Sun, 17 Dec 2000 09:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132652AbQLQOuI>; Sun, 17 Dec 2000 09:50:08 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:38928 "EHLO
	amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S132649AbQLQOtz>; Sun, 17 Dec 2000 09:49:55 -0500
Date: Sun, 17 Dec 2000 16:26:49 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Pavel Machek <pavel@suse.cz>, stewart@neuron.com,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: kapm-idled : is this a bug?
In-Reply-To: <20001217031814.A11954@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.21.0012171624570.6706-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> How about adding a flag to FLAGS, or a new letter in STATE in
> /proc/pid/stat, to mean "this is an idle task"?
> 
> ps & top could easily by taught to recognise the flag.

What's the problem with using PID 0 as the idle task ? That's 'standard'
with OS'ses that display the idle task.

It's also the 'right' thing to do, and should directly work with top / ps


	Igmar


	

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
