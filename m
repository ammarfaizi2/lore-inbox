Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278090AbRJVIG6>; Mon, 22 Oct 2001 04:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278089AbRJVIGL>; Mon, 22 Oct 2001 04:06:11 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3498 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278091AbRJVIF3>;
	Mon, 22 Oct 2001 04:05:29 -0400
Date: Mon, 22 Oct 2001 04:05:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: Albert Bartoszko <albertb@nt.kegel.com.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
In-Reply-To: <23368.1003736548@kao2.melbourne.sgi.com>
Message-ID: <Pine.GSO.4.21.0110220404000.2294-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Oct 2001, Keith Owens wrote:

> On Mon, 22 Oct 2001 02:47:39 -0400 (EDT), 
> Alexander Viro <viro@math.psu.edu> wrote:
> >Check that your modules.conf contains
> >
> >post-install binfmt_misc mount -t binfmt_misc none /proc/sys/binfmt_misc
> >pre-remove binfmt_misc umount /proc/sys/binfmt_misc
> >
> >That should've been there for quite a while, actually.  Keith?
> 
> It is not hard wired in the standard modutils, because there is no way
> of overriding it.

???
Elaborate, please.

