Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273728AbRIQW3Z>; Mon, 17 Sep 2001 18:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273726AbRIQW3O>; Mon, 17 Sep 2001 18:29:14 -0400
Received: from [194.213.32.137] ([194.213.32.137]:516 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273722AbRIQW3F>;
	Mon, 17 Sep 2001 18:29:05 -0400
Message-ID: <20010918000014.A197@bug.ucw.cz>
Date: Tue, 18 Sep 2001 00:00:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Panic report -- fs corruption with kwintv under 2.2.18-suse
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I bought TVPhone98w/VCR TV tuner card today. I tried it with suse
2.2.18 kernel, and kwintv. It worked beatifully (given that wire I
sticked in to simulate antena, grin). I did cut in kwintv, it
segfaulted and kwintv binary was _gone_.

Reboot, fsck reported "special device/socket/fifo inode 900553 has
non-zero size. FIXED... and kwintv was lost. So I reinstalled it and
retried. On exit kwintv got segfault... And this time kv4lsetup
disappeared. Ouch. (Anyone knows what package kv4lsetup is so I can
reinstall?). I guess I do not want to try kwintv again :-(.

Are similar problems known with 2.2.18? This was really scary.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
