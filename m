Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVAPWtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVAPWtg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVAPWtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:49:36 -0500
Received: from gprs215-109.eurotel.cz ([160.218.215.109]:11924 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262634AbVAPWte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:49:34 -0500
Date: Sun, 16 Jan 2005 23:49:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: sparse refuses to work due to stdarg.h
Message-ID: <20050116224922.GA4454@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm probably doing something wrong, but... how do I force it to work?
I'm pretty sure it worked before, I'm not sure what changed in my
config.

pavel@amd:/usr/src/linux$ make C=2
  CHK     include/linux/version.h
  CHECK   scripts/mod/empty.c
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHECK   init/main.c
include/linux/kernel.h:10:11: error: unable to open 'stdarg.h'


								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
