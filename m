Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVD1JSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVD1JSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 05:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVD1JSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 05:18:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50615 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261154AbVD1JSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 05:18:44 -0400
Date: Thu, 28 Apr 2005 11:18:43 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, torvalds@osdl.org,
       Greg KH <greg@kroah.com>
Subject: Re: kernel hacker's git howto
Message-ID: <20050428091843.GA18251@pasky.ji.cz>
References: <20050428085657.GA30800@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428085657.GA30800@elf.ucw.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 10:56:57AM CEST, I got a letter
where Pavel Machek <pavel@ucw.cz> told me that...
> To get diff between your working tree and "next tree up", do cg-diff
> -r origin: . If you want to get the same diff but separated
> patch-by-patch, do cg-mkpatch origin: . If you want to pull changes
> from the "up" tree to your working tree, do cg-pull origin followed by
> cg-merge origin.

Note that you can use shortcut:

	cg-update origin

is equivalent to cg-pull && cg-merge.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
