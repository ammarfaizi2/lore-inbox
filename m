Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310264AbSCGKTf>; Thu, 7 Mar 2002 05:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310270AbSCGKT0>; Thu, 7 Mar 2002 05:19:26 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:5382 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S310264AbSCGKTU>;
	Thu, 7 Mar 2002 05:19:20 -0500
Date: Wed, 6 Mar 2002 23:32:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp eating disks in very strange way
Message-ID: <20020306223212.GA415@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It is ... strange.

I run swsusp patched kernel, do 20 suspend resume cycles. Reboot,
sync, reset button to force fsck.

fsck cames up basically okay.... But when filesystems are mounted, I
see "freeing block not in datazone".

Another sync and reset button, this time fsck manually... Severe
corruption in there. It looks like fsck failed to do its job. This is
ext2.

Strange, *STRANGE*.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
