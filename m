Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbTE0TXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbTE0TXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:23:41 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:38558 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264098AbTE0TXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:23:06 -0400
Date: Tue, 27 May 2003 16:34:20 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 2.4.21-rc4] Fix oom killer braindamage
In-Reply-To: <200305272130.43814.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.55L.0305271631590.9487@freak.distro.conectiva>
References: <200305272104.05802.m.c.p@wolk-project.de>
 <Pine.LNX.4.55L.0305271611410.9487@freak.distro.conectiva>
 <200305272118.29554.m.c.p@wolk-project.de> <200305272130.43814.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 May 2003, Marc-Christian Petersen wrote:

> On Tuesday 27 May 2003 21:18, Marc-Christian Petersen wrote:
>
> Hi again ^3 ;)
>
> > > Not suitable for -rc. Btw, -rc5 is already at bkbits.net.
> Please, if there is any chance we can fix the pause/stop bug, delay .21 final
> for some hours or a day (or maybe two)
>
> I've CC'ed akpm and Axboe. I think they are the only ones knowing enough about
> the code to see an obvious error and even fixing the bug?!
>
> Do you agree? Does anyone else agree? Or disagree?

Few points:

 - 2.4.22 is going to be a short release, meaning we will have this
   bug fixed soon in a final release.
 - the bug is around for quite some time now, its not very critical.
 - its -rc stage.

Moreover, -rc5 is already out.

I will work with Jens, Axboe and Andrea to get this properly fixed in .22
in case Andrea patch is not OK.


