Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbULEDjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbULEDjb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 22:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbULEDjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 22:39:31 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:16484 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261243AbULEDja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 22:39:30 -0500
Message-ID: <41B282F0.3020704@triplehelix.org>
Date: Sat, 04 Dec 2004 19:39:28 -0800
From: Joshua Kwan <joshk@triplehelix.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Josefsson <gandalf@wlug.westbo.se>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: [PATCH] Fix ALSA resume
References: <1102195391.1560.65.camel@tux.rsn.bth.se> <20041204172855.350100d0.akpm@osdl.org>
In-Reply-To: <20041204172855.350100d0.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> But Joshua crosses his heart and swears that the pci_disable_device() is
> also needed for a successful swsusp resume.

I never said I had any problems with resuming.

That said, I tried removing the pci_disable_device call and things seem
to still work. So I guess it can be left out?

-- 
Joshua Kwan
