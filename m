Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265483AbSJaXdg>; Thu, 31 Oct 2002 18:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbSJaXdg>; Thu, 31 Oct 2002 18:33:36 -0500
Received: from almesberger.net ([63.105.73.239]:1032 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265483AbSJaXdf>; Thu, 31 Oct 2002 18:33:35 -0500
Date: Thu, 31 Oct 2002 20:39:35 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net,
       lkcd-devel-admin@lists.sourceforge.net,
       lkcd-general@lists.sourceforge.net,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021031203935.Z1421@almesberger.net>
References: <OFAA5C1DF6.DA161B71-ON80256C63.007D0F0E@portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFAA5C1DF6.DA161B71-ON80256C63.007D0F0E@portsmouth.uk.ibm.com>; from richardj_moore@uk.ibm.com on Thu, Oct 31, 2002 at 10:47:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard J Moore wrote:
> and so do many people. In fact netdump, mcode and lkcd are all
> complementary parts of the same need.

It's the "complementary" that worries me. Once you have mcore, what
good are direct dumps to the network or the disk for ? With mcore,
the whole issue of accessing stable storage is eliminated.

I don't know if the approach of having multiple quasi-equivalent
means of storing a dump is something that Linus dislikes about
LKCD, but I think it might be worth exploring if LKCD's chance of
acceptance could be improved by focusing on a single but general
mechanism.

I think it would be a pity if we ended up not having crash dumps
in 2.6 only because they're over-featured ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
