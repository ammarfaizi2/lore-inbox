Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268714AbUILNJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268714AbUILNJB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 09:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUILNJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 09:09:00 -0400
Received: from mail1.smlink.com ([212.143.64.225]:55118 "EHLO
	smmail.server.smlink.com") by vger.kernel.org with ESMTP
	id S268714AbUILNI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 09:08:58 -0400
Date: Sun, 12 Sep 2004 16:11:55 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97
 patch)
Message-ID: <20040912161155.47d2c8dc@sashak.lan>
In-Reply-To: <20040912083039.GB87823@muc.de>
References: <2DdiX-6ye-17@gated-at.bofh.it>
	<2Dfup-7Zv-9@gated-at.bofh.it>
	<m3k6v0lwwq.fsf@averell.firstfloor.org>
	<20040911230753.1c1d73de@localhost>
	<20040912083039.GB87823@muc.de>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2004 14:09:03.0555 (UTC) FILETIME=[0F01D930:01C498D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Sep 2004 10:30:39 +0200
Andi Kleen <ak@muc.de> wrote:

> > > The later should be much easier to free.
> > 
> > There was such approach, but seems it was wrong.
> 
> What's the problem exactly - your kernel part is still binary only? 

Current binary kernel part (slamr) is not a problem - it may be removed,
then ALSA drivers will be finished. But user-space program still have
binary code and there is no replacement.

> > 
> > > The 64bit kernel can run 32bit programs without problems.
> > 
> > This should be possible (don't check yet). But the problem here was
> > that AMD64 machines are usually based on non-Intel chipsets
> > (VIA, NVidia), supports for those chipsets were added to ALSA just
> > in last days. Now it may be tested with recent version of ALSA.
> 
> One small issue is that when you have custom ioctls there may 
> be some need to add them to the compat layer, otherwise the user
> space part cannot issue them. This could be even done in a separate 
> module from your driver though.

Thanks for explanations.

Sasha.

