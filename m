Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSJ3BZk>; Tue, 29 Oct 2002 20:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbSJ3BZk>; Tue, 29 Oct 2002 20:25:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50744 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262692AbSJ3BZj>; Tue, 29 Oct 2002 20:25:39 -0500
To: robert w hall <bobh@n-cantrell.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loadlin with 2.5.?? kernels
References: <5.1.0.14.2.20021026064044.00b9a310@pop.gmx.net>
	<m1bs5in1zh.fsf@frodo.biederman.org>
	<5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net>
	<5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net>
	<m18z0os1iz.fsf@frodo.biederman.org>
	<007501c27b37$144cf240$6400a8c0@mikeg>
	<m1bs5in1zh.fsf@frodo.biederman.org>
	<5.1.0.14.2.20021026064044.00b9a310@pop.gmx.net>
	<5.1.0.14.2.20021026073915.00b55008@pop.gmx.net>
	<m1vg3plfi7.fsf@frodo.biederman.org>
	<Q2V7OBAeBnu9Ewt1@n-cantrell.demon.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Oct 2002 18:29:53 -0700
In-Reply-To: <Q2V7OBAeBnu9Ewt1@n-cantrell.demon.co.uk>
Message-ID: <m14rb4yar2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

robert w hall <bobh@n-cantrell.demon.co.uk> writes:

> > That
> >happens to work but there is nothing in the kernel keeping that from
> >being broken.  So in practice it looks to be worthwhile to stabilize 
> >this interface.
> 
> agreed - 
> /ignorant query/
> but if you aim for too much generality are you not eventually going to
> need Hans Lermen to revisit his loadlin version of the startup code
> (which is based in part on old code from head.S & misc.c of course)?

If I change the kernel so that it always will, and always can use 0x10
and 0x18.   loadlin works by design.  The rest of the kernel can use
some other GDT.  That is what my patch does.

> might also be worth checking out linlod (which still is only a beta I
> think) needs to run

If I could find a reference to the x86 and not the alpha one I might.

Eric
