Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVJaWEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVJaWEp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVJaWEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:04:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17864 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964861AbVJaWEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:04:45 -0500
Date: Mon, 31 Oct 2005 23:04:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@zip.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: rework swsusp_suspend
Message-ID: <20051031220435.GD14877@elf.ucw.cz>
References: <200510311612.59736.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510311612.59736.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch makes only the functions in swsusp.c call functions in
> snapshot.c and not both ways.  It also moves the check for available swap
> out of swsusp_suspend() which is necessary for separating the swap-handling
> functions in swsusp from the core code.

Moving highmem handling code is not neccessary for this goal, right?
Please keep it in place.

(You being x86-64 person, I can understand you don't want it in
snapshot.c ;-)

								Pavel
-- 
Thanks, Sharp!
