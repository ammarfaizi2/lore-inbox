Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBOIop>; Thu, 15 Feb 2001 03:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129161AbRBOIof>; Thu, 15 Feb 2001 03:44:35 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:62653 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129104AbRBOIoX>; Thu, 15 Feb 2001 03:44:23 -0500
Date: Thu, 15 Feb 2001 03:54:11 -0500
From: "Michael B. Allen" <mballen@erols.com>
To: linux-kernel@vger.kernel.org
Subject: VIA chipset problems with 2.2?
Message-ID: <20010215035411.A1599@angus.foo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

What's the nature of the VIA chipset problems? I want to get a new system
this weekend but I read on kernel traffic that VIA has problems? I
wan't to use Hendrick's ide patches on 2.2.18. What board should I
get? Help, I've searched through usenet and asked on #linux without
anything conclusive.

Thanks,
Mike

>From KT:

David Riley [*] reported tremendous slowdowns in 2.4.1-pre11 and -pre12
on his Athlon 900 with a KT133 chipset. Mark Hahn [*] replied, "this is
known: Linus decreed that, since two people reported disk corruption
on VIA, any machine with a VIA southbridge must boot in stupid 1992
mode (PIO). (yes, it might be possible to boot with ide=autodma or
something, but who would guess?)" He added to Linus Torvalds [*],
"I hope you don't consider this a releasable state! VIA now owns 40%
of the chipset market..." Linus replied:

  So find somebody who can figure out why the corruption happens, and
  I'll be really happy with a patch that fixes it. In the meantime,
  "releaseable" very much means that we did _everything_ possible to
  make sure that people don't screw their disks over.

  You have to realize that stability takes precedence over EVERYTHING. 

-- 
signature pending
