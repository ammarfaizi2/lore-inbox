Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSG3S7M>; Tue, 30 Jul 2002 14:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSG3S7L>; Tue, 30 Jul 2002 14:59:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32169 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S315690AbSG3S7L>;
	Tue, 30 Jul 2002 14:59:11 -0400
Date: Tue, 30 Jul 2002 21:00:09 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sanitize TLS API
In-Reply-To: <20020730174336.A18385@lst.de>
Message-ID: <Pine.LNX.4.44.0207302059060.22902-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Jul 2002, Christoph Hellwig wrote:

> Currently sys_set_thread_area has a magic flags argument that might
> change it's behaivour completly.
> 
> Split out the TLS_FLAG_CLEAR case that has nothing in common with the
> rest into it's own syscall, sys_clear_thread_area and change the second
> argument to int writable.

i did not feel like wasting two syscall slots for this, but the cleanups
look fine to me otherwise.

	Ingo

