Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVGFXq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVGFXq5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVGFUHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:07:38 -0400
Received: from box3.punkt.pl ([217.8.180.76]:44813 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S262268AbVGFSe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:34:27 -0400
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] linux-libc-headers 2.6.12.0
Date: Wed, 6 Jul 2005 20:30:56 +0200
User-Agent: KMail/1.8
Cc: llh-announce@lists.pld-linux.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507062030.56451.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
Changes:
- updated to 2.6.12
- various C++/ANSI C compatibility fixes
- various small fixes

Sorry for the long delay (2.6.12 was released some time ago), but I've been 
rather busy.

The most interesting changes in this release are the C++/ANSI C compatibility 
fixes mostly provided by Jeff Bailey of Ubuntu/Debian. Jeff also made llh 
klibc compatible, but got missing in action before managing to commit the 
changes (hope he'll reemerge in the near future). Those changes will probably 
break some builds, but I believe klibc compatibility is worth it (afaik llh 
is already used by the uclibc project) and llh is too glibc-centric anyway.

Since I was in a hurry with this release, I've left out some things. If I 
remember correctly, I was bugged about some iproute2 and C++ compatibility 
issues. I'll need to ask the people that bugged me, to do it again (the C++ 
stuff might be solved already, though). This, and the fact that I'll have to 
mess a little with llh's internals (nothing noticeable; assuming I don't 
introduce any new bugs that is :) will probably result in a new release in a 
week or two. So stay tuned.

Oh, and one last thing. I'll be CCing these announcements to 
llh-announce@lists.pld-linux.org (subscription at 
http://lists.pld-linux.org/mailman/listinfo/llh-announce), so anybody 
interested in new releases, but not interested in lkml's traffic, can just 
subscribe there.


Happy summer (of code/sunbaths/or whatever).


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
