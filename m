Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273542AbRIQIjv>; Mon, 17 Sep 2001 04:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273541AbRIQIjj>; Mon, 17 Sep 2001 04:39:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23289 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273540AbRIQIjb>;
	Mon, 17 Sep 2001 04:39:31 -0400
Date: Mon, 17 Sep 2001 04:39:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Forced umount (was lazy umount)
In-Reply-To: <1000715364.4446.12.camel@nomade>
Message-ID: <Pine.GSO.4.21.0109170439180.20053-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 17 Sep 2001, Xavier Bestel wrote:

> Alexander Viro wrote:

No, I hadn't.  Watch the attributions.

> > I want an operation that will:
> > 
> > 1. Interrupt/Abort any processes disk-waiting on the filesystem
> 
> Why ? Can't you just return -EBADHANDLE, -E(NX)IO or something similar ?
> Aborting should be reserved to mmap()ing processes.

