Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289005AbSA3JWG>; Wed, 30 Jan 2002 04:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289007AbSA3JV5>; Wed, 30 Jan 2002 04:21:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46090 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289005AbSA3JVx>; Wed, 30 Jan 2002 04:21:53 -0500
Date: Wed, 30 Jan 2002 01:21:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Daniel Phillips <phillips@bonn-fries.net>, <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.GSO.4.21.0201300310330.11157-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0201300110420.1542-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jan 2002, Alexander Viro wrote:
>
> 	Frankly, the only real issue in that thread was that we _do_ need
> a tree specifically for small fixes.  Preferably - quickly getting merged
> into the main tree.

A "small stuff" maintainer may indeed be a good idea. The maintainer could
be the same as somebody who does bigger stuff too, but they should be
clearly different things - trivial one-liners that do not add anything
new, only fix obvious stuff (to the point where nobody even needs to think
about it - if I'd start getting any even halfway questionable patches from
the "small stuff" maintainer, it wouldn't work).

		Linus

