Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAXXbI>; Wed, 24 Jan 2001 18:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAXXa7>; Wed, 24 Jan 2001 18:30:59 -0500
Received: from maynard.mail.mindspring.net ([207.69.200.243]:61742 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129444AbRAXXan>; Wed, 24 Jan 2001 18:30:43 -0500
Date: Wed, 24 Jan 2001 17:30:38 -0600
From: Matthew Fredrickson <matt@frednet.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: PPP/Modem connection problems starting somewhere between 2.2.14(maybe 15) and 2.2.18
Message-ID: <20010124173038.A23669@frednet.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not positive if this is a bug, I'm only able to confirm this from one
other source.  Somewhere between (I can't remember exactly which kernel my
server started on) ~2.2.14(or 15) and 2.2.18 my ppp connection
periodically hangs and I have to restart the connection.  My situation is
a modem that is dialed into the internet pretty close to 24/7.  Sometimes
the connection seems to hang up (but ifconfig reports ppp0 as being there
and up w/ and IP address).  The only solution to this problem is killing
wvdial and wvdial'ing again.  Sometimes (pretty randomly I might add) even
when I redial it has this problem when it dials up except I can get a few
kilobytes and then the connection freezes up.  I can confirm this by a
friend of mine who is just running a periodic dialup box but has seen
similar troubles in the same time frame.  He and I are both running debian
(potato) on the boxen involved.  This problem has persisted and still
occurs even as I've upgraded the kernel but I think (not sure) that it has
gotten a little better w/2.2.18.  I'm not sure how I can replicate it, but
sometimes when I get home I find the internet connection not working and
the linux box says ppp0 is up.  I would appreciate any help I can get.
I'm about to go look at historical kernel changelogs.  Thanks.

-- 
Matthew Fredrickson AIM MatthewFredricks
ICQ 13923212 matt@NOSPAMfredricknet.net 
http://www.fredricknet.net/~matt/
"Everything is relative"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
