Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbUC1UjE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbUC1Uis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:38:48 -0500
Received: from gprs214-54.eurotel.cz ([160.218.214.54]:56705 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262424AbUC1Ufj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:35:39 -0500
Date: Sun, 28 Mar 2004 22:35:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ivan Godard <igodard@pacbell.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel support for peer-to-peer protection models...
Message-ID: <20040328203529.GH406@elf.ucw.cz>
References: <048e01c413b3_3c3cae60_fc82c23f@pc21> <20040327103401.GA589@openzaurus.ucw.cz> <066b01c41464$7e0ec9c0$fc82c23f@pc21> <20040328062422.GB307@elf.ucw.cz> <06ea01c4148e$67436c80$fc82c23f@pc21> <20040328185410.GE406@elf.ucw.cz> <07af01c414fe$d6836300$fc82c23f@pc21>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07af01c414fe$d6836300$fc82c23f@pc21>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > If most changes are in arch/, it should be acceptable...
> > >
> > > I fear that it might be more extensive than that :-)
> >
> > Well, make patch and lets see... That means that 2.8 needs to be your
> > target. If impact outside of arch is not "total rewrite", you might
> > have a chance. If it is "total rewrite".... well you just need to be
> > very clever.
> 
> How badly would the average driver break if it did not have direct data
> access to kernal data structures? Calls into the kernel and direct access by
> the called functions are OK.

Kernel likes to pass it pointers to internal data structures. And
drivers will walk over pointers in those structures pretty
often.

Actually I'm not so sure. Perhaps for simple drivers something like
that would be possible..

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
