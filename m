Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129135AbRBGGZw>; Wed, 7 Feb 2001 01:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129216AbRBGGZm>; Wed, 7 Feb 2001 01:25:42 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:61704 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129135AbRBGGZ3>; Wed, 7 Feb 2001 01:25:29 -0500
Date: Wed, 7 Feb 2001 00:25:10 -0600
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OK to mount multiple FS in one dir?
Message-ID: <20010207002510.A10556@cadcamlab.org>
In-Reply-To: <3A7E1942.5090903@goingware.com> <20010205180646.B32155@cadcamlab.org> <033601c09075$a60e43e0$de00a8c0@homeip.net> <20010206154616.A9875@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010206154616.A9875@animx.eu.org>; from wakko@animx.eu.org on Tue, Feb 06, 2001 at 03:46:16PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Wakko Warner]
> I have a question, why was this idea even considered?

Al Viro likes Plan9 process-local namespaces.  He seems to be trying to
move Linux in that direction.  In the past year he has been hacking the
semantics of filesystems and mounting, probably with namespaces as an
eventual goal, and this is one of the things that has fallen out of the
implementation.

A more useful thing to fall out of the same hacking is loopback
mounting -- i.e. the same filesystem mounted multiple places.  In
Linux-land I guess we call it 'mount --bind'.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
