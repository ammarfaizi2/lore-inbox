Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754770AbWKNLFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbWKNLFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 06:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754774AbWKNLFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 06:05:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47849 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1754770AbWKNLFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 06:05:54 -0500
Date: Tue, 14 Nov 2006 12:05:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Mikael Pettersson <mikpe@it.uu.se>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] floppy: suspend/resume fix
Message-ID: <20061114110542.GA2242@elf.ucw.cz>
References: <7grMO-2YO-55@gated-at.bofh.it> <7gs69-46A-37@gated-at.bofh.it> <7gtvd-7xg-23@gated-at.bofh.it> <E1GjN7s-00024n-VV@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GjN7s-00024n-VV@be1.lrz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - Even if somebody does this, you can mostly detect the different disk
>   by comparing the first sector or just the FAT "serial number".

Feel free to send a patch; it would be useful, but it would probably
also mean an ugly layering violation.

> I think you should let the user choose which foot to shoot.

-ENOPATCH.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
