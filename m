Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266997AbTGKWrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266998AbTGKWrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:47:04 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:61360 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S266997AbTGKWrC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:47:02 -0400
Date: Sat, 12 Jul 2003 10:45:47 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Thoughts wanted on merging Software Suspend enhancements
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1057963547.3207.22.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

As you may know, there has been a lot of work done on the 2.4 version of
software suspend. This includes:

- async i/o
- back out on errors rather than panicing (where possible)
- enhancements to refrigerator so it successfully freezes processes even
under high load
- save a full image rather than freeing just about all the memory first
- highmem support
- image compression support
- swapfile support in progress
- nice display
- user can abort at any time during suspend (oh, I forgot, I wanted
to...) by just pressing Escape
- extensive debugging info that doesn't need to be compiled in and can
be adjusted during the suspend cycle (very handy for diagnosing issues)

I'm wanting to get your thoughts on how we should go about merging it. I
don't think these qualify as bug fixes, but current users (and I'm not
excluding myself!) would certainly like to see the patch merged sooner
rather than later. Would it be a good idea to seek to get Marcello and
Andrew to take it into 2.4 and 2.6, and then aim for 2.[7|9]?

Regards,

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

