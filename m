Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313321AbSDOWca>; Mon, 15 Apr 2002 18:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313322AbSDOWc3>; Mon, 15 Apr 2002 18:32:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27917 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313321AbSDOWc2>; Mon, 15 Apr 2002 18:32:28 -0400
Date: Tue, 16 Apr 2002 00:32:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] writeback daemons
Message-ID: <20020415223230.GC3406@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3CB3DE1E.5F811D77@zip.com.au> <20020408203839.C540@toy.ucw.cz> <3CBB3A41.8E94C8A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The number of threads is dynamically managed by a simple
> > > demand-driven algorithm.
> > 
> > So... when we are low on free memory, we try to create more threads... Possible
> > deadlock?
> 
> Nope.  The number of threads is never allowed to fall below two,
> for this very reason.

I thought this was the case. BTW do you need *two* threads for
reliable operation, or is one enough?

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
