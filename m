Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTJ3P7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 10:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTJ3P7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 10:59:50 -0500
Received: from janus1.ktb.net ([198.175.228.34]:48146 "EHLO janus1.ktb.net")
	by vger.kernel.org with ESMTP id S262598AbTJ3P7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 10:59:49 -0500
Date: Thu, 30 Oct 2003 07:59:45 -0800
From: ashley@alumni.caltech.edu
To: linux-kernel@vger.kernel.org
Subject: 2.6 crashes when IP-forwarding
Message-ID: <3FA13571.nail4NJ12O97N@alumni.caltech.edu>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry that I can't be more specific now, but I have spent
the last several days trying to track down a kernel-panic problem.
I first thought it was hardware and I swapped it all out.

System:
1.33 MHz Athlon
Asus mb
1Gb memory
either tulip or 8139too ethernet card.

Symptom: system works perfectly with a ppp dialup until
a second machine on the net routes IP requests through
the this machine. Then this machine either crashes with
a kernel panic or simply locks up completely.

I started with the 2.6 test4 kernel which had been working
for several weeks. Then I applied the sequence of patches
all the way up to test9. The system was stable with test4
but unstable with test9.

Then I went back to test4 and applied the patches up
to test7, and the lockup/kernel-panic problem exists
for test7.

Along the way I downloaded all the patches a second time
and tried to verify that the downloads were valid. I
noted that the patch8 is now different from what it was
when I originally downloaded it.

