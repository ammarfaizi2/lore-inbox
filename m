Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135925AbREIJKP>; Wed, 9 May 2001 05:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135927AbREIJKF>; Wed, 9 May 2001 05:10:05 -0400
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:59908 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S135925AbREIJJ5>;
	Wed, 9 May 2001 05:09:57 -0400
Date: Wed, 9 May 2001 11:09:14 +0200 (CEST)
From: Tobias Ringstrom <tori@tellus.mine.nu>
X-X-Sender: <tori@svea.tellus>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <jwright@penguincomputing.com>, <redhat-devel-list@redhat.com>,
        <linux-kernel@vger.kernel.org>, Jeremy Hogan <jhogan@redhat.com>,
        Mike Vaillancourt <mikev@redhat.com>,
        Philip Pokorny <ppokorny@penguincomputing.com>
Subject: Re: bug in redhat gcc 2.96
In-Reply-To: <E14xPli-0001qP-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105091058480.31224-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2001, Alan Cox wrote:
> > Any suggestions for a way to cope with this?  We have a
> > customer who's system fails due to this.
>
> You can build 2.4 quite sanely with egcs-1.1.2 (aka kgcc)

Since there is no kgcc in RH71, will you be releasing an updated gcc
rpm, or is the best solution to download and compile egcs-1.1.2 from
source?

IMHO, it is best not to revert to an old egcs version, but instead
continue to find bugs in the upcoming 3.0 release.  I'm assuming that
your fixes for your gcc-2.96 are propagated to the pre-3.0 branch.

/Tobias

