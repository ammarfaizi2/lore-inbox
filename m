Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUGNMaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUGNMaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUGNMaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:30:25 -0400
Received: from gprs214-9.eurotel.cz ([160.218.214.9]:42112 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267367AbUGNMaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:30:24 -0400
Date: Wed, 14 Jul 2004 14:27:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: netdev@oss.sgi.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040714122738.GF2269@elf.ucw.cz>
References: <20040714114135.GA25175@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714114135.GA25175@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> What is the status of ipw2100? Is there chance that it would be pushed
> into mainline?

Hmm, it has very "nice" interface in proc, where it tells you (in
english *sentences*) if radio kill switch is enabled or not. Ouch.

iwconfig eth1 mode ad-hoc

followed by

iwconfig eth1

makes it crash in ipw2100_wx_get_power called from
wireless_process_ioctl.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
