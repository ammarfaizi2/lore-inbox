Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272454AbRIKOuG>; Tue, 11 Sep 2001 10:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272460AbRIKOt6>; Tue, 11 Sep 2001 10:49:58 -0400
Received: from henry.fni.com ([207.204.183.218]:24473 "HELO henry.fni.com")
	by vger.kernel.org with SMTP id <S272454AbRIKOth>;
	Tue, 11 Sep 2001 10:49:37 -0400
Date: Tue, 11 Sep 2001 09:49:59 -0500 (CDT)
From: Michael Brennen <mbrennen@fni.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Resource starvation on a 2.2.19 web server
In-Reply-To: <E15goqQ-0002lq-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L2.0109110947110.9125-100000@henry.fni.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/lib/libc-2.1.3.so

Mandrake 7.1 installation, fully up on patches.  Thanks much.

   -- Michael

On Tue, 11 Sep 2001, Alan Cox wrote:

> > servers.  If I USR1 warm start apache, nslookup immediately works
> > again.  Some system resource is being freed up when apache is
> > restarted, but I've been unable to isolate what it is or fix it.
>
> How old is your C library ? Im wondering if its old enough that
> some stuff only works for 256 file handles. That might explain
> DNS failing.

