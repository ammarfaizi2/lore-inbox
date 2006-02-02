Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWBBLCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWBBLCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWBBLCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:02:46 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:424 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750730AbWBBLCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:02:45 -0500
Date: Thu, 2 Feb 2006 12:02:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Message-ID: <20060202110235.GE1884@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602012245.06328.nigel@suspend2.net> <84144f020602010501k23e7898at82c0f231a2da0ad4@mail.gmail.com> <200602020730.16916.nigel@suspend2.net> <84144f020602011345i2e395336s371786c441b9f5b2@mail.gmail.com> <20060202100646.GC1981@elf.ucw.cz> <84144f020602020257g72bda32bkc3d6264495bea2aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020602020257g72bda32bkc3d6264495bea2aa@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On St 01-02-06 23:45:15, Pekka Enberg wrote:
> > > Is that necessary for the mainline, though? We have only one suspend
> > > in the kernel, not "Pavel suspend" and "Nigel suspend", right?
> 
> On 2/2/06, Pavel Machek <pavel@ucw.cz> wrote:
> > Actually plan is to only have "Rafael suspend" :-). That's basically
> > "Pavel suspend" minus the disk writing parts. That is *long* term.
> 
> So what's the plan for short-term? Are userspace suspend and suspend
> modules mutually exclusive or can they co-exist?

They can coexist for as long as neccessary. (At one point, it was even
possible to suspend using userland code, then resume using kernel code
:-).

When I found out noone is really using kernel code any more (2.8.0 or
something), I'd like to get rid of it.
								Pavel
-- 
Thanks, Sharp!
