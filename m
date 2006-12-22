Return-Path: <linux-kernel-owner+w=401wt.eu-S1946027AbWLVK3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946027AbWLVK3u (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946026AbWLVK3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:29:50 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42101 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1946027AbWLVK3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:29:49 -0500
Date: Fri, 22 Dec 2006 11:29:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Compilation failure in today's git: reiserfs
Message-ID: <20061222102937.GA15168@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I get this one. As I do not need reiserfs, solution is simple for me.

fs/built-in.o: In function `reiserfs_cut_from_item':
(.text+0x60149): undefined reference to `clear_page_dirty'
make: *** [.tmp_vmlinux1] Error 1
9.67user 3.31system 13.06 (0m13.063s) elapsed 99.36%CPU


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
