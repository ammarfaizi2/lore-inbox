Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129643AbRCHU62>; Thu, 8 Mar 2001 15:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRCHU6S>; Thu, 8 Mar 2001 15:58:18 -0500
Received: from e22.nc.us.ibm.com ([32.97.136.228]:19086 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129643AbRCHU6D>; Thu, 8 Mar 2001 15:58:03 -0500
Importance: Normal
Subject: Re: Kernel stress testing coverage
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF50B88864.0721DA46-ON85256A09.006EE3FD@raleigh.ibm.com>
From: "Paul Larson" <plars@us.ibm.com>
Date: Thu, 8 Mar 2001 14:57:35 -0600
X-MIMETrack: Serialize by Router on D04NMS24/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 03/08/2001 03:57:36 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox <alan@lxorguk.ukuu.org.uk> on 03/08/2001 02:06:06 PM

To:   Paul Larson/Austin/IBM@ibmus
cc:
Subject:  Re: Kernel stress testing coverage



>One thing I've been using for coverage (at least some coverage) is the
posix
>test suite

--------------------------

Are you talking about the same posix test suite that LSB is using?  I've
looked into that a little, but here are the two problems I'm wanting to
address:

1. How much of the kernel is getting hit on a run of any given test?  Even
an approximate percentage is fine as long as I can prove it.

2. I could run many many copies simultaneously I suppose and get some
stress, but I'd prefer to stress individual pieces one at a time.  Those
pieces could then be mixed together in later runs for mixed load stress.
Additional mixed load tests will be performed with general applications
(web servers, databases, etc) for more of a "real world" environment, but I
want to have focused tests as well.

I'm betting that there are probably a LOT of quick and dirty test programs
that kernel hackers have written to expose a problem or thoroughly test a
piece of the kernel that they modified.  These type of things would be
FYI this project will be going on sourceforge very soon.  I want to have a
little more to start out with though and finish putting together a good
project description, testplans, etc. to post as soon as we put it on there.
I hate it when people start projects and you don't see any good information
about it for weeks.

Thanks,
Paul Larson

