Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130024AbRADTHw>; Thu, 4 Jan 2001 14:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRADTHd>; Thu, 4 Jan 2001 14:07:33 -0500
Received: from waste.org ([209.173.204.2]:51042 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129557AbRADTHR>;
	Thu, 4 Jan 2001 14:07:17 -0500
Date: Thu, 4 Jan 2001 13:07:12 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Marko Kreen <marko@l-t.ee>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [patch] big udelay's in fb drivers (2.4.0-prerelease)
In-Reply-To: <20010104003422.A12099@l-t.ee>
Message-ID: <Pine.LNX.4.30.0101041305080.14623-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Marko Kreen wrote:

> On Wed, Jan 03, 2001 at 11:32:52PM +0200, Marko Kreen wrote:
> > -    udelay(15000); /* delay for 50 (15) ms */
> > +    mdelay(15); /* delay for 50 (15) ms */
>
> Per Mark Hahn suggestion here is a patch that fixes the weird
> comments too.  This is cumulative to the previous patch.

Once the comments are unweirded, they become completely superfluous. At
which point its best not to have them - when someone next comes along and
changes the delay, it might end up disagreeing with the comment and
causing confusion.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
