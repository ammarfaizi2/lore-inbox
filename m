Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275126AbRKHSbz>; Thu, 8 Nov 2001 13:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277431AbRKHSbp>; Thu, 8 Nov 2001 13:31:45 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:25599 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S275126AbRKHSbk>; Thu, 8 Nov 2001 13:31:40 -0500
Date: Thu, 8 Nov 2001 19:35:11 +0100
From: Peter Seiderer <Peter.Seiderer@ciselant.de>
To: Tobias Diedrich <ranma@gmx.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is the difference between 'login: root' and 'su -' ?
Message-ID: <20011108193511.A632@zodiak.ecademix.com>
In-Reply-To: <20011107184710.A1410@zodiak.ecademix.com> <20011108163821.A26539@router.ranmachan.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011108163821.A26539@router.ranmachan.dyndns.org>; from ranma@gmx.at on Thu, Nov 08, 2001 at 04:38:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 04:38:22PM +0100, Tobias Diedrich wrote:
> Peter Seiderer wrote:
> > Hello,
> > tried today to mkfs.ext2 a partition of my disk and detected there is
> > a little difference between 'login: root' and 'su -'.
> [...]
> > 	--- SIGXFSZ (File size limit exceeded) ---
> > 	+++ killed by SIGXFSZ +++
> 
> I ran into the same Problem in SuSE 7.0 .
> Turned out it was pam_limits.so , try if it works if you comment out the
> line with pam_limits.so in it in /etc/pam.d/su .
> You probably have to recompile the pam libraries.
> 
> -- 
> Tobias								PGP: 0x9AC7E0BC

There is no pam_limits line in my /etc/pam.d/su only in /etc/pam.d/login.
But commenting it out did not help.
Peter

