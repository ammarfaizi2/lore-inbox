Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268288AbUIKTFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268288AbUIKTFS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 15:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268290AbUIKTFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 15:05:18 -0400
Received: from [217.132.60.104] ([217.132.60.104]:62341 "EHLO localhost")
	by vger.kernel.org with ESMTP id S268288AbUIKTFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 15:05:09 -0400
Date: Sat, 11 Sep 2004 23:07:53 +0300
From: SashaK <sashak@smlink.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97 
 patch)
Message-ID: <20040911230753.1c1d73de@localhost>
In-Reply-To: <m3k6v0lwwq.fsf@averell.firstfloor.org>
References: <2DdiX-6ye-17@gated-at.bofh.it>
	<2Dfup-7Zv-9@gated-at.bofh.it>
	<m3k6v0lwwq.fsf@averell.firstfloor.org>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 16:09:41 +0200
Andi Kleen <ak@muc.de> wrote:

> SashaK <sashak@smlink.com> writes:
> 
> > You mean to GPL user-space program slmodemd?
> > I think it is good idea, but unfortunately this code is not just my,
> > and final decision was 'no'.
> 
> One way that would work is to make the binary parts of your driver run
> in user space and let the kernel part just provide a kind of simple
> sound card. 

It is done so - user space daemon (with binary part) interacts with ALSA
drivers.

> The later should be much easier to free.

There was such approach, but seems it was wrong.

> The 64bit kernel can run 32bit programs without problems.

This should be possible (don't check yet). But the problem here was
that AMD64 machines are usually based on non-Intel chipsets
(VIA, NVidia), supports for those chipsets were added to ALSA just in
last days. Now it may be tested with recent version of ALSA.

Sasha. 
