Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273834AbRI0Tzb>; Thu, 27 Sep 2001 15:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273842AbRI0TzV>; Thu, 27 Sep 2001 15:55:21 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:11298 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273834AbRI0TzL>; Thu, 27 Sep 2001 15:55:11 -0400
Subject: Re: Pentium SSE prefetcht0 instruction... How do you make it work
From: Robert Love <rml@ufl.edu>
To: Tony Hagale <tony@hagale.net>
Cc: Bulent Abali <abali@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0109271335550.4511-100000@hagale.net>
In-Reply-To: <Pine.LNX.4.21.0109271335550.4511-100000@hagale.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.24.08.08 (Preview Release)
Date: 27 Sep 2001 15:55:35 -0400
Message-Id: <1001620540.4649.25.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-27 at 14:43, Tony Hagale wrote:
> Intel's p3/4 prefetch instructions are hints only. They are only executed
> asynchronously, and depend heavily on the other load on the processor at
> the time. They are not required to prefetch, *and* they are not required
> to be executed when you think they should in the flow of the program. You
> can serialize them by using an MFENCE instruction, but they still aren't
> guaranteed to run.
> 
> Check the p4 manuals. In fact, I'm not sure prefetch was implemented in
> p3. I could be wrong, check the manual.

prefetch is in P3 and P4.

there are prefetcht0, prefetcht1, prefetcht2, and prefetchnta
instructions, Intel's programming docs have references on these all
online.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

