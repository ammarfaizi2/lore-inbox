Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281232AbRKMAGI>; Mon, 12 Nov 2001 19:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281236AbRKMAF7>; Mon, 12 Nov 2001 19:05:59 -0500
Received: from zero.tech9.net ([209.61.188.187]:54290 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281232AbRKMAFp>;
	Mon, 12 Nov 2001 19:05:45 -0500
Subject: [CFT] updated linux kernel preemption patch
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.11.08.57 (Preview Release)
Date: 12 Nov 2001 19:05:25 -0500
Message-Id: <1005609946.815.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated preempt-kernel patches for 2.4.12, 2.4.13, 2.4.14, 2.4.13-ac7
and 2.4.15-pre4 (whew) are available at:

        ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel

There are patches for older kernels, too, but they are not in sync with
this release.

Major change is I merged ARM support.

Thankfully the non-atomic change seems to not of generated _any_
problems.  Good stuff.

Note 2.4.13-ac8 is incompatible with preemption due to the %cr2 task
coloring change.  Since 2.4.15-pre2 looks to be fairly well merged with
Linus, I would recommend using that.

Full ChangeLog:

20011112
- make preempt_enable conditional unlikely
- merge ARM support

20011102
- (ac tree only) back out tty race fix as it was merged with proper

	Robert Love

