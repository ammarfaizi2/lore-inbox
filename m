Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266078AbSKLBmf>; Mon, 11 Nov 2002 20:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbSKLBmf>; Mon, 11 Nov 2002 20:42:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:23447 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266078AbSKLBme>;
	Mon, 11 Nov 2002 20:42:34 -0500
Date: Mon, 11 Nov 2002 20:49:22 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ryan Anderson <ryan@michonline.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] devfs API
In-Reply-To: <20021112013244.GF1729@mythical.michonline.com>
Message-ID: <Pine.GSO.4.21.0211112039430.29617-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Nov 2002, Ryan Anderson wrote:

> On Sun, Nov 10, 2002 at 05:19:42PM -0500, Alexander Viro wrote:
> > 	During the last couple of weeks I'd done a lot of digging in
> > devfs-related code.  Results are interesting, and not in a good sense.
> 
> >From an outsider point of view (and because nobody else responded), I
> think the big question here would be: Would you use it after this
> cleanup?
> 
> If you say yes, I'd say that's a good sign in its favor.

The only way I'll use devfs is
	* on a separate testbox devoid of network interfaces
	* with no users
	* with no data - disk periodically populated from image on CD.

And that's regardless of that cleanup - fixing the interface doesn't solve
the internal races, so...

