Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130010AbQLMXxo>; Wed, 13 Dec 2000 18:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131167AbQLMXxf>; Wed, 13 Dec 2000 18:53:35 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:7635 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130010AbQLMXxS>; Wed, 13 Dec 2000 18:53:18 -0500
Message-ID: <3A3804CA.E07FDBB1@haque.net>
Date: Wed, 13 Dec 2000 18:22:50 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: test12 lockups -- need feedback
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At first I thought it was just me when I reported the lockups I was
having with test12 earlier this week. Now the reports are flooding. Of
course, now my machine isn't locking up anymore after recompiling from a
clean source tree (test5 w/ patches through test12)

Now, I'm trying to determine what the common element is.

Those of you who are having lockups, was test12 compiled from a patched
tree that you've previously compiled?

Those that are locking up in X. Do you have a second machine you can
hook up via serial port to grab Oops output?

I've got KDB compiled in my current kernel. I'll compile a fresh kernel
without KDB and see how long I last when I get a chance.
-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
