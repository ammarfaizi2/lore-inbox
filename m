Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133048AbRDLBto>; Wed, 11 Apr 2001 21:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133044AbRDLBte>; Wed, 11 Apr 2001 21:49:34 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:3088 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S133040AbRDLBtY>;
	Wed, 11 Apr 2001 21:49:24 -0400
Date: Wed, 11 Apr 2001 22:48:54 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Jon Eisenstein <jeisen@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem: Random paging request errors
In-Reply-To: <Pine.LNX.4.21.0104112020050.529-100000@dominia.dyn.dhs.org>
Message-ID: <Pine.LNX.4.21.0104112246320.25737-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2001, Jon Eisenstein wrote:

> (2) Every so often, I get a non-fatal error on my screen about a
> kernel paging request error.

If it's usually the same address, we're probably dealing with
a kernel bug. If you always get different addresses, chances
are your RAM is broken (you can test this with memtest86).

Decoding the oops is always useful, especially if you can find
a pattern after you've decoded a few. And if you don't manage
to find any pattern in them, you know the suspicion lies with
the hardware ...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

