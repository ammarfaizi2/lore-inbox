Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129750AbQJ0Kqr>; Fri, 27 Oct 2000 06:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129866AbQJ0Kqg>; Fri, 27 Oct 2000 06:46:36 -0400
Received: from 24-130-190-89.san.rr.com ([24.130.190.89]:45060 "EHLO
	depraved.org") by vger.kernel.org with ESMTP id <S129750AbQJ0KqU>;
	Fri, 27 Oct 2000 06:46:20 -0400
From: Steven Brown <swbrown@ucsd.edu>
Reply-To: swbrown@ucsd.edu
Date: Fri, 27 Oct 2000 03:46:09 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: /proc/(pid)/mem status and future, or alternatives?
MIME-Version: 1.0
Message-Id: <00102703460900.02088@depraved.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I had noticed that the mmapping facilities of /proc/(pid)/mem have been 
removed in recent devel kernels as well as in the 2.4 test series.  I assume 
that since it is missing in the test series, that it is to be missing in 
2.4.0 final as well.  I poked around on the list archives and found mention 
of its demise, but couldn't find any indication as to if it was a permanent 
removal or if it was just temporary while issues were sorted out, or to 
alternatives to use for the same functionality.  Is there another way to get 
access to another process's memory space in bulk?  I need to do a full search 
on an arbitrary process's memory space.  I've been using 
ptrace(PTRACE_PEEKDATA, ..) in the absense of the ability to mmap the 
process's memory but doing so takes a few million system calls per search 
which is prohibitively expensive.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
