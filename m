Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314241AbSD0PZm>; Sat, 27 Apr 2002 11:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSD0PZm>; Sat, 27 Apr 2002 11:25:42 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16656 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314241AbSD0PZl>; Sat, 27 Apr 2002 11:25:41 -0400
Subject: Re: The tainted message
To: rthrapp@sbcglobal.net (Richard Thrapp)
Date: Sat, 27 Apr 2002 16:20:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel), alan@lxorguk.ukuu.org.uk
In-Reply-To: <1019883102.8819.48.camel@wizard> from "Richard Thrapp" at Apr 26, 2002 11:51:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E171TzX-0008PF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> First of all, the current tainted message is not really useful. 
> "Warning: Loading %s will taint the kernel..." isn't very informative at
> all.  Most people don't know what it means to "taint the  kernel".  It's

I'd agree. I wasn't aware I had any responsibility beyond helping Arjan
who implemented it. The kernel itself has no messages/policy intentionally.

> I would like to propose that a clearer, more direct message be used. 
> Something like "Warning: kernel maintainers may not support your kernel
> since you have loaded %s: %s%s\n" would be much more informative and
> correct.

> Opinions?  Comments?

More informative but I think too soft. It still implies we might want to
hear about it but not reply. That isnt the case.

How about

Warning: The module you have loaded (%s) does not seem to have an open
	 source license. Please send any kernel problem reports to the
	 author of this module, or duplicate them from a boot without
	 ever loading this module before reporting them to the community
	 or your Linux vendor

??
