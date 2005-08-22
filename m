Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbVHVWmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbVHVWmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVHVWmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:42:38 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:16268 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751370AbVHVWme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:42:34 -0400
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6: halt instead of reboot
References: <Pine.SOC.4.61.0508202137170.13442@math.ut.ee>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 21 Aug 2005 23:00:37 -0600
In-Reply-To: <Pine.SOC.4.61.0508202137170.13442@math.ut.ee> (Meelis Roos's
 message of "Sat, 20 Aug 2005 21:41:03 +0300 (EEST)")
Message-ID: <m14q9iva4q.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos <mroos@linux.ee> writes:

> I'm currently running 2.6.13-rc6+git as of today and whan I tell my computer to
> reboot, it starts a reboot as sual and when it reached kernel telling
> "Rebooting" the computer halts instead. I noticed it just with an earlier
> post-rc6 snapshot and it's still there with current git.
>
> PC, Duron 1.3 GHz CPU, VIA 686A chipset mainboard. Reboot has worked normally
> before.

Currently this is not enough information to have a clue as to what
is going wrong.  

Does reboot=hard (on the kernel command line) change the behaviour?

Does magic sysrq work after the system hangs?

Can you narrow it down to a -git snapshot where reboot breaks for
you?

The reboot path has been made much more consistent since 2.6.12 and
most of the bugs removed.  But it would not surprise me if some lurking bugs are now
triggering.

Eric

