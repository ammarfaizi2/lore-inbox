Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271722AbRHQWDe>; Fri, 17 Aug 2001 18:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271725AbRHQWDR>; Fri, 17 Aug 2001 18:03:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:29453 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271722AbRHQWCz>; Fri, 17 Aug 2001 18:02:55 -0400
Date: Fri, 17 Aug 2001 19:01:57 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Admin Mailing Lists <mlist@intergrafix.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <E15X3A9-0003RS-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0108171900260.2277-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Alan Cox wrote:

> > i would think to put global limits in /proc or in a flat text /etc
> > and per user limits in something like /etc/passwd or /etc/shadow?
> > Is it against any standard to have extra fields in those files?
>
> Take a look at the pam modules, they already handle limit
> configuration per user, and I think all the major Linux (and
> also stuff like Solaris) distros run PAM based auth

Alan, would you accept the trivial version of per-user
CPU scheduling for 2.4 if there is a lot of demand ?

The code has been running in Conectiva's kernel RPM for
over a year now, is implemented entirely in the recalculate
part of the scheduler, leaves the scheduler fast path all
alone and only needs to be properly ported to newer 2.4
kernels now...

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

