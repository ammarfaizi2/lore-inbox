Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268129AbUHFNNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268129AbUHFNNG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268131AbUHFNNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:13:06 -0400
Received: from dsl-217-155-115-179.zen.co.uk ([217.155.115.179]:20102 "HELO
	felix.billp.org") by vger.kernel.org with SMTP id S268129AbUHFNNA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:13:00 -0400
From: bil@beeb.net
Reply-To: bil@beeb.net
To: linux-kernel@vger.kernel.org
Subject: problems with Mandrake 10.0 + kernel 2.6.8-rc2
Date: Fri, 6 Aug 2004 14:09:56 +0100
User-Agent: KMail/1.6.1
Cc: axboe@suse.de
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408061409.56670.bil@beeb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've recently moved to Mandrake 10.0 (prompted by a defunct hard disk
which neccesitated a complete re-install) and have had several problems.
As a result I have upgraded my kernel from 2.6.3 to 2.6.7 and then 2.6.8-rc2.
Unfortunately the fire may be hotter than the frying-pan (Old English
Proverb) and I'm now in a state where I can't mount CDroms. I can
read the raw device OK, so the basic driver (ide-cd) is OK, or at least
it seems to be. I've added traces to isofs.ko and established that this
initialises OK, but when I attempt to mount the driver it gets a return
code of -EINVAL when it tries to read the superblock (get_sb_bdev?()).

I'm pretty sure that this must be something set up wrong somewhere as
it's unlikely that 2.6.7 (or 2.6.8) would be released without someone
somewhere needing to mount a cdrom, but I have no idea where to go from
here. I am not a kernel-hacker, though I did some many moons ago, but
I know enough to patch and rebuild modules and test them. I took a look at
the source code of ide-cd.c but can't make much sense of the way things are
done these days, and have too many other things to do....
Can anyone give me advice (or even better a fix)?

I'd appreciate being CC'd on any response as I'm not on the
kernel mailing list (too many others to wade through).

Many thanks,

Bill
-- 
+-----------------------------------------------+
| Bill Purvis, thrice-retired software engineer |
| e-mail:  bil@beeb.net                         |
| web:     bil.members.beeb.net                 |
+-----------------------------------------------+
