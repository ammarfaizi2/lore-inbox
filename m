Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVCGPMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVCGPMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 10:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVCGPMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 10:12:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38596 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261701AbVCGPMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 10:12:43 -0500
Date: Mon, 7 Mar 2005 12:40:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp: allow resume from initramfs
Message-ID: <20050307114028.GA1319@elf.ucw.cz>
References: <20050304101631.GA1824@elf.ucw.cz> <pan.2005.03.06.22.27.36.378400@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2005.03.06.22.27.36.378400@dungeon.inka.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Great, with this patch I can setup an encrypted swap partition,
> and resume from it (after the initramfs asked for the password
> and set up the dm-crypt table).
> 
> But wait, I'm using swapfiles. swap is fine with files.
> what about swsuspend? and if it works with files, too,
> what about this resume interface?

swsusp needs device.

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
