Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVBHXWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVBHXWC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVBHXWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:22:02 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:32456 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261683AbVBHXV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:21:59 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order allocations on resume [update 2]
Date: Wed, 9 Feb 2005 00:22:52 +0100
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Hu Gang <hugang@soulinfo.com>
References: <200501310019.39526.rjw@sisk.pl> <200502081929.19503.rjw@sisk.pl> <20050208224202.GD1347@elf.ucw.cz>
In-Reply-To: <20050208224202.GD1347@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502090022.52629.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 8 of February 2005 23:42, Pavel Machek wrote:
> Hi!
> 
> > +static inline void eat_page(void *page) {
> 
> Please put { on new line.

Oh, I still tend to forget about this.  Corrected in the patch that is
available on the web
(http://www.sisk.pl/kernel/patches/2.6.11-rc3-mm1/swsusp-use-list-resume-v4.patch).


> Okay, as you can see, I could find very little wrong with this
> patch. That hopefully means it is okay ;-). I should still check error
> handling, but I guess I'll do it when it is applied because it is hard
> to do on a diff. I guess it should go into -mm just after 2.6.11 is
> released...

That would be great!

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
