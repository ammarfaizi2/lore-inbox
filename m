Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbTLISuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266084AbTLISuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:50:06 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:757 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S266063AbTLISuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:50:02 -0500
Date: Tue, 9 Dec 2003 19:50:03 +0100
From: Kristian Peters <kristian.peters@korseby.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org,
       Robert.L.Harris@rdlg.net
Subject: Re: oom killer in 2.4.23
Message-Id: <20031209195003.6b85247b.kristian.peters@korseby.net>
In-Reply-To: <20031209170653.GO12532@dualathlon.random>
References: <Z6Iv-7O2-29@gated-at.bofh.it>
	<Z8Ag-3BK-3@gated-at.bofh.it>
	<Zbyn-23P-29@gated-at.bofh.it>
	<20031205140520.39289a3a.kristian.peters@korseby.net>
	<20031205195800.GB2121@dualathlon.random>
	<20031206103143.027ba4ec.kristian.peters@korseby.net>
	<20031209142151.GB12532@dualathlon.random>
	<Pine.LNX.4.53.0312090942470.8772@chaos>
	<20031209170653.GO12532@dualathlon.random>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: i686 Linux 2.4.23-ck1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> schrieb:
> killing getty is a very very lucky scenario indeed. the way I read it
> was that agetty can hardly be a mem eater, and in turn the same way
> agetty was killed, it could have been ssh or X to be killed. That's
> true, but the same issues on the desktop will happen if you have no swap
> if you enable the old oom killer, the vm will go nuts even if you don't
> run oom, and there will be all other sort of troubles mentioned a few
> times already.

I think getty was respawned but the console was screwed somehow. The screen was all black as with broken framebuffer and I couldn't type anything (even not the "blind" way.). Only X was there.

Thanks for all your answers.

*Kristian
