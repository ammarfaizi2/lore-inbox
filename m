Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264425AbTCXVRF>; Mon, 24 Mar 2003 16:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264426AbTCXVRF>; Mon, 24 Mar 2003 16:17:05 -0500
Received: from osiris.silug.org ([64.240.156.225]:55013 "EHLO osiris.silug.org")
	by vger.kernel.org with ESMTP id <S264425AbTCXVRE>;
	Mon, 24 Mar 2003 16:17:04 -0500
Date: Mon, 24 Mar 2003 15:28:13 -0600
From: Steven Pritchard <steve@silug.org>
To: linux-kernel@vger.kernel.org
Subject: 3ware driver errors
Message-ID: <20030324212813.GA6310@osiris.silug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Apparently 3w-xxxx in the Subject gets caught as spam.  Somebody
might want to adjust that regular expression.  :-)

I have a server that is locking up every day or two with a console
full of this error:

    3w-xxxx: scsi0: Command failed: status = 0xcb, flags = 0x37, unit #0.

This is on a Dell PowerEdge 1400SC (dual PIII/1.13GHz, 1.1GB RAM),
with a 3ware Escalade 7000-2 and two WD1600JB drives, running Red Hat
8.0 with kernel-smp 2.4.18-27.8.0.

I plan to report this to Red Hat's bugzilla, but I'm hoping for some
ideas or big red flags to jump out at somebody here...  I use this box
for a UML hosting server, so all this downtime is affecting *way* too
many people.

This box has been having other stability problems, so I'm guessing
this might not be directly related to the 3ware card/driver.  It did
survive a memtest86 pass.

Steve
-- 
steve@silug.org           | Southern Illinois Linux Users Group
(618)398-7360             | See web site for meeting details.
Steven Pritchard          | http://www.silug.org/
