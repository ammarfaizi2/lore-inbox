Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLEUce>; Tue, 5 Dec 2000 15:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129371AbQLEUcY>; Tue, 5 Dec 2000 15:32:24 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:6584 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129267AbQLEUcP>;
	Tue, 5 Dec 2000 15:32:15 -0500
Date: Tue, 5 Dec 2000 15:01:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: check_lock() in d_move() and switch_names()?
In-Reply-To: <Pine.LNX.4.21.0012051944320.1493-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0012051501270.12284-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Tigran Aivazian wrote:

> Alexander, in one point at least you are wrong. That one point is -- I did
> _not_ suggest any optimizations (especially microoptimizations). I was
> merely trying to see exactly _why_ d_move() needs a BKL since it takes
> dcache_lock which already protects the lists which d_move manipulats. 

->d_parent

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
