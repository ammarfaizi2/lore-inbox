Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTL2OyN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 09:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTL2OyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 09:54:13 -0500
Received: from [217.73.129.129] ([217.73.129.129]:51587 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263478AbTL2OyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 09:54:10 -0500
Date: Mon, 29 Dec 2003 16:54:05 +0200
Message-Id: <200312291454.hBTEs5J3025023@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Reiserfs-3.6.25 (2.4.21) ., instead of .., rsync Q
To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312290046510.554-100000@poirot.grange>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

GL> After running a machine for some time I've got an empty directory with
GL> ls -a /var/run/sudo/user/ showing
GL> .  .,

Sounds like a single bit error to me.

GL> and
GL> ls -al /var/run/sudo/user/
GL> ls: /var/run/sudo/user/.,: No such file or directory

Sure, because only "." and ".." hash is calculated in a special way.

GL> Don't know if this would be of much help, though - I've already removed
GL> the directory (rmdir worked ok), I had to do a backup, and with that
GL> structure rsync couldn't go further.

What if you try to run memtest86 to see if you have good RAM?

Bye,
    Oleg
