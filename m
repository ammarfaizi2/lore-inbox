Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWGLPJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWGLPJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWGLPJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:09:53 -0400
Received: from xenotime.net ([66.160.160.81]:32467 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751068AbWGLPJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:09:53 -0400
Date: Wed, 12 Jul 2006 08:12:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Fredrik Roubert <roubert@df.lth.se>
Cc: zippel@linux-m68k.org, akpm@osdl.org, pavel@ucw.cz,
       stern@rowland.harvard.edu, dmitry.torokhov@gmail.com,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
Message-Id: <20060712081240.6b3ee023.rdunlap@xenotime.net>
In-Reply-To: <20060712072628.GB5869@igloo.df.lth.se>
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
	<20060710094414.GD1640@igloo.df.lth.se>
	<Pine.LNX.4.64.0607102356460.17704@scrub.home>
	<20060711124105.GA2474@elf.ucw.cz>
	<Pine.LNX.4.64.0607120016490.12900@scrub.home>
	<20060711224225.GC1732@elf.ucw.cz>
	<Pine.LNX.4.64.0607120132440.12900@scrub.home>
	<20060711165003.25265bb7.akpm@osdl.org>
	<Pine.LNX.4.64.0607120213060.12900@scrub.home>
	<20060712072628.GB5869@igloo.df.lth.se>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 09:26:28 +0200 Fredrik Roubert wrote:

> On Wed 12 Jul 02:16 CEST 2006, Roman Zippel wrote:
> 
> > > Nack your nack!  The patch in 2.6.18-rc1 makes sysrq work on machines on
> > > which it *did not work at all*.  If that makes it harder to type but still
> > > possible to type on other machines, well, we win.
> >
> > Why can't we even _try_ to preserve compatibility? :-(
> 
> First, please note that the documented behaviour (You press the key
> combo 'ALT-SysRq-<command key>'.) still works.
> 
> The problem at hand is that not all keyboards can handle this many keys
> pressed at once, and that there also are keyboards broken in other ways.
> 
> The work-around suggested in the documentation ([Y]ou might have better
> luck with "press Alt", "press SysRq", "release Alt", "press <command
> key>", release everything.) does not work with keyboards that sends the
> make and break codes for SysRq immediately after another, and this was
> the reason for changing the behaviour (for broken keyboards) in
> 2.6.18-rc1. The new behaviour works with every keyboard the people
> involved in this discussion has heard of.
> 
> That the documentation wasn't updated with the new work-around key
> combination for broken keyboards was a mistake.

In the past, I've had/used several huge-company black
keyboards that didn't work (recognize) Alt-SysRq-X.

Should they work now?  (I don't currently have one.)
It would be very nice if they do.

---
~Randy
