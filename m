Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTL2SFR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 13:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTL2SFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 13:05:17 -0500
Received: from imap.gmx.net ([213.165.64.20]:25809 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263983AbTL2SFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 13:05:11 -0500
X-Authenticated: #20450766
Date: Mon, 29 Dec 2003 19:05:06 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Oleg Drokin <green@linuxhacker.ru>
cc: linux-kernel@vger.kernel.org, <g.liakhovetski@gmx.de>
Subject: Re: Reiserfs-3.6.25 (2.4.21) ., instead of .., rsync Q
In-Reply-To: <200312291454.hBTEspwF025036@car.linuxhacker.ru>
Message-ID: <Pine.LNX.4.44.0312291859310.20257-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003, Oleg Drokin wrote:

> GL> After running a machine for some time I've got an empty directory with
> GL> ls -a /var/run/sudo/user/ showing
> GL> .  .,
>
> Sounds like a single bit error to me.
>
> GL> and
> GL> ls -al /var/run/sudo/user/
> GL> ls: /var/run/sudo/user/.,: No such file or directory
>
> Sure, because only "." and ".." hash is calculated in a special way.
>
> GL> Don't know if this would be of much help, though - I've already removed
> GL> the directory (rmdir worked ok), I had to do a backup, and with that
> GL> structure rsync couldn't go further.
>
> What if you try to run memtest86 to see if you have good RAM?

Hm, you mean it would have gone after a reboot?... No, don't think I tried
to reboot. And, as said above, the directory is gone, so, can't check. I
did try to run the memtest at some point, once it did catch an error...
Well, I guess, we can just archive this error-report for statistical
purposes, but alone it hardly should raise any worries:-)

Thanks and regards
Guennadi
---
Guennadi Liakhovetski


