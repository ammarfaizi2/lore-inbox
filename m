Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUFEFbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUFEFbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 01:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUFEFbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 01:31:09 -0400
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:21767 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S263204AbUFEFbF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 01:31:05 -0400
Date: Sat, 5 Jun 2004 07:30:52 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: shutdown problem with 2.6.7-rc2 / 2.6.7-rc2-mm2
Message-ID: <20040605053052.GA7825@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both 2.6.7-rc2 and 2.6.7-rc2-mm2 don't shut down my systems anymore.
They print 'System halted.' but don't switch off.

This happens on a P4 (i875 chipset), a dual P3 (BX chipset) and a P3
Tualatin (830 laptop chipset).

I use Debian/Unstable (updated as of yesterday), and this worked on all
these systems with 2.6.6-mm4, mm3, mm2 and so forth, since a long time.

The last thing Debian executes is

halt -d -f -i -p

Compiling with ACPI Debugging on gives no interesting output. I've tried
searching lkml for similar problems, but I didn't found related reports.
Since I have it on three systems, I strongly suspect some change in the
kernel. If nobody pipes up and says 'see this post .....' I'll post my
.config, dmesg etc. but let's try this small post first.

Thanks,
Jurriaan
-- 
Uhm, well, what we are talking about in privy terms, is the very latest
in front-wall fresh air orifices combined with a wide capacity gutter
installation below.
You mean crap out of the window?
	Blackadder II
Debian (Unstable) GNU/Linux 2.6.7-rc2-mm2 2x6062 bogomips load 0.12
