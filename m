Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbSIXAJ2>; Mon, 23 Sep 2002 20:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSIXAJ2>; Mon, 23 Sep 2002 20:09:28 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:35247 "HELO
	pirx.hexapodia.org") by vger.kernel.org with SMTP
	id <S261493AbSIXAJ1>; Mon, 23 Sep 2002 20:09:27 -0400
Date: Mon, 23 Sep 2002 19:14:39 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923191439.B29189@hexapodia.org>
References: <Pine.LNX.3.96.1020923152135.13351C-100000@gatekeeper.tmr.com> <Pine.LNX.4.44.0209232218320.2118-100000@localhost.localdomain> <20020923190306.D13340@hexapodia.org> <3D8FAD70.2010404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D8FAD70.2010404@pobox.com>; from jgarzik@pobox.com on Mon, Sep 23, 2002 at 08:10:24PM -0400
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 08:10:24PM -0400, Jeff Garzik wrote:
> Andy Isaacson wrote:
> > Of course this can be (and frequently is) implemented such that there is
> > not one Pthreads thread per object; given simulation environments with 1
> > million objects, and the current crappy state of Pthreads
> > implementations, the researchers have no choice.
> 
> Are these object threads mostly active or inactive?

Mostly inactive (waiting on a semaphore or FIFO).

> Regardless, it seems obvious with today's hardware, that 1 million 
> objects should never be one-thread-per-object, pthreads or no.  That's 
> just lazy programming.

You can call it lazy if you want, but I call it natural.

(Of course I realize that practical considerations prevent users from
creating 1 million kernel threads, or even user threads, today.
Unfortunate, that.)

-andy
