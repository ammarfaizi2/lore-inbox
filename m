Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269142AbUJERz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269142AbUJERz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269092AbUJERz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:55:26 -0400
Received: from smtp09.auna.com ([62.81.186.19]:8105 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S269081AbUJERyB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:54:01 -0400
Date: Tue, 05 Oct 2004 17:45:02 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: PS2 mouse/kbd problems
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
X-Mailer: Balsa 2.2.5
Message-Id: <1096998302l.5347l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I got time to track my ps2 problems. I run 2.6.9-rc2-mm[123] (that was
enough).

Results:
- mm1: mouse and kbd work ok, both in console and X
- mm2: mouse works, no kbd. I had to unplug/plug the keyboard to get it
  responding.
- mm3: kbd ok, but ps2 mouse is sluggish.

In latest -rc3-mm2, behavior is like mm3 and above.

If you need more info, I have dmesg's, or still can boot on those kernels.
Perhaps this gives some clue. I will scan the changelog for -mm3.

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc3-mm2 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1






