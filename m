Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbTAYFVO>; Sat, 25 Jan 2003 00:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbTAYFVN>; Sat, 25 Jan 2003 00:21:13 -0500
Received: from dsl-64-193-97-233.telocity.com ([64.193.97.233]:51620 "EHLO
	xenophon.anabasis.net") by vger.kernel.org with ESMTP
	id <S266186AbTAYFVN>; Sat, 25 Jan 2003 00:21:13 -0500
Date: Fri, 24 Jan 2003 23:30:26 -0600
From: Lawrence Weeks <dev@anabasis.net>
To: linux-kernel@vger.kernel.org
Subject: [Problem] 2.4.18 & 20 spontaneously resetting w/CompactFlash
Message-ID: <20030124233026.A3172@xenophon.anabasis.net>
Reply-To: dev@anabasis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a VIA EPIA mini-ITX system booting from a CompactFlash card via
an IDE adapter. The OS installs to the CF card just fine via a boot
floppy and a kickstart using an NFS server. But once the machine boots
from the CF card, it will either reset part way into the kernel load,
during init, or shortly after going to a login prompt. There are no
error or warning messages, just a sudden reset.

After duplicating this behavior on a second machine, I installed the
same minimal OS on a hard drive, with no issues. I then tried another
brand/speed of CF card, and voila, no more problems. The original cards
(I tried two) were brand-new SimpleTech, 3MB/s cards. The one that
works is an older Lexar, whatever "4x" means, but I know it is slower.

So, my question is, does this sound like a hardware issue, or a
kernel issue? I'd be inclined to say it was hardware. I have googled
extensively but found no others mentioning this problem. However,
the install goes fine, and this resetting happens only after the
kernel begins to boot, no instability before that. Though of course
before that the only thing that happens is grub loads. Any ideas?

Larry
-- 
Lawrence Weeks      "Audaces fortuna juvat."      dev@anabasis.net
