Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266375AbTGEPrT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 11:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266377AbTGEPrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 11:47:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:48587 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S266375AbTGEPrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 11:47:12 -0400
Date: Sat, 5 Jul 2003 12:59:19 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Status of the IO scheduler fixes for 2.4
In-Reply-To: <20030705000016.GB23578@dualathlon.random>
Message-ID: <Pine.LNX.4.55L.0307051257420.13074@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva>
 <Pine.LNX.4.55L.0307021927370.12077@freak.distro.conectiva>
 <1057197726.20903.1011.camel@tiny.suse.com> <Pine.LNX.4.55L.0307041639020.7389@freak.distro.conectiva>
 <20030705000016.GB23578@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jul 2003, Andrea Arcangeli wrote:

> On Fri, Jul 04, 2003 at 05:01:54PM -0300, Marcelo Tosatti wrote:
> > release today), then fix pausing in -pre4. If the IO fairness still doesnt
>
> fix pausing is a showstopper bugfix, the box will hang for days without
> it.
>
> lowlatency elevator is for the desktop complains we get about
> interactivity compared to 2.5, so it's much lower prio than fix pausing.
> I would never merge fix pausing after lowlatency elevator. But that's
> just me.

You're right. I'll merge both patches in -pre3.

Danke
