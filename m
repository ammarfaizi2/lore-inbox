Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbTGWK0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 06:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbTGWKZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 06:25:03 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:33544 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S266141AbTGWKYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 06:24:37 -0400
Date: Wed, 23 Jul 2003 20:39:01 +1000
To: "David S. Miller" <davem@redhat.com>
Cc: a.marsman@aYniK.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre7: are security issues solved?
Message-ID: <20030723103901.GA2425@gondor.apana.org.au>
References: <Pine.LNX.4.44.0307212234390.3580-100000@localhost.localdomain> <E19fGMZ-0000Zm-00@gondolin.me.apana.org.au> <20030723033505.145db6b8.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030723033505.145db6b8.davem@redhat.com>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 03:35:05AM -0700, David S. Miller wrote:
> On Wed, 23 Jul 2003 19:56:47 +1000
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
> > Aschwin Marsman <a.marsman@aynik.com> wrote:
> > > 
> > >> CAN-2003-0461: /proc/tty/driver/serial reveals the exact character counts
> > >> for serial links. This could be used by a local attacker to infer password
> > >> lengths and inter-keystroke timings during password entry.
> > 
> > What's the problem with exposing those counters?
> 
> If I know your password is 7 characters I have a smaller
> space of passwords to search to just brute-force it.

Yes but can't you do the same thing with /proc/interrupts or
/proc/net/dev? Why are we singling out the serial driver?
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
