Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271928AbTG2RUr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271919AbTG2RUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:20:47 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:25060 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S271928AbTG2RUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:20:46 -0400
Date: Tue, 29 Jul 2003 19:20:44 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2: cursor started to disappear
In-Reply-To: <20030728183443.GC572@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0307291915590.32233-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Jul 2003, Pavel Machek wrote:

> Hi!
>
> > > Plus I'm seeing some silent data corruption. It may be
> > > swsusp or loop related
> >
> > Loop is not stable at all. Unsuitable for daily use.
>
> Ouch... I have my most important filesystem on loop. Time to go back
> to 2.4.X? Or do you have some patches you want me to try?

Time to go back to 2.0.x --- it's the only kernel where loop was
correctly (almost) deadlockless implemented :)

Mikulas

