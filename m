Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVDWWLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVDWWLx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVDWWKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:10:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28615 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262095AbVDWWIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:08:16 -0400
Date: Sun, 24 Apr 2005 00:07:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: misc cleanups [4/4]
Message-ID: <20050423220757.GD1884@elf.ucw.cz>
References: <200504232320.54477.rjw@sisk.pl> <200504232338.43297.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504232338.43297.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch makes some comments and printk()s in swsusp.c up to date.
> In particular it adds the string "swsusp" before every message that is printed by
> the code in swsusp.c.

I don't like this one. Adding swsusp everywhere just clutters the
screen, most of it should be clear from context.

> @@ -1226,9 +1222,6 @@ static int check_sig(void)
>  
>  /**
>   *	data_read - Read image pages from swap.
> - *
> - *	You do not need to check for overlaps, check_pagedir()
> - *	already did that.
>   */
>  
>  static int data_read(struct pbe *pblist)

Why is this comment no longer valid?
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
