Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281505AbRKUARW>; Tue, 20 Nov 2001 19:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281507AbRKUARL>; Tue, 20 Nov 2001 19:17:11 -0500
Received: from pc-62-30-67-59-az.blueyonder.co.uk ([62.30.67.59]:54773 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S281505AbRKUARB>; Tue, 20 Nov 2001 19:17:01 -0500
Date: Wed, 21 Nov 2001 00:14:18 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: more fun with procfs (netfilter)
Message-ID: <20011121001418.C2472@kushida.jlokier.co.uk>
In-Reply-To: <E165z5s-0000SM-00@wagner> <Pine.GSO.4.21.0111200407430.21912-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0111200407430.21912-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Nov 20, 2001 at 05:19:12AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> - IOW, awk (both gawk and mawk) loses everything past the first 4Kb.
> And yes, it's a real-world example (there was more than $5 and it was
> followed by sed(1), but that doesn't affect the result - lost lines).

Does this break fopen/fscanf as well then?  There are programs which use
fscanf to read this info.

-- Jamie
