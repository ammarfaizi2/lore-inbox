Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSG1T72>; Sun, 28 Jul 2002 15:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSG1T72>; Sun, 28 Jul 2002 15:59:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:23273 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317189AbSG1T71>;
	Sun, 28 Jul 2002 15:59:27 -0400
Date: Sun, 28 Jul 2002 22:01:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] Thread-Local Storage (TLS) support for Linux,
  2.5.28
In-Reply-To: <3D443B8C.7C2028B0@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0207282201020.32399-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Jul 2002, Oleg Nesterov wrote:

> I thought, that gdt entry consulted only while
> loading its index into the segment register.
> 
> So load_TLS_desc(next, cpu) must be called before
> loading next->fs,next->gs in __switch_to() ?

hm, right. I'm wondering, why did the tls_test code still work?

	Ingo

