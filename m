Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275818AbRJQMnH>; Wed, 17 Oct 2001 08:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276607AbRJQMm5>; Wed, 17 Oct 2001 08:42:57 -0400
Received: from fozzie.eye-net.com.au ([203.41.228.19]:46009 "HELO
	fozzie.eye-net.com.au") by vger.kernel.org with SMTP
	id <S275818AbRJQMmt>; Wed, 17 Oct 2001 08:42:49 -0400
Date: Wed, 17 Oct 2001 22:43:07 +1000
To: Alexander Viro <viro@math.psu.edu>
Cc: Kamil Iskra <kamil@science.uva.nl>, csmall@users.sourceforge.net,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.12 breaks fuser
Message-ID: <20011017224307.A26812@eye-net.com.au>
In-Reply-To: <Pine.GSO.4.21.0110170332040.15716-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0110170332040.15716-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.18i
From: csmall@eye-net.com.au (Craig Small)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 04:26:42AM -0400, Alexander Viro wrote:
> 	b) fix fuser(1).  Notice that it's not hard - all we need is the
> patch below (guaranteed to work correctly on earlier kernels - it simply
> doesn't make assumptions about the value of st_dev used for sockets).
> IMO also worth doing.

I've made the changes, there is a psmisc 20.2 sitting in the sourceforge
CVS.  I will release it tomorrow morning.  Thankyou for your patch.  The
IPv6 related bug was also there and that is fixed too.

If you want to roll-back your kernel device code, you can do that or
not.  It seems the fuser patch doesn't care.
  - Craig
-- 
Craig Small VK2XLZ  GnuPG:1C1B D893 1418 2AF4 45EE  95CB C76C E5AC 12CA DFA5
Eye-Net Consulting http://www.eye-net.com.au/        <csmall@eye-net.com.au>
MIEEE <csmall@ieee.org>                 Debian developer <csmall@debian.org>
