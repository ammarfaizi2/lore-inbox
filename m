Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279064AbRLDCq2>; Mon, 3 Dec 2001 21:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282258AbRLCXui>; Mon, 3 Dec 2001 18:50:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:25273 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285034AbRLCTzA>;
	Mon, 3 Dec 2001 14:55:00 -0500
Date: Mon, 3 Dec 2001 14:54:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <200112021755.fB2Hthl10340@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0112031446160.15347-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Dec 2001, Richard Gooch wrote:

> Is that worth the effort? Hopefully by 2.4.17-rc I'll have fixed the
> bug, so it won't be an issue.

<boggle>

Let me get it straight - you had just merged an alpha-quality code into
the tree.  It has a chance to get debugged, but right now we have a _big_
change turning a lot of allocations into dynamic, yodda, yodda.  And it's
one big step - not split into gradual massage of code.  And you expect
that there will be no leaks/dangling pointers aside of that one?

