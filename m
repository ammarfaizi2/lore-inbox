Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967396AbWLELGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967396AbWLELGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759946AbWLELGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:06:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53071 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759947AbWLELGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:06:24 -0500
Date: Tue, 5 Dec 2006 12:06:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: ext2 future [was Re: -mm merge plans for 2.6.20]
Message-ID: <20061205110610.GA6987@elf.ucw.cz>
References: <20061204204024.2401148d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> ext2-reservations.patch
> ext2-fix-reservation-extension.patch
> make-ext2_get_blocks-static.patch
> ext2-balloc-fix-_with_rsv-freeze.patch
> ext2-balloc-reset-windowsz-when-full.patch
> ext2-balloc-fix-off-by-one-against-rsv_end.patch
> ext2-balloc-fix-off-by-one-against-grp_goal.patch
> ext2-balloc-say-rb_entry-not-list_entry.patch
> ext2-balloc-use-io_error-label.patch
> 
>  Not for 2.6.20.  In fact it's unclear whether this should ever be merged -
>  ext2 is more an "example filesytem" nowadays.  We'll see.

If ext2 is "example filesystem"... perhaps we should add "no journal"
mode to ext3 or something? We still want high-performance,
not-journalled filesystem, I believe.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
