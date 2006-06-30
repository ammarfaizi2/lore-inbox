Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWF3AXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWF3AXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWF3AXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:23:39 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:671 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964796AbWF3AXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:23:36 -0400
Date: Fri, 30 Jun 2006 02:23:23 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       klibc@zytor.com
Subject: Re: [klibc 07/31] i386 support for klibc
In-Reply-To: <44A4681B.8020406@zytor.com>
Message-ID: <Pine.LNX.4.64.0606300217160.12900@scrub.home>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
 <klibc.200606272217.07@tazenda.hos.anvin.org> <Pine.LNX.4.61.0606280937150.29068@yvahk01.tjqt.qr>
 <44A2A147.9020501@zytor.com> <Pine.LNX.4.64.0606290207580.17704@scrub.home>
 <44A322BB.2010006@zytor.com> <Pine.LNX.4.64.0606300133050.12900@scrub.home>
 <44A4681B.8020406@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 29 Jun 2006, H. Peter Anvin wrote:

> a. The semantics of these functions are well-defined, stable, and documented
> in the gcc documentation.  It's not like they have compiler-version-specific
> definitions that could change.

It's documented in the internals section for gcc's own purposes. This
doesn't make it a public API.

> b. For static binaries, this is no issue.  klibc is shared, not dynamic (thus
> eliminating the need for a space-consuming dynamic linker), but it also means
> that there is no cross-version calling; each build of the shared klibc library
> has a hashed filename, thus allowing multiple versions of klibc to coexist if
> absolutely necessary.
> 
> Either way, this is a red herring.

Since you don't explain your plans, it's hard to tell.

> > > > The standard libgcc may not be as small as you like, but it still should
> > > > be
> > > > the first choice. If there is a problem with it, the gcc people do
> > > > accept
> > > > patches.
> > > That's just an asinine statement.  Under that logic we should just forget
> > > about the kernel and go hack the gcc bugs du jour; we certainly have
> > > enough
> > > workarounds for gcc bugs in the kernel.
> > 
> > Sorry, but I can't follow this logic.
> 
> I'm not entirely surprised.

So instead of arguments you try it now with insults... :-(

bye, Roman
