Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVDFUDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVDFUDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 16:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVDFUDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 16:03:05 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:58767 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262305AbVDFUC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 16:02:59 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Fwd: [uml-devel] [UML/2.6] -bk7 tree does not run when compiled as SKAS-only
Date: Wed, 6 Apr 2005 22:01:36 +0200
User-Agent: KMail/1.7.2
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504062201.36656.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, could you please put this in your -rc regressions folder? Thanks.

----------  Forwarded Message  ----------

Subject: [uml-devel] [UML/2.6] -bk7 tree does not run when compiled as 
SKAS-only
Date: Tuesday 22 March 2005 18:32
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser 
<bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Just verified that without TT mode enabled, 2.6.11-bk7 tree compiles (when
CONFIG_SYSCALL_DEBUG is disabled) but does not run if when compiled TT mode
was disabled. I've verified this with a clean compile (I had this doubt),
 both with static link enabled and disabled. Sample output:

./vmlinux ubd0=~/Uml/toms.rootfs
Checking for /proc/mm...found
Checking for the skas3 patch in the host...found
Checking PROT_EXEC mmap in /tmp...OK

[end of output]

2.6.11 works in the same situation (both with static link enabled and
disabled).

I'm investigating but busy with other stuff, however there are not many
patches which went in for this release.

Jeff, any ideas?
--
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-------------------------------------------------------

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


