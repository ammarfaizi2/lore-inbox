Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVDWWGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVDWWGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVDWWGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:06:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28103 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262088AbVDWWGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:06:15 -0400
Date: Sun, 24 Apr 2005 00:05:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: misc cleanups [1/4]
Message-ID: <20050423220555.GC1884@elf.ucw.cz>
References: <200504232320.54477.rjw@sisk.pl> <200504232325.57543.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504232325.57543.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch moves the recalculation of nr_copy_pages so that the
> right number is used in the calculation of the size of memory and swap needed.
> 
> It prevents swsusp from attempting to suspend if there is not enough memory
> and/or swap (which is unlikely anyway).
> 
> Please consider for applying.

Applied to git.

									Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
