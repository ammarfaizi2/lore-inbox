Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWA3M3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWA3M3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 07:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWA3M3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 07:29:13 -0500
Received: from mipsfw.mips-uk.com ([194.74.144.146]:35867 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S932213AbWA3M3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 07:29:12 -0500
Date: Mon, 30 Jan 2006 12:25:06 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, hugh@veritas.com,
       linux-kernel@vger.kernel.org, tbm@cyrius.com, t.sailer@alumni.ethz.ch,
       perex@suse.cz
Subject: Re: ALSA on MIPS platform
Message-ID: <20060130122506.GB3816@linux-mips.org>
References: <Pine.LNX.4.61.0601261910230.15596@goblin.wat.veritas.com> <20060128.004540.59467062.anemo@mba.ocn.ne.jp> <s5h7j8l64ua.wl%tiwai@suse.de> <20060130.185608.30186596.nemoto@toshiba-tops.co.jp> <s5hoe1u3to1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hoe1u3to1.wl%tiwai@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 11:18:54AM +0100, Takashi Iwai wrote:

> > I undefined NEED_RESERVE_PAGES on 2.6.15 and it seems OK on MIPS.
> > Thank you.
> 
> Well, as Hugu pointed out, that page reservation plays no longer any
> role.  The patch below should work too on 2.6.15 or later.

That resolves the portability issues with the assumption on the return
value of dma_alloc_coherent(), thanks.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
