Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283717AbRLUXkJ>; Fri, 21 Dec 2001 18:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284596AbRLUXj7>; Fri, 21 Dec 2001 18:39:59 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2557 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283717AbRLUXjq>;
	Fri, 21 Dec 2001 18:39:46 -0500
Date: Fri, 21 Dec 2001 18:39:41 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd 
 kern el panic woes
In-Reply-To: <Pine.LNX.4.33.0112211510370.2370-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0112211837490.18218-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Dec 2001, Linus Torvalds wrote:

> But the "submit IO" will _mark_ the page dirty and uptodate, so once it is
> so marked, it should never be overwritten.

<thinks>

Yes, that works - sorry for confusion.

