Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262238AbSI0REQ>; Fri, 27 Sep 2002 13:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262247AbSI0REQ>; Fri, 27 Sep 2002 13:04:16 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:32262 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262238AbSI0REP>; Fri, 27 Sep 2002 13:04:15 -0400
Date: Fri, 27 Sep 2002 19:09:27 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andi Kleen <ak@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put modules into linear mapping
In-Reply-To: <20020927185949.A27271@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0209271907000.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 27 Sep 2002, Andi Kleen wrote:

> > Any chance to use __HAVE_MODULE_MAP, so every arch (except sparc64/x86-64)
> > can automatically benefit from this?
>
> I can put it in asm-generic/
>
> But people have to check themselves if the vmalloc trick works for them.

If it's in module.c anyway, you could set a flag in mod->flags, at how
it was allocated.

bye, Roman

