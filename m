Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136595AbREIQou>; Wed, 9 May 2001 12:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136665AbREIQob>; Wed, 9 May 2001 12:44:31 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:4924 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136595AbREIQoX>; Wed, 9 May 2001 12:44:23 -0400
Date: Wed, 9 May 2001 12:42:59 -0400
From: Matt Wilson <msw@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jwright@penguincomputing.com, redhat-devel-list@redhat.com,
        linux-kernel@vger.kernel.org, Jeremy Hogan <jhogan@redhat.com>,
        Mike Vaillancourt <mikev@redhat.com>,
        Philip Pokorny <ppokorny@penguincomputing.com>
Subject: Re: bug in redhat gcc 2.96
Message-ID: <20010509124259.I2397@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.33.0105081927320.1798-100000@foo.penguincomputing.com> <E14xPli-0001qP-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14xPli-0001qP-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, May 09, 2001 at 09:56:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is because Jakub fixed it in GCC 3.0 CVS at the same time that he
fixed it in 2.96-82, which was on the same day it was reported.  It
was broken in GCC CVS until that moment.

Cheers,

Matt

On Wed, May 09, 2001 at 09:56:24AM +0100, Alan Cox wrote:
> > As this is with Red Hat's version of gcc, I'm not sending
> > this to the gcc folks.  RPMs of gcc with this problem
> 
> (If you have the time check 3.0 CVS doesnt show the same problem, the RH tree
>  diverges from it so may well be unique in having the bug but many bugs are
>  shared)
