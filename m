Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262625AbSJaPyL>; Thu, 31 Oct 2002 10:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262590AbSJaPyK>; Thu, 31 Oct 2002 10:54:10 -0500
Received: from igw3.watson.ibm.com ([198.81.209.18]:2245 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S262625AbSJaPyJ>; Thu, 31 Oct 2002 10:54:09 -0500
From: bob <bob@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 31 Oct 2002 11:00:15 -0500 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: karim@opersys.com, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, okrieg@watson.ibm.com, okrieg@us.ibm.com,
       frankeh@us.ibm.com, LTT-Dev <ltt-dev@shafik.org>
Subject: LTT for inclusion into 2.5
In-Reply-To: <3DC0A01B.15B8B535@opersys.com>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
	<3DC0A01B.15B8B535@opersys.com>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15809.21188.456354.71271@k42.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

     LTT is one step in allowing Linux to continue to move towards being a
viable alternative for more than just hackers.  It is part of a larger
effort to provide reliability and serviceability.  Concretely it allows
application/subsystem programmers to understand the performance of their
applications and the system.  I should note, it also allows people to
improve kernel behavior as well.  As we have communicated in the past, the
ability to gather and analyze this data is vital.  From my correspondences
with Ingo

"If you care about performance you will want to trace.  On two previous
kernels I have worked on I've heard this comment ["we don't need tracing"].
Once the infrastructure was in it was used and appreciated."  There were
world-class programmers involved in these projects that did not see the
value of such infrastructure until they were able to use it.

I think Karim provided a list of possible uses, there are countless
applications of this - I'll list some more: 
 seeing where unexplained idle tie is occurring
 understanding where interrupt processing time is going
 understanding interactions between applications - which is running when
 etc etc etc

If you look around the kernel, subsystems, and applications, you will find
growing numbers of one-off-ways of gathering this information.  Providing a
unified way for different developers to communicate about performance will
significantly improve the ability to performance debug different
applications, drivers, system/application interaction, etc.

LTT has existed for a long time now and recent additions have been well
motivated: For a while now I have been working with the RAS team at IBM and
with Karim Yaghmour to streamline LTT and make it perform well on MPs.  We
have addressed all the concerns raised by yourself, Ingo, and others from
previous postings.  If there remains concern, it is also possible for one
to disable tracing.  Some of the features we put into LTT came from ideas
we prototyped in K42 (www.research.ibm.com/K42) which in turn was developed
based on my experience writing a tracing infrastructure for IRIX while
working for SGI, and other's experiences with AIX's tracing facilities.

LTT is a valuable aspect in allowing developers using Linux to understand
their application's and the system's behavior.  It serves to strengthen
Linux's RAS capabilities and would be great to get included into 2.5.
Thanks.

Thank you.

Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com

