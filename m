Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTDXJFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTDXJFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:05:31 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:33458 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262000AbTDXJF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:05:28 -0400
Date: Thu, 24 Apr 2003 11:16:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424091602.GC3039@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com> <20030424000344.GC32577@atrey.karlin.mff.cuni.cz> <1592050000.1051142225@flay> <20030424002551.GA2980@elf.ucw.cz> <1608070000.1051145373@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608070000.1051145373@flay>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> OK ... but at least having the *option* to have a separate reserved
> >> area would be nice, no? For most people, RAM is just a tiny amount
> >> of their disk space ... and damn, does it make the code simpler ;-)
> > 
> > If it is an *option*, it does not make code simpler.
> > 
> > And OOM-killing during suspend is just what you want. It makes suspend
> > deterministic but it might kill someone. [Well, your solution would
> > kill him sooner than that...]
> 
> OK, fair enough. I like the "activate the spare swap blob" plan.
> Seems like the best of both worlds ... people can use files or
> partitions, and all the code is already there.

Except you can not use swapfiles ;-).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
