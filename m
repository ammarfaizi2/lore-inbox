Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUGSTQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUGSTQa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 15:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUGSTQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 15:16:30 -0400
Received: from mail.lastar.com ([65.89.139.10]:5387 "HELO server11.lastar.com")
	by vger.kernel.org with SMTP id S264665AbUGSTQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 15:16:28 -0400
Message-ID: <2873B794CB1BE04F80E2968B438680E503ACF5C1@server6.ctg.com>
From: Jason Gauthier <jgauthier@lastar.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7 SMP trouble?
Date: Mon, 19 Jul 2004 15:16:26 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found an IBM netfinity (5600) box that was shelved a few years ago.  I
spent $80 and got two processors for it. (P3-667).

I put them in the box, installed Linux (slackware) and upgraded the kernel
to 2.6.7.  I then started installing my software on it.  Nagios, MRTG,
samba, and some other tools we use for network monitoring.  This is going to
be an upgrade to a monitoring server we have.  Well, I went home, came in
the next day and the box was locked hard.  No messages, no console output.
Just dead.

Thinking it was a fluke, I fired it up.  Again, after several hours running;
total death.  So, I figured I have two options.  Software or hardware is
making it die.  I removed each processor in turn, and ran the box for over
24 hours under HIGH stress. (5+ load average). The system is running the
above mentioned software.  But, just to make sure this processor gets a
workout I am compiling code over and over.  Both processors have been rock
solid for the duration of the test.  

I then placed both processors in the box and started the same test.  It was
dead within 8 hours.  I am now very suspicious of the kernel.

So, I installed 2.4.22 and ran the same tests.  It went over 48 hours with
no issues.  Now I'm certain it's the kernel.  Can anyone confirm any SMP
issues that might cause this?  

Thanks,

Jason

