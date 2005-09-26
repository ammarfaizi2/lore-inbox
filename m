Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbVIZXPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVIZXPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 19:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVIZXPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 19:15:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56987 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932517AbVIZXPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 19:15:48 -0400
Date: Tue, 27 Sep 2005 01:14:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][Fix] swsusp: avoid problems if there are too many pages to save
Message-ID: <20050926231455.GA8635@elf.ucw.cz>
References: <200509252018.36867.rjw@sisk.pl> <200509261454.09702.rjw@sisk.pl> <20050926142608.GA32249@elf.ucw.cz> <200509262129.08316.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509262129.08316.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch makes swsusp avoid problems during resume if there are too many
> pages to save on suspend.  It adds a constant that allows us to verify if we are going to
> save too many pages and implements the check (this is done as early as we can tell that
> the check will trigger, which is in swsusp_alloc()).
> 
> This is to replace swsusp-prevent-swsusp-from-failing-if-theres-too-many-pagedir-pages.patch
> 
> Please consider for applying.

Andrew, if you could apply this one, it would be great. ACKed-by:
Pavel Machek <pavel@suse.cz>

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
