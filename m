Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbVHVWLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVHVWLR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVHVWLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:11:17 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:53638 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750997AbVHVWLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:11:16 -0400
Date: Mon, 22 Aug 2005 13:03:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [patch] only compile kernel/power when neccessary
Message-ID: <20050822110306.GA6739@elf.ucw.cz>
References: <20050822082649.GA5614@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822082649.GA5614@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Only compile kernel/power if sleep support is going to be used.

I'm sorry, this patch is wrong. It broke compilation on ARM. I could
fix it, but then I found out that it is probably not worth the
effort. Only refrigerator stuff can be compiled-out on ARM, and that's
single file. Probably best to revert...

								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
