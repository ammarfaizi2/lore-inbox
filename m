Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbRETCgs>; Sat, 19 May 2001 22:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbRETCgi>; Sat, 19 May 2001 22:36:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52112 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261382AbRETCg0>;
	Sat, 19 May 2001 22:36:26 -0400
Date: Sat, 19 May 2001 22:36:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Matthew Wilcox <matthew@wil.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <200105200222.f4K2Mto02608@mobilix.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0105192232560.7162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Richard Gooch wrote:

> The transaction(2) syscall can be just as easily abused as ioctl(2) in
> this respect. People can pass pointers to ill-designed structures very

Right. Moreover, it's not needed. The same functionality can be trivially
implemented by write() and read(). As the matter of fact, had been done
in userland context for decades. Go and buy Stevens. Read it. Then come
back.

