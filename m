Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274062AbRI3UEq>; Sun, 30 Sep 2001 16:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274070AbRI3UEh>; Sun, 30 Sep 2001 16:04:37 -0400
Received: from 200-206-139-161.dsl.telesp.net.br ([200.206.139.161]:25348 "EHLO
	blackjesus.async.com.br") by vger.kernel.org with ESMTP
	id <S274062AbRI3UEX>; Sun, 30 Sep 2001 16:04:23 -0400
Date: Sun, 30 Sep 2001 17:04:39 -0300 (BRT)
From: Christian Robottom Reis <kiko@async.com.br>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: ps -ax hang with Mozilla in 2.4.9
In-Reply-To: <200109190322.f8J3MsG263115@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.40.0109301703560.154-100000@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001, Albert D. Cahalan wrote:

> > Just wondering if anybody has had moz hanging on them and hanging 'ps -ax'
> > (which means /proc/kmem reading is hung, IIRC)?
>
> Modern Linux "ps" does not use /proc/kmem. Do a "strace ps" to see.
> Maybe /proc/12345/stat or /proc/12345/status is hanging.

Thanks; if I can get this to be reproduced again I'll try. If read() on
stat or status is hanging, something is very wrong, though, right?

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 272 3330 | NMFL

