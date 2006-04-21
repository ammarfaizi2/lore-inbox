Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWDUTEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWDUTEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWDUTEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:04:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47333 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751202AbWDUTEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:04:51 -0400
Date: Fri, 21 Apr 2006 21:04:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend to RAM bug
Message-ID: <20060421190421.GC2078@elf.ucw.cz>
References: <20060421141342.GF16147@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421141342.GF16147@mail.muni.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> in recent kernel (latest tried 2.6.17-rc1-git5) if I do suspend to disk and then
> suspend to ram, then system freezes. Using sysrq-P I found that it gets stuck
> (endless loop) in ACPI code:

Something for acpi people, I'd say. Ouch, try using shutdown method,
not platform. If it does not help, bugzilla.kernel.org, I'm afraid.

								Pavel
-- 
Thanks for all the (sleeping) penguins.
