Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVCRNdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVCRNdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 08:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVCRNdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 08:33:33 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:25063 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261600AbVCRNcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 08:32:08 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] SUSPEND_PD_PAGES-fix
Date: Fri, 18 Mar 2005 14:34:57 +0100
User-Agent: KMail/1.7.1
Cc: coywolf@gmail.com, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050316202800.GA22750@everest.sosdg.org> <20050318113957.GC32253@elf.ucw.cz>
In-Reply-To: <20050318113957.GC32253@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503181434.59214.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 18 of March 2005 12:39, Pavel Machek wrote:
> Hi!
> 
> 
> > This fixes SUSPEND_PD_PAGES, which wastes one page under most cases.
> 
> Ok, applied to my tree, will eventually propagate it. (I hope it looks
> okay to you, rafael).

SUSPEND_PD_PAGES is not necessary in swsusp any more. :-)  We can just
drop it, together with the pagedir_order variable, which is not used.  I'll
send a patch later today.

BTW, I'm going to post some clean ups for swsusp.c, but I'd like the last
changes to settle down in mainline before, if you don't mind.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
