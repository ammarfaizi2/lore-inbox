Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268559AbRHBBYG>; Wed, 1 Aug 2001 21:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268560AbRHBBX4>; Wed, 1 Aug 2001 21:23:56 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53217 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S268559AbRHBBXq>;
	Wed, 1 Aug 2001 21:23:46 -0400
Date: Wed, 1 Aug 2001 21:23:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: bristuccia@starentnetworks.com, linux-kernel@vger.kernel.org
Subject: Re: repeated failed open()'s results in lots of used memory [Was:
 [Fwd: memory consumption]]
In-Reply-To: <Pine.LNX.4.33.0108011610520.15902-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0108012118060.27494-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Aug 2001, Linus Torvalds wrote:

> However, I'd like to see what the patch does for the bad case first, and
> then we can see whether there are less drastic methods (like only killing
> half of the negative dentries or something).

Removing the "second chance" logics for negative dentries might be a good
start...

