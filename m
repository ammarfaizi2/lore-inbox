Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262686AbREVRmH>; Tue, 22 May 2001 13:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262687AbREVRl5>; Tue, 22 May 2001 13:41:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59364 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262686AbREVRlr>;
	Tue, 22 May 2001 13:41:47 -0400
Date: Tue, 22 May 2001 13:41:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <Pine.LNX.4.30.0105221143300.19818-100000@waste.org>
Message-ID: <Pine.GSO.4.21.0105221330150.15685-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 May 2001, Oliver Xymoron wrote:

> > Not always. If the thing is used all over the tree, it'd better be
> > greppable. I hate the foo->de stuff - it's not localized and it's
> > impossible to grep for.
> 
> I'd like to say the compiler will happily find it for you, but the
> kernel's mostly conditionally compiled..
> 
> Have you tried something like:
> 
>  find -type f | xargs grep -A100 'struct_name' | grep -e '\belement\b'
> 
> Obviously not a fix, but possibly helpful.

Too many false negatives. And you apparently missed a part of fun -
in that case there's a certain TLD...

