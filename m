Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbVKORDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbVKORDS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbVKORDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:03:18 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:56705 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S964924AbVKORDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:03:17 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.15-rc1-git1: BTTV: no picture with grabdisplay; later, an Oops
Date: Tue, 15 Nov 2005 18:03:12 +0100
User-Agent: KMail/1.8.3
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org,
       mchehab@brturbo.com.br
References: <20051115141305.049CF14200@rhn.tartu-labor> <Pine.LNX.4.61.0511151508110.3622@goblin.wat.veritas.com> <200511151744.04320.baldrick@free.fr>
In-Reply-To: <200511151744.04320.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511151803.13099.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>...
> with this change, I can't get as far as selecting channels (previous situation):
> I consistently get the following Oops on starting xawtv (tried three times).
> However, as well as your change I slimmed down my kernel config and turned on
> CONFIG_DEBUG_PAGEALLOC, so it is not clear whether the change to memory.c is
> responsable.  I will try again, reverting the memory.c change.

Reverting the change, I still get the oops when I start xawtv.  So for the moment
I am unable to say if your suggestion cures the "no picture" problem or not.

Best wishes,

Duncan.
