Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUDEKro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 06:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUDEKro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 06:47:44 -0400
Received: from [151.39.82.11] ([151.39.82.11]:25050 "HELO abbeynet.it")
	by vger.kernel.org with SMTP id S261790AbUDEKrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 06:47:43 -0400
Message-ID: <4071394A.1060007@abbeynet.it>
Date: Mon, 05 Apr 2004 12:47:38 +0200
From: Marco Fais <marco.fais@abbeynet.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.4.2) Gecko/20040308
X-Accept-Language: it, en, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
References: <406D3E8F.20902@abbeynet.it> <20040402153628.4a09d979.akpm@osdl.org>
In-Reply-To: <20040402153628.4a09d979.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.24.0.7; VDF: 6.24.0.85; host: abbeynet.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton ha scritto:

>>kernel BUG at page_alloc.c:98!
> uh-oh.

That was the same thing that I've said when I saw all the leds blinking 
in *all* the keyboards ... :)

> distcc uses sendfile().  The 8139too hardware and driver are
> zerocopy-capable so the kernel uses zerocopy direct-from-user-pages for
> sendfile().

Ok. Other servers with e100 driver doesn't show the problem. This means 
that they're not "zerocopy-capable"?

> This was all discussed fairly extensively a couple of years back and I
> thought it ended up being fixed.

There are any workarounds for this, until the problem is corrected?

Thank you very much.


