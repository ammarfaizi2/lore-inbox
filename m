Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWC0Jip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWC0Jip (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 04:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWC0Jip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 04:38:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62362 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750712AbWC0Jio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 04:38:44 -0500
Date: Mon, 27 Mar 2006 11:38:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: Re: [2.6 patch] drivers/mtd/mtdcore.c: less PROC_FS=n #ifdef's
Message-ID: <20060327093815.GB14344@elf.ucw.cz>
References: <20060326122504.GI4053@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326122504.GI4053@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 26-03-06 14:25:04, Adrian Bunk wrote:
> I'm surprised that kill-ifdefs-in-mtdcorec.patch in -mm that removes
> #ifdef's for the PROC_FS=n case wasn't tested with PROC_FS=n...

Sorry for that, I somehow assumed it was trivial and did not test it
properly.
								Pavel

-- 
Picture of sleeping (Linux) penguin wanted...
