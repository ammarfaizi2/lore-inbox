Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVBDHuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVBDHuD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVBDHuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:50:02 -0500
Received: from gprs215-248.eurotel.cz ([160.218.215.248]:26809 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262742AbVBDHtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:49:39 -0500
Date: Fri, 4 Feb 2005 08:49:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
Message-ID: <20050204074923.GE1086@elf.ucw.cz>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net> <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net> <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net> <9e47339105020321031ccaabb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105020321031ccaabb@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Reseting a video card from suspend is essentially the same problem as
> reseting secondary video cards on boot. The same code can address both
> problems.

Well, it is made more tricky by the fact that you are running during
resume -- hard to debug. Ideally you want to have video so you can
debug resume of ethernet, disk, etc... But you don't have video :-(.

But I agree, same code should be used.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
