Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUFIOj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUFIOj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 10:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUFIOj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 10:39:28 -0400
Received: from box.punkt.pl ([217.8.180.66]:2573 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S265796AbUFIOjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 10:39:20 -0400
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] linux-libc-headers 2.6.6.0
Date: Wed, 9 Jun 2004 16:37:55 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200406091637.55771.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
Changes:
- updated to 2.6.6 kernel
- readded allmost all of the sound/* headers; some of those contain driver 
specific definitions that might be used in userland apps to control various 
hardware features 
- added scsi headers - more on that below 
- fixed macros in byteorder/swab.h - now hdparm on big endian machines really 
builds
- other fixes (eg. frottle should build)
- I've made linux/audit.h parse out of the box; if I understand correctly this 
is supposed to be a "kernel talks to userland" thing


First of all sorry for the long delay - this version should be here three 
weeks ago, but I've been kind of busy. This shouldn't happen anymore and new 
version should be released no more than a week after the kernel.
(yes, I know 2.6.7 will probably be here in a week or so :)

As for the addition of sanitized scsi headers - I've had some requests for it. 
Up until now I've encountered only one app that wanted something more than 
glibc had to offer and am not entirely sure if using these headers instead of 
glibc's won't break more things than it fixes. Test it if you like and do 
send a bugreport if you find that it breaks something.


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
