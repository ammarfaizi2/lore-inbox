Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293395AbSCKGhv>; Mon, 11 Mar 2002 01:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293439AbSCKGhl>; Mon, 11 Mar 2002 01:37:41 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:56455 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S293395AbSCKGh1>;
	Mon, 11 Mar 2002 01:37:27 -0500
Date: Mon, 11 Mar 2002 01:37:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Hans Reiser <reiser@namesys.com>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Itai Nahshon <itai@siftology.com>,
        Larry McVoy <lm@bitmover.com>, Tom Lord <lord@regexps.com>,
        jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <3C8C4B8A.2070508@namesys.com>
Message-ID: <Pine.GSO.4.21.0203110133300.9713-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Mar 2002, Hans Reiser wrote:

> >The problem is that it doesn't play well with other things.
> >
> Your statement is information free so far, but could be the intro to an 
> informative statement....;-)

See postings upthread.  Versioning doesn't play well with link(2), with
overwriting rename(2), etc. - the problem is not that much in implementation
but in finding at least somewhat reasonable semantics for that.

DEC OSes have different filesystem IO model.  There versions are more or
less natural.  With Unix they will clash with a lot of things expected
by every damn application out there.

