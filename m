Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317715AbSGVRrw>; Mon, 22 Jul 2002 13:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317716AbSGVRrv>; Mon, 22 Jul 2002 13:47:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47321 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317715AbSGVRrv>;
	Mon, 22 Jul 2002 13:47:51 -0400
Date: Mon, 22 Jul 2002 13:50:58 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Hellwig <hch@infradead.org>
cc: Jeff Dike <jdike@karaya.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, jdike@ccure.karaya.com
Subject: Re: [PATCH] UML - part 1 of 2
In-Reply-To: <20020722183844.A8526@infradead.org>
Message-ID: <Pine.GSO.4.21.0207221349250.7619-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Jul 2002, Christoph Hellwig wrote:

> On Mon, Jul 22, 2002 at 12:15:29PM -0500, Jeff Dike wrote:
> > include/linux/linkage.h -
> > 	UML needs FASTCALL defined as regparm(3), too.
> 
> The fastcall definition should go into an asm/ header instead of such hacks..
> 
> the disk accounting stuff is also bogus - instead of wasting ram with
> huge array it should rather be dynamically-allocated in a per-disk
> structure..

per-disk structures will be there pretty soon - the stuff merged into the
tree yesterday is the first part of large series introducing that animal.

