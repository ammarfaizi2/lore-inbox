Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261610AbRETKf3>; Sun, 20 May 2001 06:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbRETKfJ>; Sun, 20 May 2001 06:35:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41617 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261518AbRETKfD>;
	Sun, 20 May 2001 06:35:03 -0400
Date: Sun, 20 May 2001 06:35:02 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <20010520112351.A32544@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0105200627390.7162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Russell King wrote:

> I still see read()/write() being a "pass any crap" interface.  The
> implementer of the target for read()/write() will probably still be
> a driver which will need to decode what its given, whether its in
> ASCII or binary.
> 
> And driver writers are already used to writing ioctl-like interfaces.

You _are_ missing the point. write() doesn't have that history of wild
abuse. It's easier to whack the driver writer's balls for abusing it.
I'm more than willing to play Narn Bat Squad and I'm pretty sure that
I'm not alone at that.

