Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTKTQ7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 11:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTKTQ7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 11:59:50 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:14302 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262099AbTKTQ7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 11:59:48 -0500
Date: Thu, 20 Nov 2003 10:58:56 -0600
From: Erik Jacobson <erikj@efs.americas.sgi.com>
To: Jonathan Corbet <corbet@lwn.net>
cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_file version of /proc/interrupts 
In-Reply-To: <Pine.SGI.4.53.0311131624150.183845@efs.americas.sgi.com>
Message-ID: <Pine.SGI.4.53.0311201056440.15335@efs.americas.sgi.com>
References: <20031113213927.27114.qmail@lwn.net>
 <Pine.SGI.4.53.0311131624150.183845@efs.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.  I'm sorry it took me so long to test this.  I was able to
get some time on our 512p system this morning.  I ran the test and your
fix does solve this problem.

Actually, it was 511 processors at the time.

I was going to include the output but I decied most people wouldn't want
to stretch their windows that wide.  The output isn't pretty on a system
with this many processors - but it isn't breaking and that is the main
concern.

Thanks again for checking in to this.  Much appreciated.

Erik

> > Here, anyway, is a better version of the patch.  It's less intrusive,
> > forgoes some "cleanups" I indulged in the first time, and makes it easier
> > to update other architectures.  I did x86-64, ia_64 and ppc64 just for the
> > heck of it, but I can't test them.
>
> I tested your changes on a small ia64 Altix here.  It worked well.  I'll try
> it out on a 512p system when I can get a time slot on it.
>
> Thanks for doing this.
>
> Erik
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--
Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
