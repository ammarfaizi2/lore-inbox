Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265162AbUFHCnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbUFHCnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 22:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUFHCnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 22:43:40 -0400
Received: from loki.snap.net.nz ([202.37.101.41]:11282 "EHLO loki.snap.net.nz")
	by vger.kernel.org with ESMTP id S265162AbUFHCnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 22:43:40 -0400
Date: Tue, 8 Jun 2004 14:51:49 +1200 (NZST)
From: Keith Duthie <psycho@albatross.co.nz>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-user@lists.sourceforge.net
Subject: Re: [PATCH] Fix apm suspend with cs4231 based sound cards
In-Reply-To: <s5hpt8b2tg8.wl@alsa2.suse.de>
Message-ID: <Pine.LNX.4.53.0406081451230.27816@loki.albatross.co.nz>
References: <Pine.LNX.4.53.0406080319560.27816@loki.albatross.co.nz>
 <s5hpt8b2tg8.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004, Takashi Iwai wrote:

> Could you check whether the recent kernel works without this patch?
> There was a mutex deadlock in the suspend code, and I guess it hit
> you...

Ok, will do.

-- 
Just because it isn't nice doesn't make it any less a miracle.
     http://users.albatross.co.nz/~psycho/     O-   -><-
