Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbSKTBpS>; Tue, 19 Nov 2002 20:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267395AbSKTBpS>; Tue, 19 Nov 2002 20:45:18 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:4793 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267288AbSKTBpR>; Tue, 19 Nov 2002 20:45:17 -0500
Date: Tue, 19 Nov 2002 23:52:02 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spinlocks, the GPL, and binary-only modules
In-Reply-To: <3DDAB6AD.4050400@pobox.com>
Message-ID: <Pine.LNX.4.44L.0211192349460.4103-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Jeff Garzik wrote:

> So, since spinlocks and semaphores are (a) inline and #included into
> your code, and (b) required for just about sane interoperation with Linux...
>
> does this mean that all binary-only modules that #include kernel code
> such as spinlocks are violating the GPL?

> But who knows if #include'd code constitutes a derived work :(

Only if the #included snippets of code are large enough to be
protected by copyright, which might be true of the stuff in
mm_inline.h and of some of the semaphore code, but probably
isn't true of the spinlock code.

Even if the code #included is large enough to be protected by
copyright I don't know if the code including it would be considered
a derived work. Many questions remaining...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

