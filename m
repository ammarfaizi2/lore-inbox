Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbTJ0BSA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 20:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263719AbTJ0BSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 20:18:00 -0500
Received: from spock.physics.mcgill.ca ([132.206.92.180]:35205 "EHLO
	spock.physics.mcgill.ca") by vger.kernel.org with ESMTP
	id S263718AbTJ0BR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 20:17:59 -0500
Date: Sun, 26 Oct 2003 20:17:58 -0500
From: Scott Ransom <ransom@physics.mcgill.ca>
To: linux-kernel@vger.kernel.org
Cc: Scott Ransom <ransom@physics.mcgill.ca>
Subject: More 3ware lockups
Message-ID: <20031027011758.GA25377@spock.physics.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I've recently setup a dual Opteron system on a Tyan 2880 (K8S
tested with both the most recent stable and beta bioses) and am
experiencing hard system hangs (the system is completely
inaccessible, no kernel oops, no logging, nothing on the
console) when my 3ware 8506 (8 port) card goes into heavy use.
In particular, a RAID resynch is a sure bet for calamity --
using _either_ software RAID5 or the hardware RAID5).

This happens consistently with a very up-to-date system (Debian
Unstable) and kernels 2.4.22, 2.4.23-pre7 and 2.6.0-test8-bk3.
Each of these kernels and all of the system binaries are 32bit
-- there are other issues in 64bit mode, but I'll save those
for later. I am using the most recent v7.6.4 3ware bios for the
card as well (although the same hangs occurred using the
earlier bios).

Note that the system seems to hang _only_ during heavy 3ware
usage.  Heavy CPU, memory, and/or disk thrashing when the 3ware
module is not loaded causes no problems.

Any ideas of things I can try in order to get more (i.e.
useful) information on the problem?

Scott

-- 
Scott M. Ransom              Address:  McGill Univ. Physics Dept.
Phone:  (514) 398-6492                 3600 University St., Rm 338
email:  ransom@physics.mcgill.ca       Montreal, QC  Canada H3A 2T8 
GPG Fingerprint: 06A9 9553 78BE 16DB 407B  FFCA 9BFA B6FF FFD3 2989
