Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWCZJYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWCZJYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 04:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWCZJYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 04:24:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:8174 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751250AbWCZJYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 04:24:53 -0500
Date: Sun, 26 Mar 2006 11:24:15 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linda Walsh <lkml@tlinx.org>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Save 320K on production machines?
In-Reply-To: <4426515B.5040307@tlinx.org>
Message-ID: <Pine.LNX.4.61.0603261122410.22145@yvahk01.tjqt.qr>
References: <4426515B.5040307@tlinx.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> no chances for arbitrary code insertion).

Uh, there is /dev/kmem. Of course it is harder than module loading, but 
it's there.

> ** primarily "funit-at-a-time", though -fweb &
> -frename-registers may add a bit (GCC 3.3.5 as
> patched by SuSE; Maybe extra optimizations could
> be a "CONFIG" option much like regparms is now?

IIRC, -funit-at-a-time with gcc3 made compiled code go bloat.


Jan Engelhardt
-- 
