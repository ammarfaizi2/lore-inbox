Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268966AbTGOQwS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269008AbTGOQwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:52:17 -0400
Received: from web8104.mail.in.yahoo.com ([203.199.70.104]:27656 "HELO
	web8104.in.yahoo.com") by vger.kernel.org with SMTP id S268966AbTGOQwL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:52:11 -0400
Message-ID: <20030715170658.15459.qmail@web8104.in.yahoo.com>
Date: Tue, 15 Jul 2003 18:06:58 +0100 (BST)
From: =?iso-8859-1?q?shiva=20kumar?= <sivakumar17778@yahoo.co.in>
Subject: [PATCH] kernel/acct.c file,kernel 2.4.18-17.7.x
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I am working on linux kernel ( 2.4.18-17.7.x ).
 
    I have taken a bug ( in 2.4.18-17.7.x ) from
Bugzilla and fixed it.
 
    Bug No is 76268 ( lastcomm does not provide
accurate information compared to /usr/bin/time ).
 
    I am sending the patch with this mail.
***********************************************************************************
    PATCH:
    -----------
diff -ur linux/kernel/acct.c linuxfix/kernel/acct.c

--- linux/kernel/acct.c Tue Mar 20 02:05:08 2001

+++ linuxfix/kernel/acct.c Tue Jun 10 14:05:34 2003

@@ -354,7 +354,7 @@

file = acct_file;

get_file(file);

unlock_kernel();

- do_acct_process(exitcode, acct_file);

+ do_acct_process(exitcode, file);

fput(file);

} else

unlock_kernel();

*******************************************************************************************************

  Please send me the feedback about this.

 

Regards,

Sivakumar

________________________________________________________________________
Send free SMS using the Yahoo! Messenger. Go to http://in.mobile.yahoo.com/new/pc/
