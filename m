Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135945AbREIJQF>; Wed, 9 May 2001 05:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135941AbREIJP4>; Wed, 9 May 2001 05:15:56 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:50754 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135952AbREIJPq>; Wed, 9 May 2001 05:15:46 -0400
Date: Wed, 9 May 2001 05:14:19 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jwright@penguincomputing.com, redhat-devel-list@redhat.com,
        linux-kernel@vger.kernel.org, Jeremy Hogan <jhogan@redhat.com>,
        Mike Vaillancourt <mikev@redhat.com>,
        Philip Pokorny <ppokorny@penguincomputing.com>
Subject: Re: bug in redhat gcc 2.96
Message-ID: <20010509051418.C9725@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0105081927320.1798-100000@foo.penguincomputing.com> <E14xPli-0001qP-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14xPli-0001qP-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, May 09, 2001 at 09:56:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 09:56:24AM +0100, Alan Cox wrote:
> > As this is with Red Hat's version of gcc, I'm not sending
> > this to the gcc folks.  RPMs of gcc with this problem
> 
> (If you have the time check 3.0 CVS doesnt show the same problem, the RH tree
>  diverges from it so may well be unique in having the bug but many bugs are
>  shared)

The bug was present in 3.0 and 3.1 as well, but has been fixed the day it
was reported. Use gcc-2.96-82 or above, or gcc-3_0-branch newer than 2001-04-25
(or CVS head newer than that).

	Jakub
