Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153925AbQAXFNz>; Mon, 24 Jan 2000 00:13:55 -0500
Received: by vger.rutgers.edu id <S153893AbQAXFNk>; Mon, 24 Jan 2000 00:13:40 -0500
Received: from venus.icr.ac.uk ([193.63.217.3]:34528 "EHLO venus.icr.ac.uk") by vger.rutgers.edu with ESMTP id <S153976AbQAXFKX>; Mon, 24 Jan 2000 00:10:23 -0500
Message-ID: <388C1796.53CB67CA@icr.ac.uk>
Date: Mon, 24 Jan 2000 09:12:54 +0000
From: Dr Chris Richardson <foop@icr.ac.uk>
Organization: CSB, Institute of Cancer Research
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Boris Tobotras <tobotras@jet.msk.su>
Cc: Linux-Kernel <linux-kernel@vger.rutgers.edu>
Subject: Re: knfsd and locking w/Solaris server doesn't work
References: <E12BcpV-0007d6-00@david.service.jet.msk.su>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Boris Tobotras wrote:

>         Using fcntl(F_SETLK) fails with following kernel message:
>
> <Problems with Solaris>

I'm aware of problems with knfsd locking for Solaris, OSF/1 and Novell's
NFS for Netware.  I've only got experience with the latter problem, and
heard about the others when I posted to linux-kernel.  It seems to be a
buggy check for read access as "nobody" by knfsd during locking. 
Unfortunately, I do not yet know enough about knfsd to suggest a patch
(although I'm trying to figure it out, because this is a fairly mission
critical bug for my setup).  Since my original post about a week ago,
nobody has suggested any solutions.

Not much help, sorry.

foop
-- 
Dr Chris Richardson - sysadmin, Structural Biology Section, icr.ac.uk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
