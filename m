Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVC0RvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVC0RvA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 12:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVC0RvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 12:51:00 -0500
Received: from one.firstfloor.org ([213.235.205.2]:2492 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261233AbVC0Ru4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 12:50:56 -0500
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: Linux 2.4.30-rc2
References: <20050326004631.GC17637@logos.cnet>
	<20050326113426.GO30052@alpha.home.local>
From: Andi Kleen <ak@muc.de>
Date: Sun, 27 Mar 2005 19:50:54 +0200
In-Reply-To: <20050326113426.GO30052@alpha.home.local> (Willy Tarreau's
 message of "Sat, 26 Mar 2005 12:34:26 +0100")
Message-ID: <m1u0mx2d1d.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> writes:

> Marcelo,
>
> just another one and that's all. Zachary Amsden found an unconditional
> write to a debug register in the signal delivery path which is only
> needed when we use a breakpoint. This is a very expensive operation on
> x86, and doing it conditionnaly enhanced signal delivery speed by 33%
> for him.
>
> His patch got merged in 2.6.10, and I've merged it a month ago in my
> local tree. Could we get it in 2.4.30, please ?

I dont think it belongs in 2.4.x. It is not a critical bug fix.

-Andi
