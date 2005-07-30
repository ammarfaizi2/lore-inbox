Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263065AbVG3Qps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbVG3Qps (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 12:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263066AbVG3Qpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 12:45:47 -0400
Received: from tim.rpsys.net ([194.106.48.114]:5280 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S263065AbVG3Qpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 12:45:45 -0400
Subject: Re: -rc4: arm broken?
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
In-Reply-To: <20050730130406.GA4285@elf.ucw.cz>
References: <20050730130406.GA4285@elf.ucw.cz>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 17:45:37 +0100
Message-Id: <1122741937.7650.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-30 at 15:04 +0200, Pavel Machek wrote:
> I merged -rc4 into my zaurus tree, and now zaurus will not boot. I see
> oops-like display, and it seems to be __call_usermodehelper /
> do_execve / load_script related. Anyone seen it before?

For the record -rc4 works fine on my Zaurus c760 (which is pxa255 based
rather than sa1100).

Does there problem look like http://lkml.org/lkml/2005/7/30/46 ? That
shouldn't be in -rc4 but it in current git. I've sent a fix for this to
Linus/Andrew and LKML but it hasn't appeared for some reason. A link to
the fix is:
http://www.rpsys.net/openzaurus/patches/2.6.13-rc3-mm3_fix-r0.patch

Richard

