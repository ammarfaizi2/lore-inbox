Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278662AbRKFIhl>; Tue, 6 Nov 2001 03:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278660AbRKFIhb>; Tue, 6 Nov 2001 03:37:31 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:9410 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278662AbRKFIhS>;
	Tue, 6 Nov 2001 03:37:18 -0500
Date: Tue, 6 Nov 2001 03:37:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <E1611lE-00086H-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0111060334590.27713-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Nov 2001, Alan Cox wrote:

> Surely the answer if you want short term write speed and long term balancing
> is to use ext3 not ext2 and simply ensure that the relevant stuff goes to
> the journal (which will be nicely ordered) first. That will give you some
> buffering at least.

Alan, the problem is present in ext3 as well as in all other FFS derivatives
(well, FreeBSD had tried to deal that stuff this Spring).

