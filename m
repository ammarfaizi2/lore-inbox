Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSI0QrP>; Fri, 27 Sep 2002 12:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbSI0QrP>; Fri, 27 Sep 2002 12:47:15 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:46086 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261587AbSI0QrO>; Fri, 27 Sep 2002 12:47:14 -0400
Date: Fri, 27 Sep 2002 18:52:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andi Kleen <ak@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put modules into linear mapping
In-Reply-To: <20020927181445.A9595@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0209271849180.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 27 Sep 2002, Andi Kleen wrote:

> No, they aren't. x86-64 uses it because modules need to be in 32bit
> range from the main kernel and vmalloc is in a different area. I suspect
> it is the same on sparc64.

Ok, makes sense.

> > If it's supposed to be a generic function, it makes sense, otherwise we
> > could just put it into module.c.
>
> Ok, I will change it.

Any chance to use __HAVE_MODULE_MAP, so every arch (except sparc64/x86-64)
can automatically benefit from this?

bye, Roman

