Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261990AbRESXZP>; Sat, 19 May 2001 19:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261997AbRESXZF>; Sat, 19 May 2001 19:25:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37773 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261990AbRESXYz>;
	Sat, 19 May 2001 19:24:55 -0400
Date: Sat, 19 May 2001 19:24:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthew Wilcox <matthew@wil.cx>
cc: Andries.Brouwer@cwi.nl, bcrl@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]
 device arguments from lookup)
In-Reply-To: <20010519181441.D23718@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.21.0105191924010.7162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Matthew Wilcox wrote:

> On Sat, May 19, 2001 at 12:51:07PM -0400, Alexander Viro wrote:
> > clone(), walk(), clunk(), stat() and open() ;-) Basically, we can add
> > unopened descriptors. I.e. no IO until you open it (turning the thing into
> > opened one), but we can do lookups (move to child), we can clone and
> > kill them and we can stat them.
> 
> Those who would like a more detailed explanation can find one at
> http://plan9.bell-labs.com/sys/man/5/INDEX.html

Umm... Yes, it's an allusion to 9P, but no, I'm not serious about exporting
that to userland.

