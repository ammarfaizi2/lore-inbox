Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130690AbRAHTRN>; Mon, 8 Jan 2001 14:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131574AbRAHTRD>; Mon, 8 Jan 2001 14:17:03 -0500
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:28058 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S130690AbRAHTQz>; Mon, 8 Jan 2001 14:16:55 -0500
Date: Mon, 8 Jan 2001 13:16:53 -0600
From: Joseph Pingenot <jap3003@ksu.edu>
To: linux-kernel@vger.kernel.org
Subject: APM, virtual console problem in 2.4.0
Message-ID: <20010108131653.A27992@ksu.edu>
Reply-To: jap3003+response@ksu.edu
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-School: Kansas State University
X-vi-or-emacs: vi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

When suspending my laptop (Toshiba Satellite 1605CDS; BIOS set to
  suspend to disk) with Debian 2.2r2's 'apm -s', the screen blanks
  and then the system locks up hard (not even the power button works).
  In 2.2.17, 'apm -s' works properly, first blanking the screen (maybe
  twice), then (apparently) handing off to the BIOS.  It looks like 
  the handing off isn't reached in 2.4.0; the screen blanks, but 
  it never reaches the BIOS's 'Saving to Disk' screen.
Additionally (included because of the similar symptomology), when
  changing virtual consoles under 2.4.0 and running X (XFree86 3.3.6;
  from Debian 2.2r0), the screen blanks once again, but then the system
  lock up hard, exactly as above.
Any ideas what I might be doing wrong or what needs to be fixed?  If
  I get some time in the next few days, I'll look at the code; but
  school's coming up and I have a lot of work to get done.
I can supply more information if you need it.
Thanks!

                              -Joseph
-- 
Joseph==============================================jap3003@ksu.edu
"I felt a great disturbance in the force.  As if a significant plot
  line suddenly cried out in terror... and was suddenly silenced."
                        -Torg in "Sluggy Freelance" www.sluggy.com.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
