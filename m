Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbUKLHmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbUKLHmg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 02:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbUKLHlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 02:41:47 -0500
Received: from [195.135.223.242] ([195.135.223.242]:1920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262481AbUKLHll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 02:41:41 -0500
Date: Thu, 11 Nov 2004 20:04:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: errors during umount make SysRq fail
Message-ID: <20041111190428.GA997@elf.ucw.cz>
References: <419101BE.1070400@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419101BE.1070400@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> having removed an USB disk while umount for it was still running (yes,
> that was stupid) I noticed that umount for this device hangs forever in
> D state. That would be ok (consequences for user error), however

Actually, I do not think that is okay. USB disk removed while you are
unmounted it is quite simple case of disk error. umount should handle
it.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
