Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUFHRB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUFHRB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 13:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUFHRB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 13:01:56 -0400
Received: from loki.snap.net.nz ([202.37.101.41]:47881 "EHLO loki.snap.net.nz")
	by vger.kernel.org with ESMTP id S265256AbUFHRBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 13:01:55 -0400
Date: Wed, 9 Jun 2004 05:09:50 +1200 (NZST)
From: Keith Duthie <psycho@albatross.co.nz>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-user@lists.sourceforge.net
Subject: Re: [PATCH] Fix apm suspend with cs4231 based sound cards
In-Reply-To: <s5hpt8b2tg8.wl@alsa2.suse.de>
Message-ID: <Pine.LNX.4.53.0406090457440.27816@loki.albatross.co.nz>
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

I haven't actually tested it yet, but the 2.6.7-rc3 version is changed
enough that the patch I submitted doesn't apply anymore. I'll test it
within the next week or so.

-- 
Just because it isn't nice doesn't make it any less a miracle.
     http://users.albatross.co.nz/~psycho/     O-   -><-
