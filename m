Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbVIVVMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbVIVVMb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVIVVMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:12:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53379 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030350AbVIVVMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:12:31 -0400
Date: Thu, 22 Sep 2005 23:12:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][Fix] swsusp: do not trigger BUG_ON() if there is not enough memory
Message-ID: <20050922211216.GA1942@elf.ucw.cz>
References: <200509222254.03386.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509222254.03386.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch makes swsusp avoid triggering the BUG_ON() in swsusp_suspend()
> if there is not enough memory for suspend.  Please apply.

Patch is okay. I had fix for same problem, but it was uglyer.

									Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
