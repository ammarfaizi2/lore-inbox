Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265965AbTFWGWv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 02:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265969AbTFWGWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 02:22:51 -0400
Received: from dp.samba.org ([66.70.73.150]:16554 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265965AbTFWGWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 02:22:50 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ed Okerson <eokerson@quicknet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: Re: [patch] ixj.c: EXPORT_SYMBOL of static functions 
In-reply-to: Your message of "22 Jun 2003 12:23:07 +0100."
             <1056280986.2075.8.camel@dhcp22.swansea.linux.org.uk> 
Date: Mon, 23 Jun 2003 16:31:42 +1000
Message-Id: <20030623063657.36B612C413@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1056280986.2075.8.camel@dhcp22.swansea.linux.org.uk> you write:
> On Sul, 2003-06-22 at 02:02, Adrian Bunk wrote:
> > drivers/telephony/ixj.c EXPORT_SYMBOL's two static functions.
> > 
> > Does this make any sense or is the patch below OK?
> 
> It's meant to export them. An exported static function is visible to
> other modules.

But only to modules.  In general, exported shouldn't be static.

Someone care to clarify who uses these?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
