Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWFZP5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWFZP5q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWFZP5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:57:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53960 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750732AbWFZP5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:57:45 -0400
Date: Mon, 26 Jun 2006 17:57:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Mouse emulation support on x86 boxes
Message-ID: <20060626155736.GA3213@elf.ucw.cz>
References: <4497F8F9.3070904@ed-soft.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4497F8F9.3070904@ed-soft.at>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- linux-2.6.16.1/drivers/macintosh/Kconfig	2006-06-19 09:31:24.000000000 +0200
> +++ linux-2.6.16.1-imac/drivers/macintosh/Kconfig	2006-06-19 09:31:10.000000000 +0200
> @@ -171,6 +171,7 @@
>  
>  config WINDFARM
>  	tristate "New PowerMac thermal control infrastructure"
> +	depends on (PPC_PMAC64 || PPC_PMAC)
>  
>  config WINDFARM_PM81
>  	tristate "Support for thermal management on iMac G5"

This looks very incomplete. We probably do not want ADB subsystem on
intel Mac?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
