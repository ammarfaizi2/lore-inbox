Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVJLRKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVJLRKa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVJLRKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:10:30 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:28657 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964802AbVJLRK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:10:29 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "Michael Kerrisk" <mtk-manpages@gmx.net>
Subject: Re: man-pages-2.08 is released
Date: Wed, 12 Oct 2005 10:10:15 -0700
User-Agent: KMail/1.8.91
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       Andries.Brouwer@cwi.nl
References: <434D5224.9754.10AC691@localhost> <30041.1129134415@www32.gmx.net>
In-Reply-To: <30041.1129134415@www32.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510121010.16274.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 12, 2005 9:26 am, Michael Kerrisk wrote:
> This is a request to kernel developers: if you make a change
> to a kernel-userland interface, or observe a discrepancy
> between the manual pages and reality, would you please send
> me (at mtk-manpages@gmx.net ) one of the following
> (in decreasing order of preference):

Would it make sense for some of the man pages (or maybe all of them) that 
correspond directly to kernel interfaces (e.g. syscalls, procfs & sysfs 
descriptions) to be bundled directly with the kernel?  Andrew is 
generally pretty good about asking people to update the stuff in 
Documentation/ when necessary, so maybe the man pages would be kept more 
up to date if developers were forced to deal with them more directly.

OTOH, they comprise a fairly large package, so adding them to the kernel 
tarball would increase its size a lot.

The man pages are great; I'm just thinking that if some of them were 
bundled with the kernel there'd be a bit less work for you to do (just 
proofreading and acking changes hopefully).  Also, if they were there, 
it might motivate people to convert some of the stuff in Documentation 
to section 7 man pages (the janitors have been doing a lot of good 
stuff, maybe that would be another area where they could contribute).

Thanks,
Jesse

