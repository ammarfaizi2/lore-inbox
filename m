Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVGWArx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVGWArx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 20:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVGWArw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 20:47:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30680 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262262AbVGWArv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 20:47:51 -0400
Date: Sat, 23 Jul 2005 02:47:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset VGA adapters via BIOS on resume... (non-fbdev/con)
Message-ID: <20050723004745.GA7868@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.58.0507221942540.5475@skynet> <E1Dw6lc-0007IU-00@chiark.greenend.org.uk> <E1Dw6lc-0007IU-00@chiark.greenend.org.uk> <20050723003140.GB1988@elf.ucw.cz> <E1Dw80M-0001EG-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Dw80M-0001EG-00@chiark.greenend.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Unfortunately, if you only get printk() working after you ran
> > userspace app... well it makes debugging things like SATA
> > "interesting". So I quite like this patch.
> 
> Most interesting laptop vendors have at least one model in each range
> with a serial port, which makes this sort of thing a bit easier. 

Well, we have debugged with beeps, but... It would be cool if someone
got usb debug mode working but... and there are hardware debuggers.

Anyway, this patch is really good, and enables S3 to work on more
machines. Thats good. It is not intrusive and I'll probably (try to)
push it.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
