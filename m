Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTGWJnW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 05:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTGWJnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 05:43:22 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:49671 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263062AbTGWJnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 05:43:21 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: a.marsman@aYniK.com (Aschwin Marsman), alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre7: are security issues solved?
In-Reply-To: <Pine.LNX.4.44.0307212234390.3580-100000@localhost.localdomain>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.21-2-686-smp (i686))
Message-Id: <E19fGMZ-0000Zm-00@gondolin.me.apana.org.au>
Date: Wed, 23 Jul 2003 19:56:47 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aschwin Marsman <a.marsman@aynik.com> wrote:
> 
>> CAN-2003-0461: /proc/tty/driver/serial reveals the exact character counts
>> for serial links. This could be used by a local attacker to infer password
>> lengths and inter-keystroke timings during password entry.

What's the problem with exposing those counters? Are we going to restrict
access to /proc/interrupts and network interface counters too?
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
