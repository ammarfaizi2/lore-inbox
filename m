Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSG1UMH>; Sun, 28 Jul 2002 16:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317304AbSG1UMH>; Sun, 28 Jul 2002 16:12:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14216 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317302AbSG1UMG>;
	Sun, 28 Jul 2002 16:12:06 -0400
Date: Sun, 28 Jul 2002 22:14:07 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] Thread-Local Storage (TLS) support for Linux,
  2.5.28
In-Reply-To: <Pine.LNX.4.44.0207282201020.32399-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207282213430.32725-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Jul 2002, Ingo Molnar wrote:

> > So load_TLS_desc(next, cpu) must be called before
> > loading next->fs,next->gs in __switch_to() ?
> 
> hm, right. I'm wondering, why did the tls_test code still work?

okay, the tls_test.c code worked only because the code didnt
context-switch after installing the TLS.

	Ingo

