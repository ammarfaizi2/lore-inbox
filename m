Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUBCAAQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUBCAAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:00:16 -0500
Received: from fmr06.intel.com ([134.134.136.7]:49287 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263793AbUBCAAH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:00:07 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Date: Mon, 2 Feb 2004 15:58:56 -0800
Message-ID: <F595A0622682C44DBBE0BBA91E56A5ED1C3662@orsmsx410.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Thread-Index: AcPp3Nu8KvNHAgqLRTK109Lf4IvxPwACfA+Q
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "Troy Benjegerdes" <hozer@hozed.org>,
       <infiniband-general@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Feb 2004 23:58:57.0277 (UTC) FILETIME=[8530FAD0:01C3E9E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We were waiting until we had some version of the InfiniBand code ported
to 2.6 before
asking for it to be included in the 2.6 kernel tree. Jerrie made the
changes
to the IB access layer to allow it to compile on 2.6, but it cannot yet
be tested 
till we get a 2.6 driver from Mellanox. 

I'd also like to hear from the linux-kernel folks on what we would need
to
do to get a basic InfiniBand access layer included in the 2.6 base. 

We'd also like to hear from Mellanox if they have any plans to provide
an open
source VPD driver anytime soon. 

woody



-----Original Message-----
From: infiniband-general-admin@lists.sourceforge.net
[mailto:infiniband-general-admin@lists.sourceforge.net] On Behalf Of
Troy Benjegerdes
Sent: Monday, February 02, 2004 2:31 PM
To: infiniband-general@lists.sourceforge.net;
linux-kernel@vger.kernel.org
Subject: [Infiniband-general] Getting an Infiniband access layer in the
linux kernel


There are 10gigabit ethernet drivers in the kernel.org 2.6, but no
infiniband drivers. Infiniband cards are faster, AND cheaper than 10gig
hardware right now, so this makes no sense.

Has anyone gotten on linux-kernel and asked about what it would take to
get the infiniband access layer into the kernel? (Once that's there we
could *start* talking about IPOIB, and such)

The first, and biggest problem is the access layer is of little use
without a VPD, and since mellanox is the only game in town right now, we
need mellanox to release a VPD that's GPL-compatible. This is mellanox's
problem, so we can't really do anything but tell them to hurry up.

Second is extracting the code into smaller digestible chunks that people
aren't going to scream over. So, can someone tell me how to extract just
the access layer out of the infiniband.bkbits.net tree? I'd like just
enough to be able to run something like NetPIPE on the intel verbs
layer.

And can someone from lkml please respond with suggestions on what would
have a chance of getting blessed with the appropriate penguin-pee?



-- 
------------------------------------------------------------------------
--
Troy Benjegerdes                'da hozer'
hozer@hozed.org  

Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best
answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Shultz


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration See the
breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Infiniband-general mailing list Infiniband-general@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/infiniband-general
