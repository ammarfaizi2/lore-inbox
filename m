Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288642AbSADOOn>; Fri, 4 Jan 2002 09:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288641AbSADOOc>; Fri, 4 Jan 2002 09:14:32 -0500
Received: from hera.cwi.nl ([192.16.191.8]:60618 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S288640AbSADOOU>;
	Fri, 4 Jan 2002 09:14:20 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 4 Jan 2002 14:14:17 GMT
Message-Id: <UTC200201041414.OAA211789.aeb@cwi.nl>
To: farmerduderl@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: dd failure odd sectors, block addressing of 1024 question
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: farmer dude <farmerduderl@yahoo.com>

    [Linux cannot read the last (odd) sector of a disk or partition]

    1.5    Suggested dd problem workarounds
    If you see dd miss that last sector use another tool
    to either capture the last sector or print the
    contents in hex and ASCII.
    Use FreeBSD.

Yes, a well-known problem.

Earlier, it didnt matter too much - the loss of a single sector
of storage is harmless, usual partitioning loses much more -
but nowadays there are several applications that need access
to the last sector of a disk, so this will have to be addressed.

And indeed, it has been addressed, and patches exist,
and some of the relevant patches have been applied already.
There is no reason to expect that this issue will not
go away entirely before 2.6.

Andries
