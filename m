Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUHRSQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUHRSQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267416AbUHRSQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:16:49 -0400
Received: from web11412.mail.yahoo.com ([216.136.131.9]:29809 "HELO
	web11412.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267408AbUHRSQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:16:46 -0400
Message-ID: <20040818181646.28610.qmail@web11412.mail.yahoo.com>
Date: Wed, 18 Aug 2004 11:16:46 -0700 (PDT)
From: Shriram R <shriram1976@yahoo.com>
Subject: Effect of deleting executables of running programs
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Newbie here. I am not sure if I am sending this email
to the right list.  My apologies if I am not and I
would be happy if someone can point me to the right
mailing list.

We have a 24 node/48 processor cluster in our lab with
the following specs.

AMD Athlon
Redhat 7.3
Kernel version - 2.4.19

I had around 10 jobs that had been running on the
cluster for about 15 or so days.  These were
using a common executable "abcd.out" (compiled in
fortran 90).  After they had been running for
about 15 days, I made the mistake of deleting
abcd.out.  Immediately about
3 or 4 of my jobs crashed with a "bus error".  But,
some 6-7 of my jobs
continued running.  I had 2 questions with regards to
this :
 
a) I always thought that once a job is running, the
executable is
   entirely loaded into memory and the abcd.out file
is no longer needed.
   If so, then why does the a running job crash on
deleting abcd.out ?  
 
b) To what extent can I trust that the rest of the 6-7
jobs that are
   running have not been affected by this deletion of
"abcd.out" ?
 
Thanks in advance,
shriram.


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
