Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbUL0PhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbUL0PhQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbUL0PhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:37:15 -0500
Received: from zamok.crans.org ([138.231.136.6]:56790 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261908AbUL0PhC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:37:02 -0500
From: Mathieu Segaud <matt@minas-morgul.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: [OT] Re: 2.6.10 xfs segfault on boot startup?
References: <200412241942.36264.gene.heskett@verizon.net>
Date: Mon, 27 Dec 2004 16:37:00 +0100
In-Reply-To: <200412241942.36264.gene.heskett@verizon.net> (Gene Heskett's
	message of "Fri, 24 Dec 2004 19:42:36 -0500")
Message-ID: <87wtv392hv.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> disait dernièrement que :

> Greetings all;
>
> I just rebooted to a "still got that new car smell" fresh 2.6.10, and 
> this went by on the boot screen while it was starting the various 
> services in init.d:
>
> Starting xfs: /etc/rc3.d/S90xfs: line 137:  2377 Segmentation fault      
> ttmkfdir -d . -o fonts.scale
> /etc/rc3.d/S90xfs: line 137:  2404 Segmentation fault      ttmkfdir 
> -d . -o fonts.scale

it is a userland problem. seems like you have some garbage in your fonts dir.

>
> I had installed some new ttf fonts over the last day or so, and had 
> used them with the beta OOo-1.9-xxx before rebooting from 
> 2.6.10-V0.33-04, but when I did a 'service xfs restart' just before 
> seeing if startx worked (it did obviousy) no further errors were 
> output, and it was running when I did that, so its apparently not 
> repeatable.

I had this message when emerging xorg-x11 on my gentoo box. ttmkfdir does
not seem robust enough when upgrading fonts.

> But it was a bit puzzling.  Anybody have an idea?  Self-healing 
> software, the Holy Grail...
>
> Merry Christmas wishes to all that celebrate it on this list.

thx, merry xmas

-- 
if (!cost_analysis) goto darwinism;

	- Mike Galbraith explaining economics on linux-kernel

