Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284693AbRLDAVH>; Mon, 3 Dec 2001 19:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284684AbRLDAPM>; Mon, 3 Dec 2001 19:15:12 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:59520 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S285323AbRLCWu7>;
	Mon, 3 Dec 2001 17:50:59 -0500
Date: Mon, 3 Dec 2001 23:34:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Denis Zaitsev <zzz@cd-club.ru>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] mm/swapfile.c/get_swaparea_info - a cosmetic change
Message-ID: <20011203233413.A125@elf.ucw.cz>
In-Reply-To: <20011201023252.H23346@zzz.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011201023252.H23346@zzz.zzz.zzz>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The header line of /proc/swaps does not match the consequence ones in
> case of devfs' names.  These names are too long in comparison with the
> <Filename> header's part.  So, I've added one tab into the header and
> made the path's part of other lines to be of length 40-1 vs. 32-1.

This is unneccessary interface change in stable series. Don't do
this. At least not in 2.4.X.

								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
