Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTJ2AtX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 19:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTJ2AtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 19:49:23 -0500
Received: from www.mail15.com ([62.118.249.44]:61963 "EHLO www.mail15.com")
	by vger.kernel.org with ESMTP id S261797AbTJ2AtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 19:49:13 -0500
Message-ID: <3F9F0E72.2010606@myrealbox.com>
Date: Tue, 28 Oct 2003 16:48:50 -0800
From: walt <wa1ter@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031025 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn Starr <spstarr@sh0n.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PS/2 Slowness w/ 2.6.0-test9-bk2
References: <fa.k5maq39.1h6g0b7@ifi.uio.no>
In-Reply-To: <fa.k5maq39.1h6g0b7@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> Apon trying the latest -bk, I've noticed changes in how the kernel
> determines mouse rate.
> 
> Although this was easy to fix with gpm, XFree86-HEAD does not seem to
> honor any manual overriding of the mouse rate. Even when setting the rate
> to 60 this did not work.
> 
> After reverting the psmouse-base.c changes XFree86 behaved like previous.
> 
> I would suggest reverting the patch until this issue is resolved. I don't
> know what X is doing to get the mouse rate but it certainly ignored it
> when I set psmouse_rate=60 in kernel parameters. Perhaps someone knows
> something I'm not doing...

I have the same problem, but I find that booting with the psmouse_noext
kernel parameter reverses the unwanted behavior.

My other 2.6 machine running with a KVM switch is not at all affected
by the recent change.
