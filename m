Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154458AbPFAAD2>; Mon, 31 May 1999 20:03:28 -0400
Received: by vger.rutgers.edu id <S153881AbPEaXHn>; Mon, 31 May 1999 19:07:43 -0400
Received: from dukat.scot.redhat.com ([195.89.149.246]:2173 "EHLO dukat.scot.redhat.com") by vger.rutgers.edu with ESMTP id <S154019AbPEaWLX>; Mon, 31 May 1999 18:11:23 -0400
From: "Stephen C. Tweedie" <sct@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14163.6255.462769.27934@dukat.scot.redhat.com>
Date: Tue, 1 Jun 1999 00:17:03 +0100 (BST)
To: "Jeff Merkey" <jmerkey@timpanogas.com>
Cc: "Jim Mostek" <mostek@sgi.com>, <andreas@andreas.org>, <mcai7et2@stud.umist.ac.uk>, <linux-kernel@vger.rutgers.edu>, Stephen Tweedie <sct@redhat.com>
Subject: Re: XFS and journalling filesystems
In-Reply-To: <012201bea93f$db9d1050$e6976dcf@TRGMERKEYNT2000>
References: <199905281653.LAA61598@fsgi344.cray.com> <012201bea93f$db9d1050$e6976dcf@TRGMERKEYNT2000>
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

On Fri, 28 May 1999 13:25:33 -0600, "Jeff Merkey"
<jmerkey@timpanogas.com> said:

> getting the NetWare FS (FENRIS) ready for open source next Tuesday,
> hopefully it may be helpful to all, including you guys -- we are putting ALL
> of it under the GPL (less the NT specific IFS code which is about 18,000
> lines oddly enough)).  Sounds like the term "journalling" is like the term
> "clustering" from an industry perspective, 

No, it is a true transactional journal with ACID semantics.  It just
doesn't necessarily include data.  

> and some FS's aren't really journalled, but reapply this term for
> marketing positioning.  

That is the standard definition of the term in the fs community on
Unix.  Sounds like you are the one trying to redefine it!

> A log based file system that logs user writes and allows rollbacks
> is what most folks assume when the term "journalling" is used.  

No.  You may be thinking of a log-structured filesystem, but that is
_completely_ different from metadata journaling (which of course
doesn't mean that marketing depts don't sometimes try to confuse
them).  An LFS is necessarily journaled, but not all journaled
filesystems are log structured.

--Stephen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
