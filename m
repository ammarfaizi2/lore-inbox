Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTJXW7p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTJXW7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:59:45 -0400
Received: from gprs146-242.eurotel.cz ([160.218.146.242]:31105 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262038AbTJXW7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:59:44 -0400
Date: Sat, 25 Oct 2003 00:59:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jsimmons@infradead.org, kernel list <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Cc: pavel@ucw.cz
Subject: Re: [FBDEV UPDATE] Newer patch. (fwd)
Message-ID: <20031024225931.GC807@elf.ucw.cz>
References: <20031024212201.GK643@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031024212201.GK643@openzaurus.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi folks. 
> 
>   I have a new patch against 2.6.0-test8. This patch is a few fixes and I 
> added back in functionality for switching the video mode for fbcon via 
> fbset again. Give it a try and let me know the results.
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

It has even worse problems with cursor than -test8 (I would not think
that's possible).

Try this for a demo of vga-softcursor problems:

echo -e "\33[10;5000]\33[11;50]\33[?18;0;136c\33[?102m"

... and even during normal boot cursor is corrupted.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
