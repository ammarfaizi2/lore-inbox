Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVBHWoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVBHWoe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVBHWnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:43:22 -0500
Received: from gprs215-154.eurotel.cz ([160.218.215.154]:24273 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261644AbVBHWmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:42:19 -0500
Date: Tue, 8 Feb 2005 23:42:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Hu Gang <hugang@soulinfo.com>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order allocations on resume [update 2]
Message-ID: <20050208224202.GD1347@elf.ucw.cz>
References: <200501310019.39526.rjw@sisk.pl> <200502071208.50001.rjw@sisk.pl> <20050207162316.GA8299@elf.ucw.cz> <200502081929.19503.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502081929.19503.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +static inline void eat_page(void *page) {

Please put { on new line.

Okay, as you can see, I could find very little wrong with this
patch. That hopefully means it is okay ;-). I should still check error
handling, but I guess I'll do it when it is applied because it is hard
to do on a diff. I guess it should go into -mm just after 2.6.11 is
released...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
