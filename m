Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273881AbRKHPjA>; Thu, 8 Nov 2001 10:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274194AbRKHPiu>; Thu, 8 Nov 2001 10:38:50 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:37509 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273881AbRKHPio>; Thu, 8 Nov 2001 10:38:44 -0500
Date: Thu, 8 Nov 2001 16:38:22 +0100
From: Tobias Diedrich <ranma@gmx.at>
To: Peter Seiderer <Peter.Seiderer@ciselant.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is the difference between 'login: root' and 'su -' ?
Message-ID: <20011108163821.A26539@router.ranmachan.dyndns.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	Peter Seiderer <Peter.Seiderer@ciselant.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011107184710.A1410@zodiak.ecademix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011107184710.A1410@zodiak.ecademix.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Seiderer wrote:
> Hello,
> tried today to mkfs.ext2 a partition of my disk and detected there is
> a little difference between 'login: root' and 'su -'.
[...]
> 	--- SIGXFSZ (File size limit exceeded) ---
> 	+++ killed by SIGXFSZ +++

I ran into the same Problem in SuSE 7.0 .
Turned out it was pam_limits.so , try if it works if you comment out the
line with pam_limits.so in it in /etc/pam.d/su .
You probably have to recompile the pam libraries.

-- 
Tobias								PGP: 0x9AC7E0BC
