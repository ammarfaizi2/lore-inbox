Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbTGWKVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 06:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbTGWKVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 06:21:45 -0400
Received: from rth.ninka.net ([216.101.162.244]:40320 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S265624AbTGWKVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 06:21:44 -0400
Date: Wed, 23 Jul 2003 03:35:05 -0700
From: "David S. Miller" <davem@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: a.marsman@aYniK.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre7: are security issues solved?
Message-Id: <20030723033505.145db6b8.davem@redhat.com>
In-Reply-To: <E19fGMZ-0000Zm-00@gondolin.me.apana.org.au>
References: <Pine.LNX.4.44.0307212234390.3580-100000@localhost.localdomain>
	<E19fGMZ-0000Zm-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 19:56:47 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Aschwin Marsman <a.marsman@aynik.com> wrote:
> > 
> >> CAN-2003-0461: /proc/tty/driver/serial reveals the exact character counts
> >> for serial links. This could be used by a local attacker to infer password
> >> lengths and inter-keystroke timings during password entry.
> 
> What's the problem with exposing those counters?

If I know your password is 7 characters I have a smaller
space of passwords to search to just brute-force it.
