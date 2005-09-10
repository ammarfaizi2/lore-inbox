Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVIJWxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVIJWxb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVIJWxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:53:31 -0400
Received: from tim.rpsys.net ([194.106.48.114]:62186 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932318AbVIJWxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:53:30 -0400
Subject: Re: [patch] Add suspend/resume support to locomo.c
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: John Lenz <lenz@cs.wisc.edu>, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <20050910223805.GC1836@elf.ucw.cz>
References: <20050721052558.GD7849@elf.ucw.cz>
	 <20050904113600.C30509@flint.arm.linux.org.uk>
	 <20050906075853.GA3883@elf.ucw.cz>
	 <41294.192.168.0.13.1126222148.squirrel@192.168.0.2>
	 <20050910223805.GC1836@elf.ucw.cz>
Content-Type: text/plain
Date: Sat, 10 Sep 2005 23:53:15 +0100
Message-Id: <1126392795.8221.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-11 at 00:38 +0200, Pavel Machek wrote:
> [I have just came back from 3 days horse trip... you'll get replies to
> other mails later.]
> 
> There's git tree at www.kernel.org/git ... its called linux-z. It
> worked for before I got to 2.6.13, but it is now broken (IIRC, maybe
> its okay). PCMCIA never worked for me. linux-z is probably good start
> for new work. It should have all your patches IIRC.
> 
> I started work on battery control, and it does something, but I do not
> dare enabling charging juts yet.

It might be worth looking at:

http://www.rpsys.net/openzaurus/patches/sharpsl_pm-r8.patch

This is a more general and much cleaned up version of the Sharp power
management code. I've not studied the collie specifics so I don't know
how adaptable this would be for your uses. Examples of machine specific
support code are:

http://www.rpsys.net/openzaurus/patches/spitz_pm-r3.patch
http://www.rpsys.net/openzaurus/patches/corgi_pm-r3.patch

I'm still cleaning this up but its getting there...

Richard

