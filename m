Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272118AbTHRRHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 13:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272046AbTHRRHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 13:07:04 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:54145 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272130AbTHRRG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 13:06:58 -0400
Date: Mon, 18 Aug 2003 18:18:30 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308181718.h7IHIUwU001800@81-2-122-30.bradfords.org.uk>
To: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org
Subject: Re: [PATCH] use simple_strtoul for unsigned kernel parameters
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, in theory short/int/long can all be the same size and thus a
> > "unsigned short" may not actually fit in a "long". I think that was the
> > case on the old 64-bit cray machines, for example ("char" was a very slow
> > 8-bit thing, everything else was purely 64-bit).
> > 
> > Not likely something we want to port Linux to, admittedly.
>
> Bear in mind we have the compiler source 8). If someone desperately
> wants to run Linux (probably ucLinux) on their cray they can fix the
> types too.

Hmmm, at least some Cray machines require three-phase power, though,
which is a problem for home use.

Do Cray boxes support virtualisation in hardware, or is it all done in
software?

> Things like the DEC10 (9,18,36 bit) and HLH Orion (word addressed) would
> be a lot more fun but thankfully are extinct 

No architecture is _thankfully_ extinct :-).

John.
