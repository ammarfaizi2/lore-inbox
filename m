Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278591AbRKFHRr>; Tue, 6 Nov 2001 02:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278584AbRKFHR1>; Tue, 6 Nov 2001 02:17:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:39877 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278522AbRKFHRX>;
	Tue, 6 Nov 2001 02:17:23 -0500
Date: Tue, 6 Nov 2001 02:17:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <200111060714.fA67EfX20893@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0111060215560.27713-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Nov 2001, Richard Gooch wrote:

> > BTW, new code still has both aforementioned races - detaching
                                 ^^^^^^^^^^^^^^
> > entries from the tree doesn't help with that.
> 
> Which "both"? You sent quite a few messages, listing more than two
> races. I'm still wading through the list.

Sorry - trimmed more than I should have.  Ones mentioned in the message you
were replying to - unregister() on parent vs. mknod() or unlink().

